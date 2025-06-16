Report of ~5000 words.
* Title: Evaluating the Negotiation Abilities of Large Language Models Using Game Play
* Abstract (~150 words)
    * Briefly introduce the project's purpose: designing and implementing a novel clemgame based on "Deal or No Deal" to evaluate LLMs.
    * State the core problem addressed: understanding LLM capabilities in negotiation, decision-making under uncertainty, and strategic interactions.
    * Describe the methodology: quickly mention the new clemgame's mechanics, evaluation of recent closed- and open-weight models, and the evaluation metrics used (rule following, and Pareto optimality).
    * Summarize key findings: how different LLMs performed, observed strengths and weaknesses.
    * Impact of results: Quick sentence about the significance of the results.
* Introduction
    * Some motivation and background:
        * Increasing capabilities of LLMs and their application across various NLP tasks.
        * Limitations of traditional benchmarking, such as non-interactivity and likelihood that datasets are part of the training data.
        * Mention how dialogue games have been suggested as a means of evaluating LLMs.
        * Specifically mention the clembench framework and the concept of a clemgame as an interactive method for evaluating LLM performance.
        * Explain a bit that clemgames are a dynamic dialogue-based environments where a programmatic game master arbitrates between two LLMs playing a game.
        * Briefly introduce the Deal or No Deal game, highlighting some important elements.
        * Explain that the current set of games in clembench do not cover negotiation and ability to compromise.
        * Mention that the game also tests the LLMs rule following ability and conversational grounding.
        * Mention the main research question, that is, how various LLMs perfrom in this novel clemgame designed to test their negotiation skills.
    * Project Objectives:
        * To design an implement a new clemgame based on deal or no deal.
        * To select and apply appropriate evaluation metrics for accessing the LLMs performance.
        * To conduct an experiment using some LLMs and analyze the results.
        * To identify and discuss strengths, weaknesses, and unique characteristics of the LLMs in this setting.
    * Report Structure:
        * Explain briefly the structure of the report.
* Related Work
    * Large Language Models and their Capabilities.
        * Brief overview of prominent LLM architecture.
        * Discuss the evolution of LLMs from foundation models to instruction-following and chat-optimized models.
    * Dialogue games for LLM evaluation
        * Mention the clembench framework.
        * Elaborate on the purpose of the clembench framework, its structure and benefits.
        * Mention some existing clemgames and what they evaluate, comparing with what my Deal or No Deal game tests.
        * Mention some other works on evaluating LLMs in interactive or dialogue-based environments.
    * Game theory and negotiation ai
        * Mention some related works working on modelling negotiation games. e.g "THE BARGAINING PROBLEM".
        * Discuss some existing research on AI agents in negotiation games.
        * Mention the two papers that try to use Deal or No Deal to train AI systems. (rather than only evaluate them)
