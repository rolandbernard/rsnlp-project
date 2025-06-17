
library(tidyverse)
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
            metric == "Lose" ~ "failed",
            metric == "Pareto Optimal" ~ "optimal",
        ),
    ) %>%
    drop_na(metric) %>%
    pivot_wider(
        id_cols = c("model", "mode", "lang", "episode"),
        names_from = "metric", values_from = "value"
    ) %>%
    mutate(
        failed = replace_na(failed, 0),
        optimal = replace_na(optimal, 0),
    ) %>%
    mutate(
        suboptimal = 1 - aborted - failed - optimal,
    )

summary_data <- clean_data %>%
    group_by(model) %>%
    summarize(
        aborted = mean(aborted),
        failed = mean(failed),
        suboptimal = mean(suboptimal),
        optimal = mean(optimal),
    ) %>%
    pivot_longer(cols = c("aborted", "failed", "suboptimal", "optimal")) %>%
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
        name = case_when(
            name == "aborted" ~ "Aborted",
            name == "failed" ~ "Failed",
            name == "suboptimal" ~ "Suboptimal",
            name == "optimal" ~ "Optimal",
        ),
        name = factor(name, levels = c("Optimal", "Suboptimal", "Failed", "Aborted"))
    )

plot <- ggplot(summary_data, aes(y = model, x = value, fill = name)) +
    geom_col(position = "stack") +
    scale_x_reverse() +
    scale_fill_manual(values = c("#97b84f", "#5eb8b9", "#c3a7ff", "#ee928d")) +
    theme_bw() +
    theme(
        text = element_text(family = "Libertinus"),
        legend.position = "top",
        legend.title = element_blank(),
        legend.margin = margin(),
        plot.margin = margin(),
        axis.text.x = element_blank(),
        axis.text.y = element_text(size = 10, color = "black"),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        strip.background = element_blank(),
    )

ggsave("report/figures/outcome.pdf", plot, width = 5, height = 3)
