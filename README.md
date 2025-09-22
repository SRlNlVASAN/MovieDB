# MovieDB
Using data extraction and load in a DW with a star schema design and advanced SQL, we can build a Cinephile's Dream Database to enable efficient analysis.


### Dataset Overview

This dataset, covering **6,820 movies from 1986 to 2016**, was created to analyze key trends in the movie industry. It focuses on questions like:

* How has movie revenue changed over time?
* How do factors like budget, user ratings, and runtime affect a movie's success?
* What is the relationship between actors, directors, and a film's gross revenue?

---

### Dataset Attributes

Each movie entry includes the following information:

* **name**: Title of the movie
* **genre**: Main genre of the movie
* **year**: Year of release
* **released**: Full release date
* **rating**: Movie rating (e.g., R, PG)
* **runtime**: Duration in minutes
* **score**: IMDb user rating
* **votes**: Number of user votes
* **director**: The director
* **writer**: The writer
* **star**: Main actor/actress
* **company**: Production company
* **country**: Country of origin
* **budget**: Movie budget (0 if not available)
* **gross**: Total revenue of the movie
