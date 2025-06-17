
library(tidyverse)

raw_data <- read_csv("clemgame-dond/results/raw.csv")

clean_data <- raw_data %>%
    mutate(
        model = str_extract(model, ".+?(?=-t0\\.0--)"),
        mode = str_split_i(experiment, "_", 2),
        lang = str_split_i(experiment, "_", 3),
        metric = case_when(
            metric == "Request Count" ~ "requests",
        ),
    ) %>%
    drop_na(metric) %>%
    pivot_wider(
        id_cols = c("model", "mode", "lang", "episode"),
        names_from = "metric", values_from = "value"
    ) %>%
    mutate(
        immediate = if_else(requests <= 2, 1, 0),
    )

summary_data <- clean_data %>%
    group_by(model) %>%
    summarize(
        immediate = mean(immediate),
    )

print(summary_data)

