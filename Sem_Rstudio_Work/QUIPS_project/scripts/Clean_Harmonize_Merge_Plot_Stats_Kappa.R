#QUIPS_LLM_study
#Creation Date: 5 jan 2026
#Last Updated: 7 jan 2026
#Owners: Sem Kampman, Wim Otte

--------------------------------------------------------------------------------------------
#steps:
  #1 Import LLM datasets
  #2 Clean LLM data
  #3 Merge LLM datasets
  #4 Import and merge GS datasets
  #5 Summaries, plots and kappa

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

setwd("/Users/sem.l.kampman/Documents/GitHub/quips/quips_private/Sem_Rstudio_Work/QUIPS_project")

out_dirs <- list(
  plots  = here("output", "plots"),
  tables = here("output", "tables"),
  stats  = here("output", "stats"),
  models = here("output", "models")
)

purrr::walk(out_dirs, ~ dir.create(.x, recursive = TRUE, showWarnings = FALSE))

#-----------------------------------------------------------------------------------------------
#------------------------------------ STEP 1 - Import LLM datasets -----------------------------
#-----------------------------------------------------------------------------------------------

df_Adan <- read_tsv("~/Documents/GitHub/quips/quips_private/outputs/2_Adan_2025/quips_summary_Adan_v2.tsv")
df_Giuliano <- read_tsv("~/Documents/GitHub/quips/quips_private/outputs/1_Giuliano_2021/quips_summary_Giuliano.tsv")
df_West <- read_tsv("~/Documents/GitHub/quips/quips_private/outputs/5_West_2019/quips_summary_West.tsv")
df_Arfaie <- read_tsv("~/Documents/GitHub/quips/quips_private/outputs/3_Arfaie_2023/quips_summary_Arfaie.tsv")
df_Wassenaar<- read_tsv("~/Documents/GitHub/quips/quips_private/outputs/4_Wassenaar_2019/quips_summary_Wassenaar.tsv")

#-----------------------------------------------------------------------------------------------
#------------------------------------ STEP 2 - Clean LLM datasets ------------------------------
#-----------------------------------------------------------------------------------------------

Review_Adan <- "Adan"
df_Adan_clean <- df_Adan |> 
  select (filename, Overall_Risk, D1_Risk, D2_Risk, D3_Risk, D4_Risk, D5_Risk, D6_Risk) |> 
  mutate(clean = str_remove(filename, "^scoring_"),
         clean = str_remove(clean, "\\.json$")) %>%
  separate(clean, into = c("author", "year"), sep = "_(?=[^_]+$)") %>%
  mutate(
    Study_ID = paste(author, year, sep = "_"),
    Year = as.integer(year),
    Review = Review_Adan
  ) 

df_Adan_clean <- df_Adan_clean %>%
  relocate(Study_ID, Year, Review, .before = 1) |> 
  select (-filename, -year)

Review_Arfaie <- "Arfaie"
df_Arfaie_clean <- df_Arfaie |> 
  select (filename, Overall_Risk, D1_Risk, D2_Risk, D3_Risk, D4_Risk, D5_Risk, D6_Risk) |> 
  mutate(clean = str_remove(filename, "^scoring_"),
         clean = str_remove(clean, "\\.json$")) %>%
  separate(clean, into = c("author", "year"), sep = "_(?=[^_]+$)") %>%
  mutate(
    Study_ID = paste(author, year, sep = "_"),
    Year = as.integer(year),
    Review = Review_Arfaie
  ) 

df_Arfaie_clean <- df_Arfaie_clean %>%
  relocate(Study_ID, Year, Review, .before = 1)|> 
  select (-filename, -year)

Review_Giuliano<- "Giuliano"
df_Giuliano_clean <- df_Giuliano |> 
  select (filename, Overall_Risk, D1_Risk, D2_Risk, D3_Risk, D4_Risk, D5_Risk, D6_Risk) |> 
  mutate(clean = str_remove(filename, "^scoring_"),
         clean = str_remove(clean, "\\.json$")) %>%
  separate(clean, into = c("author", "year"), sep = "_(?=[^_]+$)") %>%
  mutate(
    Study_ID = paste(author, year, sep = "_"),
    Year = as.integer(year),
    Review = Review_Giuliano
  ) 

