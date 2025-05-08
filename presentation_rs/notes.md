* Title
* Introduction: Sequential Recommendation
    * Recommender Systems
        * Help users find relevant items (products, movies, news).
        * Many approaches assume static user preferences.
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
        * Most users and items have only a few interactions.
        * Difficult to learn robust user preference patterns from short sequences.
    * Learning Effective User Representations
        * Deep models have many parameters, need lots of data.
        * Next-item prediction alone can overfit and struggle to generalize.
* Introduction: Contrastive Learning
    * Self-Supervised Learning
        * Learning from the data itself without human-created labels.
        * Define some pretext task based on the raw data.
        * Has been effective in other domain like CV and NLP.
    * Contrastive Learning
        * The pretext task is to compare different instances.
        * The model learns to tell similar things apart from dissimilar things.
        * Similar instances can be generated using data augmentation.
        * Positive pair: Two augmented versions from same input.
        * Negative pair: Augmented versions of different inputs.
* CL4SRec: The Proposed Framework
    * User Representation Encoder
        * Takes a user's interaction sequence as input.
        * Produce a user representation as output.
        * Can be implemented using different models.
    * Shared Encoder User for Two Learning Objectives.
        * Recommendation Loss: Standard task of predicting next item in the sequence.
        * Contrastive Loss: Ensures the representations of the two augmented views from the same original sequence are similar, while being dissimilar to views from other users' sequences.
* CL4SRec: Data Augmentation Strategies
    * Item Crop
        * Randomly select a continuous subsequence of the sequence.
    * Item Mask
        * Randomly replace some items with a special mask item.
    * Item Reorder
        * Randomly shuffle items within a continuous subsequence of the sequence.
* CL4SRec: Model Architecture
    * User Representation Model based on SASRec, using a Transformer Encoder
        * Items and position embedding layer
        * Multi-head self-attention
        * Position-wise feed-forward network
        * Layer normalization and dropout for regularization
    * Next item probability prediction
        * Based on dot product between user and item representation.
        * The items closest to the user representation are predicted.
* CL4SRec: Training Process
    * Multi-Task Learning
        * The model is trained to optimize both tasks simultaneously.
        * Total Loss = Recommendation Loss + λ × Contrastive Loss
    * Recommendation Loss:
        * Typically cross-entropy, predicting the true next item versus other items.
        * Uses only a sampled softmax for efficiency.
    * Contrastive Loss:
        * Aims to maximize similarity for positive pairs and minimize for negative pairs.
        * Uses InfoNCE loss.
* Evaluation: Experimental Setup
    * Four public real-world datasets
        * Amazon Beauty, Amazon Sports, Yelp, MovieLens-1M
        * Filtered to only users and items with at least 5 interactions.
        * Only uses item identifiers, not ratings or review text.
        * Interactions grouped by used and ordered by timestamp.
    * Test-validation-train split
        * Last item for testing.
        * Second-to-last item for validation.
    * Evaluation Metrics
        * Hit Ratio: Does the correct item appear in the top-k recommendations?
        * Normalized Discounted Cumulative Gain: Consider also the rank in the top-k at which the correct item appear.
* Evaluation: Comparison With Other Methods
    * Baselines for comparison
        * Non-personalized: Popularity based
        * Non-sequential: BPR-MF, NCF
        * Sequential: GRU4Rec+, SASRec
        * Other: GC-SAN, S³-Rec_MIP
    * CL4SRec outperforms all baselines across all metrics and datasets
        * Particularly effective on sparser datasets
* Evaluation: Influence of Hyper-Parameters
    * All three augmentation methods improve performance over not using CL.
    * The best augmentation method varies by dataset.
    * The proportion of augmentation is also an important hyperparameter.
    * A well-chosen λ is crucial.
* Evaluation: Data Augmentation vs. Contrastive Learning
    * Data Augmentation alone helps
        * Applying augmentations during training improves over standard SASRec.
    * Contrastive Learning on top helps more
        * Full CL4SRec (with CL loss) further improves over just applying augmentations.
* Evaluation: Does CL4SRec Achieve a Better User Representation?
    * Experiment on Yelp Dataset
        * The dataset includes social graph of friends.
        * Compute the histogram of similarity between user representation of friends.
        * Users who are friends have more similar sequence representations under CL4SRec than under SASRec.
        * This suggests CL4SRec learns user representations that are "more meaningful".
* Strengths and Weaknesses of the Paper
    * Strengths
        * First to successfully apply contrastive learning to sequential recommendation in this manner.
        * Improves over state-of-the-art recommendation systems.
        * Performs extensive evaluation to verify those claims.
    * Weaknesses
        * No theoretical analysis of why contrastive learning works well in this setting.
        * Although they claim CL4SRec is "model-agnostic", they only evaluated with a transformer model.
        * Only compare to baseline models with differently tuned hyper-parameters per dataset.
* Quiz
