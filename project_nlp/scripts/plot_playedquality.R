
library(tidyverse)
library(ggrepel)
library(showtext)

font_add("Libertinus", regular = "~/.local/share/fonts/LibertinusSerif-Regular.otf")
showtext_auto()

raw_data <- read_csv("clemgame-dond/results/raw.csv")

clean_data <- raw_data %>%
    mutate(
        model = str_extract(model, ".+?(?=-t0\\.0--)"),
        mode = str_split_i(experiment, "_", 2),
        lang = str_split_i(experiment, "_", 3),
        metric = case_when(
            metric == "Aborted" ~ "aborted",
            metric == "Main Score" ~ "quality",
        ),
    ) %>%
    drop_na(metric) %>%
    pivot_wider(
        id_cols = c("model", "mode", "lang", "episode"),
        names_from = "metric", values_from = "value"
    ) %>%
    mutate(
        played = 1 - aborted,
        quality = if_else(aborted == 0, quality, NA),
    )

summary_data <- clean_data %>%
    group_by(model) %>%
    summarize(
        played = mean(played),
        quality = mean(quality, na.rm = TRUE),
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
        )))
    )

plot <- ggplot(summary_data, aes(y = 100 * played, x = quality)) +
    geom_point(aes(color = model), size = 3) +
    geom_text_repel(aes(label = model), family = "Libertinus") +
    labs(y = "% Played", x = "Quality Score") +
    guides(color = "none") +
    theme_bw() +
    theme(
        text = element_text(family = "Libertinus"),
        plot.margin = margin(),
    )

ggsave("report/figures/playedquality.pdf", plot, width = 5, height = 5)
