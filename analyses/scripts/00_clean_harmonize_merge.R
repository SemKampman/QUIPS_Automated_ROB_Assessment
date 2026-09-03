#QUIPS_LLM_study
#Creation Date: 5 jan 2026
#Last Updated: 2 sep 2026
#Owners: Sem Kampman, Wim Otte

#PART 1 - clean, harmonize, merge
#--------------------------------------------------------------------------------------------
#steps:
  #1 Import LLM datasets
  #2 Clean LLM data
  #3 Merge LLM datasets
  #4 Import and merge GS datasets
  #5 Summaries, plots and kappa

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
library (readr)


out_dirs <- list(
  plots  = here("output", "plots"),
  tables = here("output", "tables")
)

purrr::walk(out_dirs, ~ dir.create(.x, recursive = TRUE, showWarnings = FALSE))
################# custom functions ###############
clean_review <- function(data,
                         prefix = "^scoring_",
                         suffix = "\\.json$",
                         sep_regex = "_(?=[^_]+$)") {
  # Infer Review from object name: e.g., df_West -> West
  review_name <- deparse(substitute(data))
  review_name <- sub("^df_", "", review_name)
  
  # Expect a 'filename' column
  if (!"filename" %in% names(data)) {
    stop("No column named 'filename' found in `data`.")
  }
  
  # Auto-detect risk columns ending in _Risk
  risk_cols <- grep("_Risk$", names(data), value = TRUE)
  if (length(risk_cols) == 0L) {
    stop("No columns ending with '_Risk' found in `data`.")
  }
  
  return(
    data |>
      dplyr::select(filename, dplyr::all_of(risk_cols)) |>
      dplyr::mutate(
        clean = stringr::str_remove(filename, prefix),
        clean = stringr::str_remove(clean, suffix)
      ) |>
      tidyr::separate(clean, c("author", "year"),
                      sep = sep_regex, fill = "right", remove = TRUE) |>
      dplyr::mutate(
        Study_ID = paste(author, year, sep = "_"),
        Year     = suppressWarnings(as.integer(year)),
        Review   = review_name
      ) |>
      dplyr::relocate(Study_ID, Year, Review) |>
      dplyr::select(-filename, -year)
  )
}
################# end custom functions ###############
#-----------------------------------------------------------------------------------------------
#------------------------------------ STEP 1 - Import LLM datasets -----------------------------
#-----------------------------------------------------------------------------------------------
df_Adan <- read_tsv(here("data", "raw_data", "quips_summary_Adan_v2.tsv"))
df_Giuliano <- read_tsv(here("data","raw_data", "quips_summary_Giuliano.tsv"))
df_West <- read_tsv(here("data","raw_data", "quips_summary_West.tsv"))
df_Arfaie <- read_tsv(here("data","raw_data", "quips_summary_Arfaie.tsv"))
df_Wassenaar<- read_tsv(here("data","raw_data", "quips_summary_Wassenaar.tsv"))
df_Tan <- read_tsv(here("data","raw_data", "quips_summary_Tan.tsv"))
df_Verboom <- read_tsv(here("data","raw_data", "quips_summary_Verboom.tsv"))
df_Ghozy <- read_tsv(here("data","raw_data", "quips_summary_Ghozy.tsv"))
df_McGeown <- read_tsv(here("data","raw_data", "quips_summary_McGeown.tsv"))
df_Gallucci<- read_tsv(here("data","raw_data", "quips_summary_Gallucci.tsv"))
df_Dery <- read_tsv(here("data","raw_data", "quips_summary_Dery.tsv"))
df_Tao <- read_tsv(here("data","raw_data", "quips_summary_Tao.tsv"))
df_Zhubi <- read_tsv(here("data","raw_data", "quips_summary_Zhubi.tsv"))
df_Thiara <- read_tsv(here("data","raw_data", "quips_summary_Thiara.tsv"))
df_Pires <- read_tsv(here("data","raw_data", "quips_summary_Pires.tsv"))
#-----------------------------------------------------------------------------------------------
#------------------------------------ STEP 2 - Clean LLM datasets ------------------------------
#-----------------------------------------------------------------------------------------------
df_Adan <- clean_review(df_Adan)
df_West <- clean_review(df_West)
df_Giuliano <- clean_review(df_Giuliano)
df_Arfaie <- clean_review(df_Arfaie)
df_Wassenaar <- clean_review(df_Wassenaar)
df_Tan <- clean_review(df_Tan)
df_Verboom <- clean_review(df_Verboom)
df_Ghozy <- clean_review(df_Ghozy)
df_McGeown <- clean_review(df_McGeown)
df_Gallucci <- clean_review(df_Gallucci)
df_Dery <- clean_review(df_Dery)
df_Tao <- clean_review(df_Tao)
df_Zhubi <- clean_review(df_Zhubi)
df_Thiara <- clean_review(df_Thiara)
df_Pires <- clean_review(df_Pires)
#-----------------------------------------------------------------------------------------------
#------------------------------------ STEP 3 - Merge and Harmonize LLM data --------------------
#-----------------------------------------------------------------------------------------------
df_merged_LLMs <- bind_rows (df_Adan, df_Arfaie, df_Giuliano, df_Wassenaar, df_West,
                             df_Tan, df_Verboom, df_Ghozy, df_McGeown, df_Gallucci,
                             df_Dery, df_Tao, df_Zhubi, df_Thiara, df_Pires)

