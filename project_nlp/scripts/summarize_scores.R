
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

summary_data <- clean_data %>%
    group_by(model, mode, lang) %>%
    summarize(
        requests = mean(requests),
        aborted = mean(aborted),
        played = mean(played),
        success = mean(success, na.rm=TRUE),
        optimal = mean(optimal, na.rm=TRUE),
        quality = mean(quality, na.rm=TRUE),
    ) %>%
    mutate(
        clemscore = played * quality,
    )
# The one is for the table, so I round the values and order them like in the table.
summary2_data <- summary_data %>%
    mutate(
        model = case_when(
            model == "gpt-3.5-turbo-0125" ~ "GPT 3.5",
            model == "gpt-4-turbo-2024-04-09" ~ "GPT 4",
            model == "gpt-4.1-2025-04-16" ~ "GPT 4.1",
            model == "o4-mini-2025-04-16" ~ "o4-mini",
            model == "gemini-2.0-flash-001" ~ "Gemini 2.0 Flash",
            model == "gemma-3-27b-it" ~ "Gemma 3",
            model == "llama-3-70b" ~ "Llama 3",
            model == "llama-4-maverick-17b-128e" ~ "Llama 4 Maverick",
            model == "mistral-large-2411" ~ "Mistral Large",
            model == "mistral-small-2503" ~ "Mistral Small",
        ),
        model = fct_rev(factor(model, levels = c(
            "GPT 3.5", "GPT 4", "GPT 4.1", "o4-mini", "Gemini 2.0 Flash", "Gemma 3",
            "Llama 3", "Llama 4 Maverick", "Mistral Large", "Mistral Small"
        ))),
        mode = factor(mode, levels = c("semi", "coop", "comp")),
        lang = factor(lang, levels = c("en", "de", "it")),
        clemscore = round(clemscore),
        played = round(100 * played),
        success = round(100 * success),
        optimal = round(100 * optimal),
        quality = round(quality),
        requests = round(requests, 1),
    ) %>%
    pivot_longer(cols = c("clemscore", "played", "success", "optimal", "quality", "requests")) %>%
    mutate(
        name = case_when(
            name == "clemscore" ~ "Clemscore",
            name == "played" ~ "% Played",
            name == "success" ~ "% Agreement",
            name == "optimal" ~ "% Optimal",
            name == "quality" ~ "Quality Score",
            name == "requests" ~ "Avg. # Messages",
        ),
        name = factor(name, levels = c(
            "Clemscore", "% Played", "% Agreement", "% Optimal", "Quality Score", "Avg. # Messages"
        ))
    ) %>%
    pivot_wider(
        id_cols = c("mode", "lang", "name"),
        names_from = "model", values_from = "value"
    ) %>%
    arrange(mode, lang, name) %>%
    select(mode, lang, name,
        "GPT 3.5", "GPT 4", "GPT 4.1", "o4-mini", "Gemini 2.0 Flash", "Gemma 3",
        "Llama 3", "Llama 4 Maverick", "Mistral Large", "Mistral Small"
    )
# This one summarizes over all experiments performed with the same model, giving
# an overall quality assessment of the model.
summary3_data <- clean_data %>%
    group_by(model) %>%
    summarize(
        requests = mean(requests),
        aborted = mean(aborted),
        played = mean(played),
        success = mean(success, na.rm=TRUE),
        optimal = mean(optimal, na.rm=TRUE),
        quality = mean(quality, na.rm=TRUE),
    ) %>%
    mutate(
        clemscore = played * quality,
    ) %>%
    mutate(
        model = case_when(
            model == "gpt-3.5-turbo-0125" ~ "GPT 3.5",
            model == "gpt-4-turbo-2024-04-09" ~ "GPT 4",
            model == "gpt-4.1-2025-04-16" ~ "GPT 4.1",
            model == "o4-mini-2025-04-16" ~ "o4-mini",
            model == "gemini-2.0-flash-001" ~ "Gemini 2.0 Flash",
            model == "gemma-3-27b-it" ~ "Gemma 3",
            model == "llama-3-70b" ~ "Llama 3",
            model == "llama-4-maverick-17b-128e" ~ "Llama 4 Maverick",
            model == "mistral-large-2411" ~ "Mistral Large",
            model == "mistral-small-2503" ~ "Mistral Small",
        ),
        model = fct_rev(factor(model, levels = c(
            "GPT 3.5", "GPT 4", "GPT 4.1", "o4-mini", "Gemini 2.0 Flash", "Gemma 3",
            "Llama 3", "Llama 4 Maverick", "Mistral Large", "Mistral Small"
        ))),
        clemscore = round(clemscore),
        played = round(100 * played),
        success = round(100 * success),
        optimal = round(100 * optimal),
        quality = round(quality),
        requests = round(requests, 1),
    ) %>%
    arrange(model) %>%
    select(model, clemscore, played, success, optimal, quality, requests)

write_csv(summary_data, "clemgame-dond/results/summary.csv")
write_csv(summary2_data, "clemgame-dond/results/summary2.csv")
write_csv(summary3_data, "clemgame-dond/results/summary3.csv")

