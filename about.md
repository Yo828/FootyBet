---
title: "Documentation"
output: html_document
---

### Introduction  
The Exploring AFL Total Score betting app visualizes the outcome of Australian Football League (AFL) games in terms of the combined points scored by both teams in any particalur match. The total points scored in the match is being compared the Total Points predicted by bookmakers (i.e. the boomaker would offer roughly even odds for any realised score above or below this predicted total score).

### Purpose  
The purpose of the app is to try to identify specific ranges of predicted bookmaker scores (relating t a specific team) that offers the best value in placing a bet in the future based on past results. See the Output section for more details on how to identify these ranges.  

### How to use the App  

#### User Input
  
**Select Team**  
The user selects one team to view charts for. All the games that this team participated in will be included.  

**Add Smoother**  
The smoother could be helpful in highlighting areas where the total realised score significantly differs from the predicted score (by being further away from 0). This could be areas to focus on for further analysis.  

**Select a Total Score range**  
This is used to focus on a specific range of predicted total scores (possibly highlighted by Smoother as discussed above)

#### Output - Chart  

**x-axis**  
The x-axis represents the full range of predicted scores by bookmakersfor all games the team participated in.  

**y-axis**  
The y-axis represents the difference in the predicted total score for each game and the actual (realised) total score for the same game.   

**Blue line**  
The horizontal blue line indicates 0. A value below 0 indicates that the total score was below the prediction and a value above 0 indicates that it was above.  

**Purple line**  
This will only appear if the Add Smoother has been checked. 

**Green Lines**  
The vertical lines indicate the total score range that has been selected by the user while the horizontal line indicates the Average of the total score difference (as indicated on the y-axis) only for the range that has been selected. When this line is far from 0 (above or below), it could indicate a godo range for a future bet.    

#### Output - Table  
The data in the output table summarizes the important indicators for the total range (the Team) as well as the user selected range.

**1** 
This row shows the minimum and maximum values of the respective data ranges.  

**2**  
This is the average of the total score difference. For the Range, it represents the value of the horizontal green line on the chart.  

**3**  
This indicates the number (count) of games in the respective ranges where the realised total score was *higher* than the predicted total score. Is this number is high in proportion to **4** below, it indicates a good opportunity to place a Total Score "Over" bet in the future, if the predicted total score for a game of the selected team is within the associated range.  

**4**  
This indicates the number (count) of games in the respective ranges where the realised total score was *lower* than the predicted total score. Is this number is high in proportion to **3** above, it indicates a good opportunity to place a Total Score "Under" bet in the future, if the predicted total score for a game of the selected team is within the associated range.  


### Example  

- Select team "Adelaide". All the data points by tehemselves doesn't indicate any obvious opportunities.    
- Add Smoother. Notice the hump that peaks around Total Score of 185. We should investigate this further.  
- Select a Total Score range of 180 to 190. Notice how the horizontal green line is a relatively far distance away from 0. This indicates a possible opportunity.  
- Look at the # Total Score Over versus the # Total Score Under values in the table. The ratio is 3.33 : 1. 

This means that if you (historically) placed an "Over" bet on every game that Adelaide played and where the bookmaker predicted a total game score of between 180 and 190 points, you would've won 20 times and lost 6 times, or, put differently, you would've won $3.33 for every $1 that you lost. 


### Links  
The raw data for this app has been downloaded from [Australia Sports Betting](http://www.aussportsbetting.com/data/historical-afl-results-and-odds-data/) and has been manipulated for use in this project. Only data where all required fields were available have been included.  

Source code for ui.R and server.R files are available here [GitHub](https://github.com/Yo828/DevelopingDataProducts).  

The Shiny app can be executed here [Shiny Apps](https://yo828.shinyapps.io/FootyBetting/)

Explanations of Over and Under betting an be found here:  
(https://en.wikipedia.org/wiki/Over%E2%80%93under), or  
(http://www.oddsshark.com/sports-betting/over-under-betting)