df_Giuliano_clean <- df_Giuliano_clean %>%
  relocate(Study_ID, Year, Review, .before = 1)|> 
  select (-filename, -year)

Review_Wassenaar <- "Wassenaar"
df_Wassenaar_clean <- df_Wassenaar |> 
  select (filename, Overall_Risk, D1_Risk, D2_Risk, D3_Risk, D4_Risk, D5_Risk, D6_Risk) |> 
  mutate(clean = str_remove(filename, "^scoring_"),
         clean = str_remove(clean, "\\.json$")) %>%
  separate(clean, into = c("author", "year"), sep = "_(?=[^_]+$)") %>%
  mutate(
    Study_ID = paste(author, year, sep = "_"),
    Year = as.integer(year),
    Review = Review_Wassenaar
  ) 

df_Wassenaar_clean <- df_Wassenaar_clean %>%
  relocate(Study_ID, Year, Review, .before = 1)|> 
  select (-filename, -year)

Review_West <- "West"
df_West_clean <- df_West  |> 
  select (filename, Overall_Risk, D1_Risk, D2_Risk, D3_Risk, D4_Risk, D5_Risk, D6_Risk) |> 
  mutate(clean = str_remove(filename, "^scoring_"),
         clean = str_remove(clean, "\\.json$")) %>%
  separate(clean, into = c("author", "year"), sep = "_(?=[^_]+$)") %>%
  mutate(
    Study_ID = paste(author, year, sep = "_"),
    Year = as.integer(year),
    Review = Review_West 
  ) 

df_West_clean <- df_West_clean %>%
  relocate(Study_ID, Year, Review, .before = 1)|> 
  select (-filename, -year)

#-----------------------------------------------------------------------------------------------
#------------------------------------ STEP 3 - Merge and Harmonize LLM data --------------------
#-----------------------------------------------------------------------------------------------

df_merged_LLMs <- bind_rows (df_Adan_clean, df_Arfaie_clean, df_Giuliano_clean, df_Wassenaar_clean, df_West_clean)

df_merged_LLMs <- df_merged_LLMs |> 
  mutate (across (c(Overall_Risk, D1_Risk, D2_Risk, D3_Risk, D4_Risk, D5_Risk, D6_Risk), ~ factor (.x, levels = (c("Low", "Moderate", "High")), ordered = TRUE)))

df_merged_LLMs <- df_merged_LLMs |> 
  mutate(LLM_source = 1) |> 
  relocate (LLM_source, .before = 1
             ) |> 
  select (-author)

str (df_merged_LLMs)

#-----------------------------------------------------------------------------------------------
#------------------------------------ STEP 4 - Import Gold Standard data and merge--------------
#-----------------------------------------------------------------------------------------------
df_merged_GS <- read_excel("~/Documents/GitHub/quips/quips_private/Kappa_scoring/Gold_Standard_Overview.xlsx")

df_merged_GS <- df_merged_GS |> 
  mutate(clean = str_remove(Study_ID, "^scoring_"),
         clean = str_remove(clean, "\\.json$")) |> 
  separate(clean, into = c("author", "year"), sep = "_(?=[^_]+$)") |> 
  mutate(
    Study_ID = paste(author, year, sep = "_"),
    Year = as.integer(year),
  )  |> 
  relocate(LLM_source,Study_ID, Year, Review, .before = 1) |> 
  select (-year, -author)
  
df_merged_GS <- df_merged_GS |> 
  mutate(across(where(is.character), ~ gsub("Giuliani", "Giuliano", .)))

df_merged_GS <- df_merged_GS |> 
  mutate (across (c(Overall_Risk, D1_Risk, D2_Risk, D3_Risk, D4_Risk, D5_Risk, D6_Risk), ~ factor (.x, levels = (c("Low", "Moderate", "High")), ordered = TRUE)))

str (df_merged_GS)
str (df_merged_LLMs)

df_merged_Kappa <- bind_rows (df_merged_GS, df_merged_LLMs)

risk_scores <- c("Overall_Risk", "D1_Risk", "D2_Risk", "D3_Risk", "D4_Risk", "D5_Risk", "D6_Risk")
df_merged_Kappa_long <- df_merged_Kappa |> 
  pivot_longer(
    cols = all_of(risk_scores),
    names_to = "Risk_Score",
    values_to = "Score"
  )
