#QUIPS_LLM_study
#Creation Date: 6 mar 2026
#Last Updated: 2 sep 2026
#Owners: Sem Kampman, Wim Otte

#PART 3 - kappa scores
#--------------------------------------------------------------------------------------------
  #steps:
  #1 Summaries, plots and kappa
  #2 Evaluate and compare IRR between LLMs and humans for the articles that appear in >1 review
  #this allows us to check internal validity and demonstrate poor IRR of those articles in question
  
  ############
library (readr)
library (tidyverse)
library (stringr)
library (readxl)
library(ggplot2)
library(rstatix)
library(psych)
library (here)
library(ggalluvial)
library (viridis)
library(gt)
library(ggridges)
library(psych)
library (irr)
library (rempsyc)
library(flextable)
library(officer)

######

out_dirs <- list(
  plots  = here("output", "plots"),
  tables = here("output", "tables")
)

purrr::walk(out_dirs, ~ dir.create(.x, recursive = TRUE, showWarnings = FALSE))
#######
#load in data

df_merged_long <- readRDS(here("data", "processed_data", "df_merged_long.rds"))
df_merged_wide <- df_merged_long |> 
  select (Study_ID, Risk_Score, LLM_source, Score, Review) |> 
  pivot_wider(
    names_from = LLM_source,
    values_from = Score,
    names_prefix = ""
  )

#check amount of articles per study
df_merged_long |>
  group_by(Review) |>
  summarise(
    n_unique_studies = n_distinct(Study_ID),
    .groups = "drop"
  )

Verboom_check <- df_merged_long |>
  filter(Review == "Verboom")

Tan_check <- df_merged_long |>
  filter(Review == "Tan")

df_merged_wide|>
  group_by(Review) |>
  summarise(
    n_unique_studies = n_distinct(Study_ID),
    .groups = "drop"
  )

#-----------------------------------------------------------------------------------------------
#---------------- check for consistent scoring, according to algorithm  ------------------------
#-----------------------------------------------------------------------------------------------
compute_final_score <- function(ratings) {
  
  # If any NA in domain ratings → final is NA
  if (any(is.na(ratings))) {
    return(NA_character_)
  }
  
  # Count categories
  n_high  <- sum(ratings == "High")
  n_mod   <- sum(ratings == "Moderate")
  
  if (n_high >= 1) {
    return("High")
  } else if (n_mod >= 3) {
    return("High")
  } else if (n_mod == 2) {
    return("Moderate")
  } else if (n_mod <= 1) {
    return("Low")
  }
}

df_checked <- df_merged_long %>%
  group_by(Review, Study_ID, LLM_source) %>%
  summarise(
    # ✅ extract all domain-level ratings
    domain_ratings = list(Score[Risk_Score != "Overall_Risk"]),
    
    # ✅ extract final given score
    final_given = first(Score[Risk_Score == "Overall_Risk"]),
    
    .groups = "drop"
  ) %>%
  mutate(
    final_expected = map_chr(domain_ratings, compute_final_score),
    is_correct = final_expected == final_given
  )
#-----------------------------------------------------------------------------------------------
#---------------- identify two-step differences  ------------------------
#-----------------------------------------------------------------------------------------------
risk_levels <- c("Low", "Moderate", "High")
df_two_step <-  df_merged_wide |>
mutate(
Risk1_ord = factor(human, levels = risk_levels, ordered = TRUE),
Risk2_ord = factor(llm, levels = risk_levels, ordered = TRUE),
# convert to integer scale (1, 2, 3)
Risk1_num = as.numeric(Risk1_ord),
Risk2_num = as.numeric(Risk2_ord),
# compute absolute difference
diff_steps = abs(Risk1_num - Risk2_num),
two_step_disagreement = diff_steps == 2
) %>%
  filter(two_step_disagreement == TRUE)

df_two_step_all <-  df_two_step  |> 
  mutate(
    Risk1_ord = factor(human, levels = risk_levels, ordered = TRUE),
    Risk2_ord = factor(llm, levels = risk_levels, ordered = TRUE),
    # convert to integer scale (1, 2, 3)
    Risk1_num = as.numeric(Risk1_ord),
    Risk2_num = as.numeric(Risk2_ord),
    # compute absolute difference
    diff_steps = abs(Risk1_num - Risk2_num),
    two_step_disagreement = diff_steps == 2
  ) %>%
  filter(two_step_disagreement == TRUE)

