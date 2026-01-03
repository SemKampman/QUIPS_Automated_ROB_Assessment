#!/usr/bin/env Rscript
#
# Convert TSV tables to Markdown format for inclusion in manuscript
#
# This script reads TSV files from ../outputs/ and converts them to
# Markdown tables that can be inserted into the manuscript.
#
# Output: tables/*.md files
#

# Set working directory to script location
# Get the script path when running with Rscript
args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)
if (length(file_arg) > 0) {
  script_dir <- dirname(sub("^--file=", "", file_arg))
} else {
  # Fallback to current directory if not running as script
  script_dir <- getwd()
}
setwd(script_dir)

# Create tables directory if it doesn't exist
if (!dir.exists("tables")) {
  dir.create("tables")
}

cat("Converting TSV tables to Markdown format...\n")

# Function to convert a data frame to Markdown table
df_to_markdown <- function(df, caption = "", label = "") {
  # Limit rows for display (optional)
  max_rows <- 20
  if (nrow(df) > max_rows) {
    cat(sprintf("  Note: Showing first %d of %d rows\n", max_rows, nrow(df)))
    df <- head(df, max_rows)
  }

  # Create header
  header <- paste("|", paste(names(df), collapse = " | "), "|")
  separator <- paste("|", paste(rep("---", ncol(df)), collapse = " | "), "|")

  # Create rows
  rows <- apply(df, 1, function(row) {
    paste("|", paste(row, collapse = " | "), "|")
  })

  # Combine with caption
  output <- c(
    if (caption != "") paste0("Table: ", caption, " {", label, "}") else "",
    "",
    header,
    separator,
    rows,
    ""
  )

  return(paste(output, collapse = "\n"))
}

# Example: Convert QUIPS summary table
# Adjust paths to match your actual TSV files
tsv_file <- "../outputs/1_Giuliano_2021/quips_summary.tsv"

if (file.exists(tsv_file)) {
  cat(sprintf("Reading: %s\n", tsv_file))

  # Read TSV
  data <- read.table(tsv_file, header = TRUE, sep = "\t",
                     quote = "", comment.char = "",
                     stringsAsFactors = FALSE,
                     fill = TRUE)

  cat(sprintf("  Loaded %d rows and %d columns\n", nrow(data), ncol(data)))

  # Create summary table for Domain 1 (Study Participation)
  if (all(c("filename", "first_author", "year", "D1_Risk") %in% names(data))) {
    domain1_summary <- data[, c("filename", "first_author", "year", "D1_Risk")]
    names(domain1_summary) <- c("Study ID", "First Author", "Year", "Risk of Bias")

    # Write to markdown
    md_output <- df_to_markdown(
      domain1_summary,
      caption = "Risk of bias ratings for Study Participation domain",
      label = "#tbl:domain1"
    )

    writeLines(md_output, "tables/domain1_summary.md")
    cat("  Created: tables/domain1_summary.md\n")
  }

  # Create overall risk summary across all domains
  if (all(paste0("D", 1:6, "_Risk") %in% names(data))) {
    risk_cols <- paste0("D", 1:6, "_Risk")
    risk_summary <- data[, c("filename", "first_author", "year", risk_cols)]
    names(risk_summary) <- c("Study ID", "First Author", "Year",
                            "D1: Participation", "D2: Attrition",
                            "D3: Prog. Factor", "D4: Outcome",
                            "D5: Confounding", "D6: Statistics")

    md_output <- df_to_markdown(
      risk_summary,
      caption = "Overall risk of bias ratings across all QUIPS domains",
      label = "#tbl:overall-risk"
    )

    writeLines(md_output, "tables/overall_risk_summary.md")
    cat("  Created: tables/overall_risk_summary.md\n")
  }

  # Create frequency table of risk ratings
  risk_levels <- c("Low", "Moderate", "High")
  domain_names <- c("Study Participation", "Study Attrition",
                   "Prognostic Factor", "Outcome Measurement",
                   "Study Confounding", "Statistical Analysis")

  freq_table <- data.frame(
    Domain = domain_names,
    Low = NA,
    Moderate = NA,
    High = NA
  )

  for (i in 1:6) {
    col_name <- paste0("D", i, "_Risk")
    if (col_name %in% names(data)) {
      freq <- table(factor(data[[col_name]], levels = risk_levels))
      freq_table[i, 2:4] <- as.numeric(freq)
    }
  }

  md_output <- df_to_markdown(
    freq_table,
    caption = "Frequency of risk of bias ratings by domain",
    label = "#tbl:risk-frequency"
  )

  writeLines(md_output, "tables/risk_frequency.md")
  cat("  Created: tables/risk_frequency.md\n")

} else {
  cat(sprintf("Warning: TSV file not found: %s\n", tsv_file))
  cat("Please run the analysis pipeline first to generate TSV files.\n")
}

cat("\n")
cat("Table conversion complete!\n")
cat("Generated markdown tables are in: tables/\n")
cat("\n")
cat("To insert tables in your manuscript, use:\n")
cat('  {{< include tables/domain1_summary.md >}}\n')
cat("\n")
cat("The build script will automatically include these files during compilation.\n")