#-----------------------------------------------------------------------------------------------
#------------------------------------ STEP 5 - Summaries, Plots, Kappas ------------------------
#-----------------------------------------------------------------------------------------------
df_merged_Kappa_long_summary <- df_merged_Kappa_long |> 
  group_by(Risk_Score, LLM_source, Score) %>%
  summarise(n = n(), .groups = "drop") %>%
  group_by(Risk_Score, LLM_source) %>%
  mutate(prop = n / sum(n)) 

df_merged_Kappa_wide_summary_ <- df_merged_Kappa_long_summary |> 
  pivot_wider(names_from = Score, values_from = c(n, prop))


#Wilcox signed-rank test (paired samples, ordinal outcomes)
df_merged_Kappa_long_numeric <- df_merged_Kappa_long %>%
  mutate (Score_num = as.integer(Score))

wilcox_test_saved <- df_merged_Kappa_long_numeric |> 
  group_by(Risk_Score) |> 
  wilcox_test(Score_num ~ LLM_source, paired = TRUE)

wilcox_test_saved <- wilcox_test_saved |> 
  mutate(
    p_readable = case_when(
      p < 0.001 ~ "< 0.001",
      p < 0.01  ~ "< 0.01",
      p < 0.05  ~ "< 0.05",
      TRUE      ~ format(round(p, 3), nsmall = 3)
    )
  )

wilcox_test_table <- wilcox_test_saved |>
  select(Risk_Score, p_readable) |> 
  # 1. Add agreement labels
  mutate(
    Risk_Score = gsub("_", " ", Risk_Score)
  ) |>
  # 3. Start GT table
  gt() |>
  fmt_number(columns = p_readable, decimals = 3) |>
  cols_label(
    Risk_Score = "Domain",
    p_readable= "p-value"
  ) |>
  tab_header(title = "Wilcoxon signed-rank test by Domain") |>
  
  # 4. Bold the table title
  tab_style(
    style = cell_text(weight = "bold", size = px(18)),
    locations = cells_title(groups = "title")
  )

wilcox_test_table 

#D2, D3, D6 seem to be statistically significant!


gtsave (
  wilcox_test_table ,
  file.path(out_dirs$tables, "wilcox_test_table.png")
)

write.csv(
  wilcox_test_saved,
  file.path(out_dirs$stats, "wilcox_score_by_source.csv"),
  row.names = FALSE
)

capture.output(
  wilcox_test_saved,
  file = file.path(out_dirs$stats, "wilcox_score_by_source.txt")
)

saveRDS (
  wilcox_test_saved, 
  file = file.path(out_dirs$stats, "wilcox_score_by_source.rds")
)


stacked_proportions_plot <- ggplot(df_merged_Kappa_long, aes(x = factor(LLM_source), fill = Score)) +
  geom_bar(position = "fill") +             # stacked proportions
  facet_wrap(~ Risk_Score, scales = "free_y", labeller = as_labeller(c("D1_Risk" = "D1 Risk", "D2_Risk" = "D2 Risk", "D3_Risk" = "D3 Risk", "D4_Risk" = "D4 Risk", "D5_Risk" = "D5 Risk", "D6_Risk" = "D6 Risk", "Overall_Risk" = "Overall Risk"))) +  # one panel per risk score
  scale_y_continuous(labels = scales::percent_format()) +
  scale_x_discrete(labels = c("0" = "Human", "1" = "LLM")) + #scale_x_discrete allows for labels
  labs(
    x = "Source",
    y = "Percentage of Studies",
    fill = "Score"
  ) +
  theme_minimal() +
  scale_fill_manual(values = c("lightblue", "gold", "salmon")) +
  ggtitle("Distribution of Risk Scores by Source") + 
  theme (
    strip.text = element_text(face="bold", size =12)
  )

stacked_proportions_plot

ggsave(
  filename = file.path(out_dirs$plots, "stacked_proportions.png"),
  plot = stacked_proportions_plot,
  width = 6, height = 4, dpi = 300
)

#distribution with rank

