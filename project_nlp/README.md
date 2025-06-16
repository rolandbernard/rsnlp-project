Evaluating the Negotiation Abilities of Large Language Models Using Game Play
=============================================================================

This project presents an implementation of a new [clemgame](https://clembench.github.io/), a variant of the Deal or No Deal negotiation game, and uses the game to evaluate a number of recent closed- and open-weight large language models.

## Key Project Deliverables

For evaluation purposes, the most important files are:

* **Project Report:** `report/main.pdf` - The comprehensive project report.
* **Game Implementation:** `clemgame-dond/dond` - Contains the complete implementation of the clemgame.
* **Evaluation:** `clemgame-dond/` - Additionally contains some scripts and utilities for running the evaluation and the raw results can be found in `clemgame-dond/results/`.

## Project Structure

The project is organized into the following main directories:

* `clemgame-dond/`: The implementation of the clemgame and the raw results obtained from the evaluation. More information about the structure of the implementation can be found [here](./clemgame-dond/README.md). Also look there if you want to run the evaluation of your own, possibly with different models or parameters.
* `report/`: Project report (LaTeX source and PDF).
* `scripts/`: Contains some scripts used to generate plots and summarize the raw evaluation results.
