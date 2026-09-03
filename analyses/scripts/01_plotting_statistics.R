#QUIPS_LLM_study
#Creation Date: 6 mar 2026
#Last Updated: 2 sep 2026
#Owners: Sem Kampman, Wim Otte

#PART 2 - wilcoxon, median difference, RBS effect size
#--------------------------------------------------------------------------------------------
  #steps:
  #1 Summaries, plots and kappa
  
library (tidyverse)
library (stringr)
library (readr)
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
library (WRS2)
library (effectsize)
library (rempsyc)
library(flextable)
library(knitr)
library(clipr)
library(officer)

out_dirs <- list(
  plots  = here("output", "plots"),
  tables = here("output", "tables")
)

purrr::walk(out_dirs, ~ dir.create(.x, recursive = TRUE, showWarnings = FALSE))
#load data
df_merged_long <- readRDS(here("data", "processed_data", "df_merged_long.rds"))
#-----------------------------------------------------------------------------------------------
#------------------------------------ STEP 5 - Summaries------------------------
#-----------------------------------------------------------------------------------------------
df_merged_long <-  df_merged_long |> 
  mutate(
    LLM_source = recode(
      LLM_source,
      "0" = "human",
      "1" = "llm"
    )
  )

df_merged_long_summary <- df_merged_long |> 
  group_by(Risk_Score, LLM_source, Score) %>%
  summarise(n = n(), .groups = "drop") %>%
  group_by(Risk_Score, LLM_source) %>%
  mutate(prop = n / sum(n)) 

df_merged_wide_summary <- df_merged_long_summary |> 
  pivot_wider(names_from = Score, values_from = c(n, prop))

ft_wide <- flextable(df_merged_wide_summary)

#ensure no NAs
df_merged_long_na <- df_merged_long %>%
  group_by(Study_ID, Risk_Score, Review) %>%
  summarise(
    n_missing = sum(is.na(Score_num)),
    .groups = "drop"
  )
#-----------------------------------------------------------------------------------------------
#------------------------------------ Wilcoxon paired signed-rank test -------------------------
#------------------------------------ Goal = detect systematic differences (bias)
# Weighted Kappa tells you how often the LLM agrees with the human; the Paired Wilcoxon tells you whether the LLM is biased higher or lower than the human.
# Together, they show both accuracy and directional bias.--------------

###3----------
wilcox_test <- df_merged_long |> 
  group_by(Risk_Score) |> 
  wilcox_test(Score_num ~ LLM_source, paired = TRUE)

# Add readable labels and readable p-values
wilcox_test <- wilcox_test |>
  mutate(
    p_readable = case_when(
      p < 0.001 ~ "< 0.001",
      p < 0.01  ~ "< 0.01",
      p < 0.05  ~ "< 0.05",
      TRUE      ~ format(round(p, 3), nsmall = 3)
    )
  )

wilcox_test_table <- wilcox_test |>
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

wilcox_test_pub <- wilcox_test |>
  select (-.y., -group1, -group2, -n1, -statistic, -p)

wilcox_test_pub <- wilcox_test_pub |> 
  rename (
    Pairs = n2,
    `p-value` = p_readable
  )

ft_wilcox <- flextable(wilcox_test_pub)

# Create paired wide dataset with differences
diffs <- df_merged_long %>%
  mutate(
    source = ifelse(LLM_source == 0, "Human", "LLM")
  ) %>%
  select(Study_ID, Risk_Score, Review, LLM_source, Score_num) %>%
  pivot_wider(
    names_from = LLM_source,
    values_from = Score_num
  ) |> 
  mutate(
    diff = human  - llm #for consistency
  )

#Compute median differences per Risk_Score (remove NAs)
median_diffs <- diffs %>%
  group_by(Risk_Score) %>%
  summarise(
    median_diff = median(diff, na.rm = TRUE)
  )