violin_plot <- df_merged_Kappa_long_numeric |> 
  filter(!is.na(Risk_Score)) |> 
  ggplot(aes(
    x = factor(LLM_source), 
    y = Score_num, 
    fill = factor(LLM_source)
    )) +
  geom_violin(trim = FALSE, alpha = 0.5) +
  geom_boxplot(width = 0.2, position = position_dodge(0.9)) +
  facet_wrap(~ Risk_Score, 
             scales = "free_y", 
             labeller = as_labeller(c(
               "D1_Risk" = "D1 Risk",
               "D2_Risk" = "D2 Risk",
               "D3_Risk" = "D3 Risk",
               "D4_Risk" = "D4 Risk",
               "D5_Risk" = "D5 Risk",
               "D6_Risk" = "D6 Risk",
               "Overall_Risk" = "Overall Risk"
               ))
             ) +
  scale_y_continuous(
    breaks = 1:3, 
    labels = c("Low", "Moderate", "High")
    ) +
  scale_x_discrete(
    labels = c("0" = "Human", "1" = "LLM")
    ) +
  labs(x = "LLM_source", y = "Score", fill = "LLM_source") +
  scale_fill_manual(
    values = c("0" = "lightblue", "1" = "salmon"),
    labels = c("0" = "Human", "1" = "LLM"),
    name = "Source") +
  labs(x="Source", y="Score") +
  ggtitle("Distribution of Risk Scores by Source") +
  theme_minimal() +
  theme (
    strip.text = element_text(face="bold", size =12)
  )


violin_plot

ggsave(
  filename = file.path(out_dirs$plots, "violin_plot.png"),
  plot = violin_plot,
  width = 6, height = 4, dpi = 300
)

#strange, at this stage ratings for kanemura in adan decay...

df_merged_Kappa_wide <- df_merged_Kappa_long |> 
  select (Study_ID, Risk_Score, LLM_source, Score, Review) |> 
  pivot_wider(
    names_from = LLM_source,
    values_from = Score,
    names_prefix = "LLM_"
  )

df_kappa_ready <- df_merged_Kappa_wide %>%
  filter(!is.na(LLM_0) & !is.na(LLM_1))

score_levels <- c("Low", "Moderate", "High")

# Check and convert only if not already ordered
df_kappa_ready <- df_kappa_ready %>%
  mutate(
    LLM_0 = if(!is.ordered(LLM_0)) factor(LLM_0, levels = score_levels, ordered = TRUE) else LLM_0,
    LLM_1 = if(!is.ordered(LLM_1)) factor(LLM_1, levels = score_levels, ordered = TRUE) else LLM_1
  )

kappa_results <- df_kappa_ready %>%
  group_by(Risk_Score) %>%
  summarise(
    kappa = cohen.kappa(
      cbind(as.integer(LLM_0), as.integer(LLM_1)) %>% na.omit()
    )$weighted.kappa,
    .groups = "drop"
  )

library(gt)

names (kappa_results)
 

my_palette <- cividis(4)  # generates 4 distinct colors
my_palette

kappa_results_df <- kappa_results |>
  # 1. Add agreement labels
  mutate(
    agreement = case_when(
      kappa < 0.20 ~ "Poor",
      kappa < 0.40 ~ "Fair",
      kappa < 0.60 ~ "Moderate",
      kappa < 0.80 ~ "Substantial",
      TRUE         ~ "Almost perfect"
    ),
    # 2. Replace underscores in Risk_Score
    Risk_Score = gsub("_", " ", Risk_Score)
  ) |>
  # 3. Start GT table
  gt() |>
  fmt_number(columns = kappa, decimals = 2) |>
  cols_label(
    Risk_Score = "Domain",
    kappa      = "Cohen’s κ",
    agreement  = "Agreement"
  ) |>
  tab_header(title = "Averaged inter-rater Agreement by Domain") |>
  
  # 4. Bold the table title
  tab_style(
    style = cell_text(weight = "bold", size = px(18)),
    locations = cells_title(groups = "title")
  ) |>
  
  # 5. Color the kappa column by value
  data_color(
    columns = kappa,
    colors = scales::col_numeric(
      palette = my_palette,
      domain = c(min(kappa_results$kappa), max(kappa_results$kappa))
    )
  )

kappa_results_df