df_two_step_all_clean <- df_two_step_all |> 
  select (-Risk1_ord, -Risk2_ord, -Risk1_num, -Risk2_num, -diff_steps, -two_step_disagreement) |> 
  rename (human_rating = human,
          LLM_rating = llm)

two_step_counts <- df_two_step_all %>%
  count(Risk_Score, name = "n_two_step")

total_counts <- df_two_step  |>
  mutate(
    Risk1_ord = factor(human, levels = risk_levels, ordered = TRUE),
    Risk2_ord = factor(llm, levels = risk_levels, ordered = TRUE),
    Risk1_num = as.numeric(Risk1_ord),
    Risk2_num = as.numeric(Risk2_ord),
    diff_steps = abs(Risk1_num - Risk2_num),
    two_step_disagreement = diff_steps == 2
  ) |> 
  count(Risk_Score, name = "n_total_pairs")

total_counts_clean <- df_merged_wide %>%
  count(Risk_Score, name = "n_all_pairs")

two_step_counts <- df_two_step_all %>%
  count(Risk_Score, name = "n_two_step")

df_two_step_summary <- total_counts_clean %>%
  left_join(two_step_counts, by = "Risk_Score") %>%
  mutate(
    n_two_step = replace_na(n_two_step, 0),
    prop_two_step = n_two_step / n_all_pairs
  )

ft_two_step_summary <- flextable (df_two_step_summary)
#### these are crucial for our manual verification!
#-----------------------------------------------------------------------------------------------
#------------------------------------  Summaries and Plots ------------------------
#-----------------------------------------------------------------------------------------------
score_levels <- c("Low", "Moderate", "High")

df_kappa_ready <- df_merged_wide  %>%
  mutate(
    human = factor(human, levels = score_levels, ordered = TRUE),
    llm   = factor(llm,   levels = score_levels, ordered = TRUE)
  )
#-----------------------------------------------------------------------------------------------
#------------------------------------  Kappa across reviews  ------------------------
#-----------------------------------------------------------------------------------------------
kappa_by_review <- df_kappa_ready %>%
  filter(Risk_Score == "Overall_Risk") %>%
  group_by(Review) %>%
  summarise(
    n_pairs = n(),
    {
      
      
      # SQUARED weighted kappa (default)
      ck_sq <- cohen.kappa(
        cbind(human, llm))
      # squared weighting is default
      k_sq  <- ck_sq$weighted.kappa
      
      # use official variance from psych
      se_sq <- sqrt(ck_sq$var.weighted)
      
      # 95% CI
      ci_low  <- k_sq - 1.96 * se_sq
      ci_high <- k_sq + 1.96 * se_sq
      
      
      tibble(
        kappa_squared = k_sq,
        ci_lower = round(ci_low, 2),
        ci_upper = round(ci_high, 2),
        `kappa, 95% CI` = sprintf("%.2f (%.2f–%.2f)", k_sq, ci_low, ci_high)
      )
    }
  )

kappa_by_review <- kappa_by_review |> 
  select (-ci_lower, -ci_upper)

kappa_by_review <- kappa_by_review %>%
  arrange(desc(`kappa, 95% CI`))
#-----------------------------------------------------------------------------------------------
#------------------------------------  Kappa across domains  ------------------------
#-----------------------------------------------------------------------------------------------
kappa_by_domain <- df_kappa_ready %>%
  group_by(Risk_Score) %>%
  summarise(
      n_pairs = n(),
    {
      
      # SQUARED weighted kappa (default)
      ck_sq <- cohen.kappa(
        cbind(human, llm))
      # squared weighting is default
      k_sq  <- ck_sq$weighted.kappa
      
      # use official variance from psych
      se_sq <- sqrt(ck_sq$var.weighted)
      
      # 95% CI
      ci_low  <- k_sq - 1.96 * se_sq
      ci_high <- k_sq + 1.96 * se_sq
      
      
      tibble(
        kappa_squared = k_sq,
        ci_lower = round(ci_low, 2),
        ci_upper = round(ci_high, 2),
        `kappa, 95% CI` = sprintf("%.2f (%.2f–%.2f)", k_sq, ci_low, ci_high)
      )
    }
  )