#Compute rank-biserial effect size (RBS)
rbs_tbl <- df_merged_long %>%
  group_by(Risk_Score) %>%
  wilcox_effsize(
    Score_num ~ LLM_source,
    paired = TRUE,
    ci = TRUE,            # ⬅️ turn on confidence intervals
    conf.level = 0.95     # ⬅️ 95% CI
  ) %>%
  mutate(
    effsize   = round(effsize, 3),
    conf.low  = round(conf.low, 3),
    conf.high = round(conf.high, 3)
  )

# Combine everything into one table
final_table <- wilcox_test_pub %>%
  left_join(rbs_tbl %>% select(Risk_Score, effsize, conf.low, conf.high, magnitude), by = "Risk_Score") |> 
  arrange(Risk_Score)

final_table <-final_table %>%
  mutate(
    rbs = sprintf("%.3f (%.3f–%.3f)", effsize, conf.low, conf.high)
  )

final_table <-final_table %>%
  select (-effsize, -conf.low,-conf.high)

final_table <-final_table %>% relocate (magnitude, .after = last_col())
final_table <-final_table %>% rename(
  `Bias Domain` = Risk_Score,
  Magnitude = magnitude)

ft_final_table <- flextable (final_table)
############ visualization #########
risk_order <- c(
  "D1_Risk",
  "D2_Risk",
  "D3_Risk",
  "D4_Risk",
  "D5_Risk",
  "D6_Risk",
  "Overall_Risk"
)

risk_labels <- c(
  "D1 Risk", "D2 Risk", "D3 Risk", "D4 Risk", "D5 Risk", "D6 Risk", "Overall Risk"
)

diffs_clean <- diffs %>%
  mutate(
    Risk_Score_clean = factor(
      Risk_Score,
      levels = risk_order,
      labels = risk_labels
    )
  )

distribution_plot <- ggplot(
  diffs_clean,
  aes(
    x = diff,
    y = Risk_Score_clean,
    fill = Risk_Score_clean,
    group = Risk_Score_clean   # 👈 THIS fixes the error
  )
) +
  geom_density_ridges(alpha = 0.6) +
  scale_y_discrete(limits = rev) +  
  theme_minimal() +
  labs(
    x = "Difference (Human - LLM)",
    y = "Bias Domain",
    fill = "Bias Domain"
  )

stacked_proportions_plot <- ggplot(df_merged_long, aes(x = factor(LLM_source), fill = Score)) +
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
  ggtitle("Distribution of Risk Scores") + 
  theme (
    strip.text = element_text(face="bold", size =12)
  )

violin_plot <- df_merged_long |> 
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
    labels = c("Human", "LLM")
  ) +
  labs(x = "LLM_source", y = "Score", fill = "LLM_source") +
  scale_fill_manual(
    values = c("human" = "lightblue", "llm" = "salmon"),
    labels = c("Human", "LLM"),
    name = "Source") +
  labs(x="Source", y="Score") +
  ggtitle("Distribution of Risk Scores by Source") +
  theme_minimal() +
  theme (
    strip.text = element_text(face="bold", size =12)
  )
#-----------------------------------------------------------------------------------------------
#------------------------------------  Save outputs!  ------------------------
#-----------------------------------------------------------------------------------------------
plots_list <- list(stacked_proportions_plot, distribution_plot, violin_plot)
tables_list <- list (ft_final_table, ft_wilcox, ft_wide) 

save_flextables <- function(tables_list, dir) {
  for (i in seq_along(tables_list)) {
    ft <- tables_list[[i]]
    filename <- paste0("general", i, ".docx")
    
    doc <- read_docx()
    doc <- body_add_flextable(doc, ft)
    print(doc, target = file.path(dir, filename))
  }
}

save_flextables(tables_list, out_dirs$tables)

for (i in seq_along(plots_list)) {
  p <- plots_list[[i]]
  ggsave(
    filename = file.path(out_dirs$plots, paste0("plot_", i, ".png")),
    plot = p,
    width = 8,
    height = 6,
    dpi = 300
  )
}

saveRDS(df_merged_long, here("data", "processed_data", "df_merged_long.rds"))