gtsave (
  kappa_results_df,
  file.path(out_dirs$tables, "kappa_table.png")
)



capture.output(
  kappa_results,
  file = file.path(out_dirs$stats, "kappa_results.txt")
)

saveRDS (
  kappa_results, 
  file = file.path(out_dirs$stats, "kappa_results.rds")
)

#interesting that kappa scores of fair agreement D3, D5 are also the ones with signficant wilcoxon? one looks at bigger scale, other looks at smaller scale? kappa is about pairwise agreement, p value looks at differences in distributions. For example, with decent kappa nd low P value, both raters often give similar score, but one rater is slightly higher (systematically) #should we look at kappa and p value together?

df_heatmap <- df_kappa_ready %>%
  group_by(Risk_Score, LLM_0, LLM_1) %>%
  summarise(n = n(), .groups = "drop") %>%
  group_by(Risk_Score) %>%
  mutate(prop = n / sum(n))

heatmap_props <- ggplot(df_heatmap, aes(x = LLM_0, y = LLM_1, fill = prop)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white") +
  facet_wrap(~Risk_Score) +
  scale_fill_gradient(low = "white", high = "darkgreen")

ggsave(
  filename = file.path(out_dirs$plots, "heatmap_props.png"),
  plot = heatmap_props,
  width = 6, height = 4, dpi = 300
)

df_kappa_step <- df_kappa_ready %>%
  mutate(diff = as.integer(LLM_0) - as.integer(LLM_1)) %>%
  group_by(Risk_Score, diff) %>%
  summarise(n = n(), .groups = "drop")
 
 step_difference_plot <- ggplot(df_kappa_step,
  aes(x = Risk_Score, y = n, fill = factor(diff))) +
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette = "RdBu") +
  labs(title = "Agreement/Disagreement by Step Difference")

ggsave(
  filename = file.path(out_dirs$plots, "step_difference.png"),
  plot = step_difference_plot,
  width = 6, height = 4, dpi = 300
)


flow_plot <- ggplot(df_kappa_ready, 
       aes(axis1 = LLM_0, axis2 = LLM_1, y = 1)) +
  geom_alluvium(aes(fill = LLM_0)) +
  geom_stratum() + 
  geom_text(stat = "stratum", aes(label = after_stat(stratum))) +
  facet_wrap(~Risk_Score) +
  labs(title = "Flow of ratings from LLM 0 to LLM 1")

ggsave(
  filename = file.path(out_dirs$plots, "flow_plot.png"),
  plot = flow_plot,
  width = 6, height = 4, dpi = 300
)

kappa_within_review <- df_kappa_ready %>%
  group_by(Review, Risk_Score) %>%
  summarise(
    weighted_kappa = {
      mat <- cbind(as.integer(LLM_0), as.integer(LLM_1))
      cohen.kappa(mat)$weighted.kappa
    },
    n_studies = n(), # optional: number of studies in each review
    .groups = "drop"
  )

kappa_within_review

review_Adan <- "Adan 2025"
review_West <- "West 2019"
review_Giuliano <- "Giuliano 2021"
review_Arfaie <- "Arfaie 2023"
review_Wassenaar <- "Wassenaar 2013"

kappa_table_Adan <- kappa_within_review |>
  filter(Review == "Adan") |>
  # Clean up domain names
  mutate(Risk_Score = gsub("_", " ", Risk_Score)) |>
  # Optional: add agreement labels
  mutate(
    agreement = case_when(
      weighted_kappa < 0.20 ~ "Poor",
      weighted_kappa < 0.40 ~ "Fair",
      weighted_kappa < 0.60 ~ "Moderate",
      weighted_kappa < 0.80 ~ "Substantial",
      TRUE                  ~ "Almost perfect"
    )
  ) |>
  select(Risk_Score, weighted_kappa, agreement, n_studies) |>
  gt() |>
  fmt_number(columns = weighted_kappa, decimals = 2) |>
  cols_label(
    Risk_Score     = "Domain",
    weighted_kappa = "Cohen’s κ",
    agreement      = "Agreement",
    n_studies      = "# of studies"
  ) |>
  tab_header(title = review_Adan) |>
  tab_style(
    style = cell_text(weight = "bold", size = px(18)),
    locations = cells_title(groups = "title")
  )


