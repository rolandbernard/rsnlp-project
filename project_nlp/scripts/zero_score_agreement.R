
library(tidyverse)

raw_data <- read_csv("clemgame-dond/results/raw.csv")

clean_data <- raw_data %>%
    mutate(
        model = str_extract(model, ".+?(?=-t0\\.0--)"),
        mode = str_split_i(experiment, "_", 2),
        lang = str_split_i(experiment, "_", 3),
        metric = case_when(
            metric == "Aborted" ~ "aborted",
            metric == "Success" ~ "success",
            metric == "Pareto Optimal" ~ "optimal",
            metric == "Main Score" ~ "quality",
            metric == "Request Count" ~ "requests",
        ),
    ) %>%
    drop_na(metric) %>%
    pivot_wider(
        id_cols = c("model", "mode", "lang", "episode"),
        names_from = "metric", values_from = "value"
    ) %>%
    mutate(
        played = 1 - aborted,
        success = if_else(aborted == 0, success, NA),
        optimal = if_else(aborted == 0, optimal, NA),
        quality = if_else(aborted == 0, quality, NA),
    )

filtered_data <- clean_data %>%
    filter(success == 1 & quality <= 1) %>%
    select(model, mode, lang, episode)

print(filtered_data)