* Experiment
    * The Game
        * Explain the core mechanics of the game:
            * A set of items is given to the players.
            * Each player is also given their own secret value function, indicating how much they value each item.
            * Players need to negotiate on how to divide the items between them.
            * Each player is asked to make a secret proposal, indicating which item they want.
            * Any player can make a proposal at any time, or after some number of turns is reached, the game master will ask them to make one.
            * On any case, as soon as one player has made a proposal, the other is asked to make one.
            * If the two proposals are compatible, i.e., there are enough items to satisfy both of them, each player is awarded points based on the value of the items they got.
            * If the proposals are conflicting, both player get zero points.
        * There are three game modes considered in this project.
            * The standard semi-competitive version, where each player is told to maximize their own score.
            * A cooperative version, in which each player is asked to maximize the sum of both players scores.
            * A competitive (zero-sum) version, in which the players are told to maximize the difference between their score and the other players.
        * Instance generation
            * The maximum number of turns is set to 5 for all instances.
            * A random set of between 3 and 5 different item types, selected from a predefined list of 100 possible item words.
            * A random number of total items between 5 and 8.
            * Random non-negative value functions for each player.
            * Generated instances constricted to the following restrictions:
                * The maximum score each player can receive is fixed to 10.
                * Each item is valued by at least one player.
                * At least one item is values by both players.
            * Constraints ensure that every there are no completely unwanted items, and that at most one player can achieve the maximum score. This should lead to the need for more interesting negotiation.
        * Dialogue flow
            * The game starts with the game master giving the player an initial prompt containing the game rules, the set of items and the players value function.
            * Initial prompts for the different game modes only differs in which metric the players are told to optimize.
            * All messages sent thereafter are transmitted directly between the players, and must not follow any specific format, other than not being allowed to include the proposal syntax.
            * As soon as one of the players sends a message containing the proposal syntax (`[Proposal: <number> <item name>, ...]`) the game master instructs the other player to make their own proposal, without giving it the other player proposal.
            * The game master will also instruct the players to make proposals in case the maximum number of turns is reached.
            * The game master does not prompt the players again in case they violate the rules (e.g., not making a proposal when instructed to, malformed proposals, proposals with items that don't exist in the game, etc.), but instead immediately aborts the game.
    * Evaluation Metrics
        * Rule Outcome: Aborted/Lose/Success
        * For the cooperative a simple quality measure is how many points they
        got relative to the maximum achievable.
        * For the semi-competitive game it is a little harder, because we want a score that represents the quality of both players. I decided to use one minus the maximum possible Pareto improvement divided the maximum score per player.
        * Percentage of Pareto optimal game outcomes.
    * Experimental Setup
        * LLM Selection
            * List the LLVs that have been chosen for the evaluation.
            * Show a table with the different models and their attributes (name, release data, parameter count, context window, open/closed weights, citation/link to mode details)
            * Mention the services used to access the LLMs. Mention that the preexisting backend in the clembench framework were used, except for the Azure ones, where a small new backed was build.
        * Game Instances
            * two game modes were evaluated, the semi-competitive one and the cooperative one.
            * Mention that the competitive one was not evaluated because it is difficult to do through self-play, and would require fixing one of the models. The standard clembench setup is to use the same model for all players.
            * Explain that the experiments was run with 50 instances for each combination of the two game modes and three languages. In total that is 50x3x2 = 300 different instances.
            * Mention that the same instances (in terms of item type/item count/value functions) were generated for all three languages: english, german, and italian.
            * All LLMs were evaluated on the same game instances.
        * Experiment Runs
            * Game was implemented using the clembench framework.
            * Experiments were run using the `clem` tool provided by the clembench framework.
            * The experiments were run using the default setting, that is requesting greedy sampling, i.e., temperature set to zero, as has also been done in similar previous work on dialogue game evaluation.
* Results
    * Quantitative Analysis
        * Detailed breakdown of how each LLM fared against each other on the quantitative metrics.
        * Compare also the performance on different game modes and different languages.
        * Which LLMs where the best for different metrics.
        * Which LLMs where the worst for different metrics.
        * Identify and general trend with regards to instance types, e.g., better performance in one mode or some language.
        * Identify and general trend with regards to models, e.g., with respect to model release or parameter count.
    * Qualitative Analysis
        * Provide some example dialogue snippets that illustrate common mistakes.
            * Making a proposal contradicting the previously stated intentions.
            * Players making the proposal for the wrong player. 
            * Players pretending to be the game master.
            * Not using the indicated proposal syntax.
        * Describe general behaviour of different LLMs.
    * Overall Performance Summary
        * High level overview of how each of the LLM performed across the different metrics.
        * Highlight some of the models that performed surprisingly poorly or well.
        * Compare also quickly with the results of the other paper that used deal or no deal using two of the same models. (The results are similar.)
        * Directly answer the research question: how well do the LLMs handle negotiation.
* Conclusion
    * Summary of the key findings and insights.
    * Discuss the contributions of this project: implemented a new clemgame, evaluated some LLMs using it.
    * Mention some limitations: number of LLMs tested, use of only small game instances, analysis of on three languages, no analysis of the strictly competitive setting, did not explore the impact of changing the prompts.
    * Possible future work: Testing more LLMs, increasing the game complexity, experimenting with different prompt templates, automated error analysis, testing the human performance on this game or human-LLM interactions, deeper analysis of the actual negotiation strategies used by the LLMs.