kappa_by_domain <- kappa_by_domain|> 
  select (-ci_lower, -ci_upper)

kappa_by_domain<- kappa_by_domain %>%
  arrange(Risk_Score)
#-----------------------------------------------------------------------------------------------
#------------------------------------  Kappa interpret  ------------------------
#-----------------------------------------------------------------------------------------------
kappa_interpret <- function(x) {
  cut(x,
      breaks = c(-Inf, 0, 0.2, 0.4, 0.6, 0.8, 1),
      labels = c("Poor", "Slight", "Fair", "Moderate", "Substantial", "Almost perfect"),
      right = TRUE
  )
}

kappa_by_domain <- kappa_by_domain %>%
  mutate(
    Agreement   = kappa_interpret(kappa_squared)
  )|> select (-kappa_squared)

kappa_by_review <- kappa_by_review %>%
  mutate(
    Agreement   = kappa_interpret(kappa_squared)
  ) |> select (-kappa_squared)

ft_kbr <- flextable(kappa_by_review)
ft_kbd <- flextable(kappa_by_domain)
#-----------------------------------------------------------------------------------------------
#------------------------------------  Kappa, human-human
# the imperfect reference standard!   ------------------------
#-----------------------------------------------------------------------------------------------
duplicates_df <- df_kappa_ready %>%
  group_by(Study_ID, Risk_Score) %>%   # group by Study_ID AND Domain
  filter(n() > 1) %>%             # only keep duplicates
  arrange(Study_ID, Risk_Score)

duplicates_df <- duplicates_df %>%
  group_by(Study_ID, Risk_Score) %>%
  mutate(version = row_number()) %>%  # 1, 2, 3… per duplicate within domain
  ungroup()

duplicates_df <- duplicates_df |> 
  filter (Study_ID != "Wang_2019" ) #this is NOT a duplicate, despite same StudyID

human_comparison_table <- duplicates_df %>%
  select(Study_ID, Risk_Score, version, human) %>%
  pivot_wider(
    names_from = Risk_Score,               # Review number becomes column names
    values_from = human   
  )

cols_domains = c("D1_Risk", "D2_Risk", "D3_Risk", "D4_Risk", "D5_Risk", "D6_Risk", "Overall_Risk")
  
human_long <- human_comparison_table %>%  # your wide table
  pivot_longer(
    cols = cols_domains,   # all columns except Rater
    names_to = "Risk_Score", # column name for domain
    values_to = "Rating"  # column name for ratings
  )

kappa_comp_final <- human_long %>%
  pivot_wider(
    names_from = version,
    values_from = Rating,
    names_prefix = "Rating"
  ) %>%
  filter(!is.na(Rating1), !is.na(Rating2)) %>%
  group_by(Risk_Score) %>%
  summarise(
    n_pairs = n(),
    {
      ck <- cohen.kappa(cbind(Rating1, Rating2))
      
      kappa <- ck$weighted.kappa
      se    <- sqrt(ck$var.weighted)
      
      ci_low  <- kappa - 1.96 * se
      ci_high <- kappa + 1.96 * se
      
      pct_agree <- mean(Rating1 == Rating2) * 100   # raw % agreement
      
      tibble(
        pct_agreement   = round(pct_agree, 1),
        kappa_weighted  = round(kappa, 2),
        ci_low          = round(ci_low, 2),
        ci_high         = round(ci_high, 2),
        kappa_95CI      = sprintf("%.2f (%.2f–%.2f)", kappa, ci_low, ci_high)
      )
    }
  )

ft_kappa_comp <- flextable(kappa_comp_final)
#-----------------------------------------------------------------------------------------------
#------------------------------------  Save outputs!  ------------------------
#-----------------------------------------------------------------------------------------------
tables_list <- list(
  ft_kbr = ft_kbr,
  ft_kbd = ft_kbd,
  ft_kappa_comp = ft_kappa_comp,
  ft_two_step_summary  = ft_two_step_summary
)

save_flextables <- function(tables_list, dir) {
  
  for (name in names(tables_list)) {
    
    ft <- tables_list[[name]]
    filename <- paste0(name, ".docx")   # 👈 use original name
    
    doc <- read_docx()
    doc <- body_add_flextable(doc, ft)
    print(doc, target = file.path(dir, filename))
  }
}

save_flextables(tables_list, out_dirs$tables)