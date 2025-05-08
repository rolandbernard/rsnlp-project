* Title
* Introduction: Sequential Recommendation
    * Recommender Systems
        * Help users find relevant items (products, movies, news).
        * Many approaches assume static user preferences.
        * 
    * Sequential Recommendation
        * Recommendations based on a user's interaction history.
        * Able to better capture dynamic user interests over time.
        * Example: If the viewer just viewed running shoes and athletic socks, recommend running shorts.
* Introduction: Sequential Recommendation
    * Formulation as a prediction task
        * Given a historical interaction sequence of a user.
        * Predict the next item the user will interact with.
        * Very similar to the language modelling task in NLP.
* Introduction: Challenges in Sequential Recommendation
    * Data Sparsity
        * Many users have only a few interactions.
        * Difficult to learn robust user preference patterns from short sequences.
    * Learning Effective User Representations
        * Representing the evolving user interest effectively is crucial but hard.
        * Traditional methods might struggle to capture complex patterns or long-term dependencies.
* Introduction: Contrastive Learning
    * Self-Supervised Learning
        * Learning from the data itself without human-created labels.
        * Define some pretext task based on the raw data.
        * Has been effective in other domain like CV and NLP.
    * Contrastive Learning
        * The pretext task is to compare different instances.
        * The model learns to tell similar things apart from dissimilar things.
        * Similar instances can be generated using data augmentation.
* CL4SRec: The Proposed Framework
    
* CL4SRec: Data Augmentation Strategies
* CL4SRec: Model Architecture and Training
* Evaluation: Experimental Setup
* Evaluation: Comparison With Other Methods
* Evaluation: Influence of Hyper-Parameters
* Evaluation: Data Augmentation vs. Contrastive Learning
* Evaluation: Does CL4SRec Achieve a Better User Representation?
* Strengths and Weaknesses of the Paper