kappa_table_Giuliano <- kappa_within_review |>
  filter(Review == "Giuliano") |>
  # Clean up domain names
  mutate(Risk_Score = gsub("_", " ", Risk_Score)) |>
  # Optional: add agreement labels
  mutate(
    agreement = case_when(
      weighted_kappa < 0.20 ~ "Poor",
      weighted_kappa < 0.40 ~ "Fair",
      weighted_kappa < 0.60 ~ "Moderate",
      weighted_kappa < 0.80 ~ "Substantial",
      TRUE                  ~ "Almost perfect"
    )
  ) |>
  select(Risk_Score, weighted_kappa, agreement, n_studies) |>
  gt() |>
  fmt_number(columns = weighted_kappa, decimals = 2) |>
  cols_label(
    Risk_Score     = "Domain",
    weighted_kappa = "Cohen’s κ",
    agreement      = "Agreement",
    n_studies      = "# of studies"
  ) |>
  tab_header(title = review_Giuliano) |>
  tab_style(
    style = cell_text(weight = "bold", size = px(18)),
    locations = cells_title(groups = "title")
  )

kappa_table_West <- kappa_within_review |>
  filter(Review == "West") |>
  # Clean up domain names
  mutate(Risk_Score = gsub("_", " ", Risk_Score)) |>
  # Optional: add agreement labels
  mutate(
    agreement = case_when(
      weighted_kappa < 0.20 ~ "Poor",
      weighted_kappa < 0.40 ~ "Fair",
      weighted_kappa < 0.60 ~ "Moderate",
      weighted_kappa < 0.80 ~ "Substantial",
      TRUE                  ~ "Almost perfect"
    )
  ) |>
  select(Risk_Score, weighted_kappa, agreement, n_studies) |>
  gt() |>
  fmt_number(columns = weighted_kappa, decimals = 2) |>
  cols_label(
    Risk_Score     = "Domain",
    weighted_kappa = "Cohen’s κ",
    agreement      = "Agreement",
    n_studies      = "# of studies"
  ) |>
  tab_header(title = review_West) |>
  tab_style(
    style = cell_text(weight = "bold", size = px(18)),
    locations = cells_title(groups = "title")
  )

kappa_table_Arfaie <- kappa_within_review |>
  filter(Review == "Arfaie") |>
  # Clean up domain names
  mutate(Risk_Score = gsub("_", " ", Risk_Score)) |>
  # Optional: add agreement labels
  mutate(
    agreement = case_when(
      weighted_kappa < 0.20 ~ "Poor",
      weighted_kappa < 0.40 ~ "Fair",
      weighted_kappa < 0.60 ~ "Moderate",
      weighted_kappa < 0.80 ~ "Substantial",
      TRUE                  ~ "Almost perfect"
    )
  ) |>
  select(Risk_Score, weighted_kappa, agreement, n_studies) |>
  gt() |>
  fmt_number(columns = weighted_kappa, decimals = 2) |>
  cols_label(
    Risk_Score     = "Domain",
    weighted_kappa = "Cohen’s κ",
    agreement      = "Agreement",
    n_studies      = "# of studies"
  ) |>
  tab_header(title = review_Arfaie) |>
  tab_style(
    style = cell_text(weight = "bold", size = px(18)),
    locations = cells_title(groups = "title")
  )

kappa_table_Wassenaar <- kappa_within_review |>
  filter(Review == "Wassenaar") |>
  # Clean up domain names
  mutate(Risk_Score = gsub("_", " ", Risk_Score)) |>
  # Optional: add agreement labels
  mutate(
    agreement = case_when(
      weighted_kappa < 0.20 ~ "Poor",
      weighted_kappa < 0.40 ~ "Fair",
      weighted_kappa < 0.60 ~ "Moderate",
      weighted_kappa < 0.80 ~ "Substantial",
      TRUE                  ~ "Almost perfect"
    )
  ) |>
  select(Risk_Score, weighted_kappa, agreement, n_studies) |>
  gt() |>
  fmt_number(columns = weighted_kappa, decimals = 2) |>
  cols_label(
    Risk_Score     = "Domain",
    weighted_kappa = "Cohen’s κ",
    agreement      = "Agreement",
    n_studies      = "# of studies"
  ) |>
  tab_header(title = review_Wassenaar) |>
  tab_style(
    style = cell_text(weight = "bold", size = px(18)),
    locations = cells_title(groups = "title")
  )


