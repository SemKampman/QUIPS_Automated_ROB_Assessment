#QUIPS_LLM_study
#Creation Date: 6 mar 2026
#Last Updated: 6 mar 2026
#Owners: Sem Kampman, Wim Otte

#PART 2b - kappa scores
#--------------------------------------------------------------------------------------------
  #steps:
  #1 Summaries, plots and kappa
  #2 Evaluate and compare IRR between LLMs and humans for the articles that appear in >1 review
  #this allows us to check internal validity and demonstrate poor IRR of those articles in question
  
  
  #### READ ME READ ME READ ME

  
  #ensure that the duplicates are truly duplicates!!!!!!!!!!!
  # Wang is not!
  
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
library(rstatix)
library(psych)
library (irr)
library (rempsyc)
library(flextable)

out_dirs <- list(
  plots  = here("output", "plots"),
  tables = here("output", "tables"),
  stats  = here("output", "stats"),
  models = here("output", "models")
)

purrr::walk(out_dirs, ~ dir.create(.x, recursive = TRUE, showWarnings = FALSE))
df_merged_long <- readRDS(here("data", "processed_data", "df_merged_long.rds"))
df_merged_wide <- df_merged_long |> 
  select (Study_ID, Risk_Score, LLM_source, Score, Review) |> 
  pivot_wider(
    names_from = LLM_source,
    values_from = Score,
    names_prefix = "LLM_"
  )

#-----------------------------------------------------------------------------------------------
#------------------------------------ STEP 5 - Summaries, Plots, Kappas ------------------------
#-----------------------------------------------------------------------------------------------
df_kappa_ready <- df_merged_wide |> 
  rename (
    llm = LLM_llm,
    human = LLM_human
  )

score_levels <- c("Low", "Moderate", "High")

df_kappa_ready <- df_kappa_ready %>%
  mutate(
    human = factor(human, levels = score_levels, ordered = TRUE),
    llm   = factor(llm,   levels = score_levels, ordered = TRUE)
  )

ratings <- cbind(df_kappa_ready$human, df_kappa_ready$llm)
ratings <- data.frame(
  human = df_kappa_ready$human,
  llm   = df_kappa_ready$llm
)

# Define full scale across entire dataset
all_lvls <- sort(unique(c(df_kappa_ready$human, df_kappa_ready$llm)))

df_kappa_ready <- df_kappa_ready %>%
  mutate(
    human = factor(human, levels = all_lvls, ordered = TRUE),
    llm   = factor(llm,   levels = all_lvls, ordered = TRUE)
  )