df_merged_LLMs <- df_merged_LLMs |> 
  mutate (across (c(Overall_Risk, D1_Risk, D2_Risk, D3_Risk, D4_Risk, D5_Risk, D6_Risk), ~ factor (.x, levels = (c("Low", "Moderate", "High")), ordered = TRUE)))

df_merged_LLMs <- df_merged_LLMs |> 
  mutate(LLM_source = 1) |> 
  relocate (LLM_source, .before = 1
             ) |> select (-author)
#-----------------------------------------------------------------------------------------------
#------------------------------------ STEP 4 - Import Gold Standard data and merge--------------
#-----------------------------------------------------------------------------------------------
df_merged_GS <- read_excel(here("data", "raw_data", "Gold_Standard_Overview_09022026.xlsx"))

df_merged_GS <- df_merged_GS |>
  mutate(
    clean = str_remove(Study_ID, "^scoring_"),
    clean = str_remove(clean, "\\.json$")
  ) |>
  separate(clean, into = c("author", "year"), sep = "_(?=[^_]+$)") |>
  mutate(
    author_year = str_remove(author_year, "\\.pdf$"),
    Study_ID = dplyr::coalesce(
      author_year,
      paste(author, year, sep = "_")
    ),
    
    Year = as.integer(year)
  ) |>
  relocate(LLM_source, Study_ID, Year, Review, .before = 1) |>
  select(-year, -author)
  
df_merged_GS <- df_merged_GS |> 
  mutate(across(where(is.character), ~ gsub("Giuliani", "Giuliano", .)))

df_merged_GS <- df_merged_GS |> 
  mutate (across (c(Overall_Risk, D1_Risk, D2_Risk, D3_Risk, D4_Risk, D5_Risk, D6_Risk), ~ factor (.x, levels = (c("Low", "Moderate", "High")), ordered = TRUE)))

df_merged_all <- bind_rows (df_merged_GS, df_merged_LLMs)

risk_scores <- c("Overall_Risk", "D1_Risk", "D2_Risk", "D3_Risk", "D4_Risk", "D5_Risk", "D6_Risk")

df_merged_long <- df_merged_all |> 
  pivot_longer(
    cols = all_of(risk_scores),
    names_to = "Risk_Score",
    values_to = "Score"
  )

df_merged_long <- df_merged_long %>%
  mutate (Score_num = as.integer(Score)) |> 
  select (-Year, -author_year) |> 
  mutate(LLM_source = factor(LLM_source, levels = c(0, 1)))
#-----------------------------------------------------------------------------------------------
#------------------------------------ inspect NAs and duplicates --------------
#-----------------------------------------------------------------------------------------------
na <-df_merged_long %>%
  group_by(LLM_source, Study_ID, Risk_Score, Review) %>%
  filter(any(is.na(across(everything())))) %>%
  distinct(LLM_source, Study_ID, Risk_Score, Review)
#Q = why Zhubi NA from LLM???!!!

df_merged_long <- df_merged_long |> 
  group_by (Study_ID, Risk_Score, Review) |> 
  filter(!any(is.na(Score))) %>% # drop entire pair if NA detected
  ungroup()

##### inspect duplicates (for sensitivity analysis later)
sum(duplicated(df_merged_GS$Study_ID))
unique(df_merged_GS$Study_ID[duplicated(df_merged_GS$Study_ID)])
#note, Wang_2019 is not a real duplicate. So there are only 5 duplicate articles.


########### conclusion ###########
saveRDS(df_merged_long, here("data", "processed_data", "df_merged_long.rds"))