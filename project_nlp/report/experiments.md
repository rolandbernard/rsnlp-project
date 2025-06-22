
Experiments where run on multiple recent closed- and open-weight models. The LLMs evaluated in this project were:

    * OpenAI models: o4-mini, GPT 4.1, GPT 4, GPT 3.5
    * Google models: Gemini 2.0 Flash, Gemma 3 27B
    * Llama models: Llama 4 Maverick, Llama 3 70B
    * Mistral models: Mistral Large, Mistral Small

The OpenAI models were accessed through the [Azure OpenAI](https://azure.microsoft.com/en-us/products/ai-services/openai-service) service, and not directly through the OpenAI API. The Llama models were all accessed through the API provided by [groq](https://groq.com/). The Mistral models, including the open weight one, were accessed through [Mistral's API](https://mistral.ai/products/la-plateforme). Similarly, all Google models, including Gemma 3, which is an open-weight model, where accessed through [Google AI APIs](https://ai.google.dev/). The following table summarizes the models evaluated in this project.

| Model | Version | Parameters | Context Window | Open Weights |
|-------|---------|------------|----------------|--------------|
| GPT 3.5 | turbo-0125 | - | 16k | No |
| GPT 4 | turbo-2024-04-09 | - | No |
| GPT 4.1 | 2025-04-14 | - | 1000k | No |
| o4-mini | 2025-04-16 | - | 200k | No |
| Gemini 2.0 Flash | 001 | - | 1000k | No |
| Gemma 3 | - | 27B | 128k | Yes |
| Llama 3 | - | 70B | 8k | Yes |
| Llama 4 Maverick | - | 402B | 1000k | Yes |
| Mistral Large | 24.11 | 123B | 128k | Yes |
| Mistral Small | 25.03 | 24B | 128k | Yes |

The following table summarizes the results obtained on all game modes and languages. The evaluation was performed using the same instances for each model, and the instance between the languages where also the same, except for obviously being translated.

| Mode | Language | Model | Clemscore | % Played | % Agreement | % Pareto Optimal | Quality Score | Avg. # Messages |
|---------|------|----|---|----|---|---|---|-----|
| semi | en | GPT 3.5          | 0 | 32 | 7 | 0 | 0 | 3.3 |
| semi | en | GPT 4            | 61 | **100** | **78** | 30 | 61 | 7.9 |
| semi | en | GPT 4.1          | **69** | 98 | 74 | **51** | **70** | 7.1 |
| semi | en | o4-mini          | 44 | **100** | 48 | 36 | 44 | 4.3 |
| semi | en | Gemini 2.0 Flash | 42 | 98 | 47 | 24 | 42 | 6.9 |
| semi | en | Gemma 3          | 20 | 82 | 32 | 10 | 24 | 7 |
| semi | en | Llama 3          | 0 | 14 | 0 | 0 | 0 | 10 |
| semi | en | Llama 4 Maverick | 49 | 86 | 70 | 30 | 57 | 6.6 |
| semi | en | Mistral Large    | 38 | 72 | 61 | 39 | 53 | 8.5 |
| semi | en | Mistral Small    | 24 | 80 | 35 | 18 | 30 | 6.5 |
| semi | de | GPT 3.5          | 9 | 66 | 16 | 6 | 14 | 3.3 |
| semi | de | GPT 4            | 43 | 81 | 68 | 32 | 53 | 7 |
| semi | de | GPT 4.1          | 59 | 98 | **70** | 35 | **61** | 6.3 |
| semi | de | o4-mini          | 41 | **100** | 43 | 37 | 41 | 4.1 |
| semi | de | Gemini 2.0 Flash | 8 | 89 | 12 | 4 | 9 | 8.6 |
| semi | de | Gemma 3          | 9 | 82 | 12 | 7 | 11 | 6.2 |
| semi | de | Llama 4 Maverick | 26 | 74 | 41 | 22 | 36 | 6.9 |
| semi | de | Mistral Large    | **60** | **100** | 69 | **43** | 60 | 6 |
| semi | de | Mistral Small    | 21 | 92 | 30 | 9 | 23 | 5.2 |
| semi | it | GPT 3.5          | 4 | 51 | 13 | 0 | 7 | 3.8 |
| semi | it | GPT 4            | 50 | 93 | 62 | 36 | 53 | 7.4 |
| semi | it | GPT 4.1          | 49 | 95 | 59 | 34 | 51 | 6 |
| semi | it | o4-mini          | 17 | **100** | 20 | 9 | 17 | 5.1 |
| semi | it | Gemini 2.0 Flash | 15 | 96 | 19 | 10 | 16 | 6.7 |
| semi | it | Gemma 3          | 15 | 90 | 20 | 9 | 17 | 6.1 |
| semi | it | Llama 4 Maverick | 19 | 66 | 33 | 12 | 29 | 5.7 |
| semi | it | Mistral Large    | **64** | **100** | **72** | **48** | **64** | 6.2 |
| semi | it | Mistral Small    | 26 | 98 | 35 | 8 | 26 | 5.4 |
| coop | en | GPT 3.5          | 3 | 56 | 11 | 0 | 6 | 2.9 |
| coop | en | GPT 4            | **74** | **100** | **83** | 36 | **74** | 7.8 |
| coop | en | GPT 4.1          | 65 | **100** | 67 | 43 | 65 | 6.7 |
| coop | en | o4-mini          | 57 | **100** | 60 | **44** | 57 | 4.7 |
| coop | en | Gemini 2.0 Flash | 31 | 92 | 37 | 11 | 33 | 7.1 |
| coop | en | Gemma 3          | 25 | 90 | 31 | 11 | 27 | 6.4 |
| coop | en | Llama 3          | 29 | 60 | 60 | 0 | 48 | 9.1 |
| coop | en | Llama 4 Maverick | 48 | 78 | 74 | 18 | 62 | 6.7 |
| coop | en | Mistral Large    | 26 | 77 | 39 | 22 | 35 | 8.9 |
| coop | en | Mistral Small    | 26 | 86 | 37 | 12 | 31 | 6 |
| coop | de | GPT 3.5          | 9 | 86 | 16 | 3 | 11 | 2.2 |
| coop | de | GPT 4            | 37 | 63 | 67 | 22 | 59 | 6.6 |
| coop | de | GPT 4.1          | 65 | 98 | 70 | **44** | **66** | 6.6 |
| coop | de | o4-mini          | 51 | 98 | 58 | 31 | 52 | 4.1 |
| coop | de | Gemini 2.0 Flash | 16 | 96 | 21 | 8 | 17 | 10.1 |
| coop | de | Gemma 3          | 15 | 76 | 26 | 0 | 20 | 6 |
| coop | de | Llama 3          | 27 | 86 | 44 | 2 | 32 | 9.1 |
| coop | de | Llama 4 Maverick | 20 | 60 | 40 | 23 | 33 | 6.2 |
| coop | de | Mistral Large    | **66** | **100** | **71** | 39 | 66 | 6 |
| coop | de | Mistral Small    | 9 | 86 | 14 | 0 | 10 | 5.5 |
| coop | it | GPT 3.5          | 3 | 35 | 12 | 0 | 7 | 7.2 |
| coop | it | GPT 4            | **84** | **100** | **92** | **50** | **84** | 7.4 |
| coop | it | GPT 4.1          | 50 | 89 | 62 | 31 | 57 | 6.2 |
| coop | it | o4-mini          | 39 | **100** | 46 | 22 | 39 | 4.5 |
| coop | it | Gemini 2.0 Flash | 15 | 98 | 20 | 0 | 16 | 7 |
| coop | it | Gemma 3          | 10 | 94 | 15 | 4 | 11 | 6.4 |
| coop | it | Llama 3          | 24 | 90 | 39 | 2 | 27 | 9.7 |
| coop | it | Llama 4 Maverick | 26 | 62 | 52 | 10 | 42 | 5.9 |
| coop | it | Mistral Large    | 46 | **100** | 53 | 27 | 46 | 6.4 |
| coop | it | Mistral Small    | 24 | **100** | 30 | 2 | 24 | 5.1 |

The best scores for each mode and language combination are indicated in bold in the above table.

Note that the quality score, and the percentages of agreements and Pareto optimality have only been computed with respect to the played games. Effectively excluding games in which the LLMs did not respect the game rules. The clemscore combines both the percentage played and the quality score, to give an overall model performance number.

The table below gives the summary results for each model, averaged over all game modes and languages. The best score for each metric is again indicated in bold.

| Model | Clemscore | % Played | % Agreement | % Pareto Optimal | Quality Score | Avg. # Messages |
|---------|---|----|----|---|---|-----|
| GPT 3.5 | 5 | 54 | 13 | 2 | 9 | 3.8 |
| GPT 4 | 59 | 90 | **76** | 35 | **65** | 7.3 |
| GPT 4.1 | **60** | 96 | 67 | **40** | 62 | 6.5 |
| o4-mini | 42 | **100** | 46 | 30 | 42 | 4.5 |
| Gemini 2.0 Flash | 22 | 95 | 27 | 10 | 23 | 7.6 |
| Gemma 3 | 16 | 86 | 23 | 7 | 18 | 6.3 |
| Llama 3 | 26 | 76 | 46 | 2 | 34 | 9.3 |
| Llama 4 Maverick | 32 | 71 | 53 | 20 | 44 | 6.3 |
| Mistral Large | 50 | 91 | 62 | 37 | 55 | 7 |
| Mistral Small | 22 | 90 | 30 | 8 | 24 | 5.6 |