kappa_by_review <- df_kappa_ready %>%
  group_by(Review) %>%
  summarise(
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

kappa_by_domain <- df_kappa_ready %>%
  group_by(Risk_Score) %>%
  summarise(
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
  arrange(desc(`kappa, 95% CI`))

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

nice_table(kappa_by_review)

ft_kbr <- flextable(kappa_by_review)
flextable::save_as_docx(
  "Results" = ft_kbr,
  path = "kappa_review.docx"
)

ft_kbd <- flextable(kappa_by_domain)
flextable::save_as_docx(
  "Results" = ft_kbd,
  path = "kappa_domain.docx"
)

####### sub analysis ######
duplicates_df <- df_kappa_ready %>%
  group_by(Study_ID, Risk_Score) %>%   # group by Study_ID AND Domain
  filter(n() > 1) %>%             # only keep duplicates
  arrange(Study_ID, Risk_Score)

duplicates_df <- duplicates_df %>%
  group_by(Study_ID, Risk_Score) %>%
  mutate(version = row_number()) %>%  # 1, 2, 3… per duplicate within domain
  ungroup()

duplicates_df <- duplicates_df |> 
  filter (Study_ID != "Wang_2019" )

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

human_pairwise <- human_long %>%
  pivot_wider(
    names_from = version,       # rater numbers become columns
    values_from = Rating,     # fill with rating values
    names_prefix = "Rating"   # column names: Rating1, Rating2
  )

ratings_h2h <- cbind(human_pairwise$Rating1, human_pairwise$Rating2)
ratings_h2h <- data.frame(
  Human1 = human_pairwise$Rating1,
  Human2   = human_pairwise$Rating2
)

ck_h2h <- cohen.kappa(ratings_h2h, alpha = 0.05) #report both weighted and unweighted? or equal vs squared? 
ck_h2h $kappa            # unweighted kappa estimate
ck_h2h $confid           # lower/upper CIs for unweighted and weighted
ck_h2h $weighted.kappa   # weighted kappa estimate (defaults to squared) 

#should we remove the overlapping duplicate articles from main analysis??
ck <- cohen.kappa(ratings, alpha = 0.05) #report both weighted and unweighted? or equal vs squared? 
ck$kappa            # unweighted kappa estimate
ck$confid           # lower/upper CIs for unweighted and weighted
ck$weighted.kappa   # weighted kappa estimate (defaults to squared) 

#human-llm
# Extract unweighted
k_unw  <- ck$kappa
se_unw <- sqrt(ck$var.kappa)
ci_low_unw  <- k_unw - 1.96 * se_unw
ci_high_unw <- k_unw + 1.96 * se_unw
#Extract weighted
k_w  <- ck$weighted.kappa 
se_w <- sqrt(ck$var.weighted)
ci_low_w  <- k_w - 1.96 * se_w
ci_high_w <- k_w + 1.96 * se_w

#human-human ratings
# Extract unweighted
k_unw_h2h  <- ck_h2h$kappa
se_unw_h2h <- sqrt(ck_h2h$var.kappa)
ci_low_unw_h2h  <- k_unw_h2h - 1.96 * se_unw_h2h
ci_high_unw_h2h <- k_unw_h2h + 1.96 * se_unw_h2h
#Extract weighted
k_w_h2h  <- ck_h2h$weighted.kappa 
se_w_h2h <- sqrt(ck_h2h$var.weighted)
ci_low_w_h2h  <- k_w_h2h - 1.96 * se_w_h2h
ci_high_w_h2h <- k_w_h2h + 1.96 * se_w_h2h


extract_kappas <- function(ratings, label) {
  ck <- cohen.kappa(ratings)
  
  # estimates
  k_unw <- ck$kappa
  k_w   <- ck$weighted.kappa
  
  # SEs from psych (official variance components)
  se_unw <- sqrt(ck$var.kappa)
  se_w   <- sqrt(ck$var.weighted)
  
  # 95% CIs
  ci_unw <- c(k_unw - 1.96*se_unw, k_unw + 1.96*se_unw)
  ci_w   <- c(k_w   - 1.96*se_w,   k_w   + 1.96*se_w)
  
  # p-values (z test)
  p_unw <- 2*(1 - pnorm(abs(k_unw/se_unw)))
  p_w   <- 2*(1 - pnorm(abs(k_w/se_w)))
  
  tibble::tibble(
    Analysis = label,
    Type     = c("Unweighted", "Weighted (squared)"),
    Kappa    = c(k_unw, k_w),
    #SE       = c(se_unw, se_w),
    CI_95    = c(
      sprintf("%.2f (%.2f–%.2f)", k_unw, ci_unw[1], ci_unw[2]),
      sprintf("%.2f (%.2f–%.2f)", k_w,   ci_w[1],   ci_w[2])
    ),
    p_value  = c(p_unw, p_w)
  )
}


tab_main  <- extract_kappas(ratings,  "Main analysis - Human-to-LLM")
tab_main <- tab_main |> 
  mutate (
    Kappa = round (Kappa, 2)
  )
tab_h2h <- extract_kappas(ratings_h2h, "Sensitivity analysis - Human-to-Human")
tab_h2h <- tab_h2h |> 
  mutate (
    Kappa = round (Kappa, 2)
  )


final_table_comp <- dplyr::bind_rows(
  tab_main,
  tab_h2h
)

final_table_comp <- final_table_comp %>%
  mutate(
    p_value = case_when(
      is.na(p_value) ~ NA_character_,
      p_value < 0.001 ~ "<0.001",
      p_value < 0.01  ~ "<0.01",
      p_value < 0.05  ~ "<0.05",
      TRUE            ~ sprintf("%.3f", p_value)
    )
  )

ft_comp <- flextable(final_table_comp)

flextable::save_as_docx(
  "Results" = ft_comp,
  path = "kappa_comp.docx"
)


#should add the number of pairs to this! can do this manually!