kappa_table_Arfaie
kappa_table_Adan
kappa_table_Wassenaar
kappa_table_West
kappa_table_Giuliano

gtsave (
  kappa_table_Arfaie ,
  file.path(out_dirs$tables, "kappa_table_Arfaie.png")
)
gtsave (
  kappa_table_Adan ,
  file.path(out_dirs$tables, "kappa_table_Adan.png")
)
gtsave (
  kappa_table_Wassenaar ,
  file.path(out_dirs$tables, "kappa_table_Wassenaar.png")
)
gtsave (
  kappa_table_West ,
  file.path(out_dirs$tables, "kappa_table_West.png")
)

gtsave (
  kappa_table_Giuliano ,
  file.path(out_dirs$tables, "kappa_table_Giuliano.png")
)



write.csv(
  kappa_within_review,
  file.path(out_dirs$stats, "kappa_results_within_review.csv"),
  row.names = FALSE
)

capture.output(
  kappa_within_review,
  file = file.path(out_dirs$stats, "kappa_results_within_review.txt")
)

saveRDS (
  kappa_within_review, 
  file = file.path(out_dirs$stats, "kappa_results_within_review.rds")
)

#No variance for D4 for Arfaie... across all 7 studies, scores align between LLM0 and LLM1; this produced NaN. However, this artificially deflates overall score, because it does not count!

ggplot(kappa_within_review, aes(x = Risk_Score, y = weighted_kappa, color = Review)) +
  geom_point(size = 3) +
  geom_line(aes(group = Review), alpha = 0.5) +
  labs(title = "Weighted Kappa Across Reviews per Risk Score") +
  theme_minimal()

heterogeneity <- kappa_within_review %>%
  group_by(Risk_Score) %>%
  summarise(
    mean_kappa = mean(weighted_kappa),
    var_kappa = var(weighted_kappa),
    sd_kappa = sd(weighted_kappa),
    .groups = "drop"
  )

kappa_avg_per_review <- kappa_within_review %>%
  group_by(Review) %>%
  summarise(
    mean_kappa = mean(weighted_kappa),
    sd_kappa   = sd(weighted_kappa),    # optional: variability across risk scores
    min_kappa  = min(weighted_kappa),
    max_kappa  = max(weighted_kappa),
    .groups = "drop"
  )

kappa_avg_per_review

write.csv(
  kappa_avg_per_review,
  file.path(out_dirs$stats, "kappa_avg_per_review.csv"),
  row.names = FALSE
)

capture.output(
  kappa_avg_per_review,
  file = file.path(out_dirs$stats, "kappa_avg_per_review.txt")
)

saveRDS (
  kappa_avg_per_review, 
  file = file.path(out_dirs$stats, "kappa_avg_per_review.rds")
)

kappa_avg_weighted <- kappa_within_review %>%
  group_by(Review) %>%
  summarise(
    mean_kappa = weighted.mean(weighted_kappa, w = n_studies),  # use study counts
    .groups = "drop"
  )

kappa_avg_weighted

write.csv(
  kappa_avg_weighted,
  file.path(out_dirs$stats, "kappa_avg_weighted.csv"),
  row.names = FALSE
)

capture.output(
  kappa_avg_weighted,
  file = file.path(out_dirs$stats, "kappa_avg_weighted.txt")
)

saveRDS (
  kappa_avg_weighted, 
  file = file.path(out_dirs$stats, "kappa_avg_weighted.rds")
)

kappa_avg_per_review_plot <- ggplot(kappa_avg_per_review, aes(x = Review, y = mean_kappa)) +
  geom_col(fill = "steelblue") +
  geom_errorbar(aes(ymin = min_kappa, ymax = max_kappa), width = 0.2) +
  labs(
    title = "Average Weighted Kappa per Review",
    y = "Mean Weighted Kappa (with range across risk scores)"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(out_dirs$plots, "kappa_avg_per_review_plot.png"),
  plot = kappa_avg_per_review_plot,
  width = 6, height = 4, dpi = 300
)