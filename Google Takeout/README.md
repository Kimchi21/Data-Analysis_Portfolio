# Google Takeout Data Analysis

<p align="center">
  <img src="https://static1.anpoimages.com/wordpress/wp-content/uploads/2020/07/10/google-fit-youtube-hero.png" alt="pic" width="400">
</p>

1. [Overview](#overview)
2. [Methodology](#methodology)
3. [Exploratory Data Analysis](#exploratory-data-analysis)
4. [Results and Conclusion](#results-and-conclusion)
5. [Recommendations](#recommendations)

## Overview<a name="overview"></a>
This analysis encompasses the utilization of Google Takeout, focusing on data extracted from Google Fit and YouTube. It delves into diverse aspects of my activity within these platforms, examining information such as fitness metrics, video consumption patterns, user engagement, and more. By scrutinizing critical data points, the objective is to extract valuable insights that shed light on my behaviors and preferences.

**Key Objectives**:
- Fitness and Activity Trends: Analyzing data from Google Fit to uncover patterns related to my fitness activities, such as step counts, workout duration, speed analysis, and activity types. This exploration aims to understand prevalent fitness trends.

- Video Consumption Patterns: Investigating YouTube data to discern preferences, viewing habits, and popular content categories. This includes metrics like watch time, aiming to grasp trends in video consumption behavior.

## Methodology<a name="methodology"></a>

### Data Source
The data used for this analysis is from Google Takeout. Essentially it's a service  provided by Google that allows users to export and download their data from various Google services. It enables users to create an archive file containing data from products like Gmail, Google Drive, YouTube, Google Photos, and more. For this analysis specifically Google Fit and Youtube are the main platforms that I think are suitable for this thus I exported my personal data. 

My Google Fit data has 288 rows of data starting from February 5, 2023 to November 19, 2023 and as for my Youtube data it has 43100 rows of records based on my watch history starting from July 17, 2023 to November 19, 2023.

### Data Dictionary

#### Google Fit
| Columns              | Data Type         | Description                                                                                                   |
|----------------------|-------------------|---------------------------------------------------------------------------------------------------------------|
| Date                 | Date/Time         | The date of recorded fitness or activity data.                                                                  |
| Move Minutes count   | Numeric (Integer) | The count of minutes spent in physical movement or activity.                                                     |
| Calories (kcal)      | Numeric (Float)   | The amount of calories burned during the specified period.                                                       |
| Distance (m)         | Numeric (Float)   | The distance covered in meters during the specified period.                                                      |
| Heart Points         | Numeric (Integer) | The count of heart points earned based on physical activity.                                                     |
| Heart Minutes        | Numeric (Integer) | The count of minutes during which the heart rate was elevated due to physical activity.                           |
| Low latitude (deg)   | Numeric (Float)   | The latitude coordinates for the lower boundary of the tracked area.                                             |
| Low longitude (deg)  | Numeric (Float)   | The longitude coordinates for the lower boundary of the tracked area.                                            |
| High latitude (deg)  | Numeric (Float)   | The latitude coordinates for the upper boundary of the tracked area.                                             |
| High longitude (deg) | Numeric (Float)   | The longitude coordinates for the upper boundary of the tracked area.                                            |
| Average speed (m/s)  | Numeric (Float)   | The average speed maintained during the activity in meters per second.                                           |
| Max speed (m/s)      | Numeric (Float)   | The maximum speed achieved during the activity in meters per second.                                             |
| Min speed (m/s)      | Numeric (Float)   | The minimum speed maintained during the activity in meters per second.                                           |
| Step count           | Numeric (Integer) | The count of steps taken during the recorded period.                                                             |
| Average weight (kg)  | Numeric (Float)   | The average weight in kilograms recorded during the activity period.                                             |
| Max weight (kg)      | Numeric (Float)   | The maximum weight in kilograms recorded during the activity period.                                             |
| Min weight (kg)      | Numeric (Float)   | The minimum weight in kilograms recorded during the activity period.                                             |
| Biking duration (ms) | Numeric (Integer) | The duration spent on biking in milliseconds.                                                                   |
| Walking duration (ms)| Numeric (Integer) | The duration spent on walking in milliseconds.                                                                  |
| Running duration (ms)| Numeric (Integer) | The duration spent on running in milliseconds.                                                                  |

#### Youtube
| Columns          | Data Type        | Description                                                            |
|------------------|------------------|------------------------------------------------------------------------|
| header           | Categorical (String) | Indicates the source of the activity data (e.g., YouTube).         |
| title            | String           | Title of the video watched on YouTube.                                  |
| titleUrl         | String (URL)     | URL link to the YouTube video.                                          |
| subtitles        | List of Dictionaries | Subtitles or additional information related to the video.          |
| time             | Date/Time        | Timestamp indicating the time when the video was watched.                |
| products         | List of Strings  | Product(s) associated with the activity (e.g., YouTube).                |
| activityControls | List of Strings  | Controls or settings related to activity tracking or history.           |
| description      | List of Strings | Description or details regarding the video content, if available.       |
| details          | List of Dictionaries | Additional details or specifics about the activity, if available.       |

### Data Cleaning and Preprocessing

#### Google Fit

#### Dropping Columns
The columns that I'm gonna keep are the ones that are needed for the analysis. 

So the columns I'm dropping are:
- Low latitude (deg)
- Low longitude (deg)
- High latitude (deg)   
- High longitude (deg)
- Average weight (kg)
- Max weight (kg)  
- Min weight (kg) 

The reason I'm dropping location coordinates is because I do not have a use for them yet. The locations I've only been to during the time period is Batangas City when I was still studying at university and Atimonan, Quezon Province which is my hometown. Unfortunately I wanted to keep the weight metrics becuase I want to keep track of my weight overtime but I didn't keep track or updated my weight everyday so the only time I did set my weight was at the beginning so that is the only record it has.

#### Handling Missing Values
There are a total of 8 values missing from the Move minutes count column. The way this data is tracked is by calculating all their activity. Tracking for this data is a bit inconsistent since I'm also looking at values with similar metrics however they have records in this column. My solution is to based it on Step count so I give 3 count to the 343, and the rest is 1. However I noticed that the second row has almost all null values and the step count is only 16. This means that this column is the one with missing values of distance, and speed, I'm more inclined to delete this row.

#### Activity Duration
There are alot of values missing on the Biking and Running Duration since most of the physical activity I do is walking. I will calculate the total activity duration by summing all 3 values to create a new column for Total Duration.

#### Heart Points and Minutes
This data records the total Heart Points that a user has obtained from all of their activities. Every data point shows how many Heart Points were determined over a certain period of time. This is taken from the Google Fit [developer page](https://developers.google.com/fit/datatypes)

User's can set a daily Heart Point goal and track their progress. Heart Points can be calculated using:
- heart rate
- Metabolic Equivalent of Task (MET) values
- walking speed

The number of Heart Points earned depends on the intensity of the activity. Use this guide to calculate and write Heart Points:

| Data              | 1 HP (Low-medium intensity activity)                          | 2 HPs (High intensity activity)                                           |
|-------------------|----------------------------------------------------------------|----------------------------------------------------------------------------|
| Heart rate        | 1 minute of activity at >50% maximum heart rate                 | 1 minute of activity at >70% max heart rate                                |
| MET value         | 3-6 MET. For example, rowing or rock climbing                  | >6 MET. For example, HIIT, skiing, volleyball or football                  |
| Walking speed     | 100-130 steps per minute                                       | >130 steps per minute                                                      |

Unfortunately manually calculating for Heart Points and Minutes is a very hard task since I don't have access to some sensor data and it is very hard to do even a approximation of point values. I am forced to drop the columns without any record of Heart Points and Minutes

#### Youtube

#### Dropping Columns
So the columns I'm dropping are:
- header
- subtitles
- activityControls
- products

These columns were dropped because I didn't have any particular use for them when conducting my analysis.

#### Formatting
Removed the "Watched" word in the title column and reformatted the details columns to isolate the "From Google Ads".

#### Create a Duration column based on the watch time
The calculation for the duration presented a challenge for me. The original logic I used was the basic subtract the time difference between each video. However, I discovered this logic was flawed since if I just simply subtracted via the time differences but I did not take into account the time I was offline/sleeping/doing-something-else outside Youtube so therefore the ending watch hours resulted in the whole timeframe from July 17 to November 19 essentially (2977 hours). I thought of many things to filter out that "Time Space" and the solution I ultimately choosed was to drop anything longer than 3 hours gap and then continue the by row calculation. Yep it's a shortcut but it's a much better approximation than my previous method.

### New Data Dictionary

#### Google Fit
| Columns                | Data Type        | Description                                                |
|------------------------|------------------|------------------------------------------------------------|
| Date                   | Date/Time        | The date of the recorded fitness or activity data.          |
| Move Minutes count     | Numeric (Integer)| The count of minutes spent in physical movement or activity.|
| Calories (kcal)        | Numeric (Float)  | The amount of calories burned during the specified period.  |
| Distance (m)           | Numeric (Float)  | The distance covered in meters during the specified period. |
| Heart Points           | Numeric (Integer)| The count of heart points earned based on physical activity.|
| Heart Minutes          | Numeric (Integer)| The count of minutes during which the heart rate was elevated due to physical activity.|
| Average speed (m/s)    | Numeric (Float)  | The average speed maintained during the activity in meters per second.|
| Max speed (m/s)        | Numeric (Float)  | The maximum speed achieved during the activity in meters per second.|
| Min speed (m/s)        | Numeric (Float)  | The minimum speed maintained during the activity in meters per second.|
| Step count             | Numeric (Integer)| The count of steps taken during the recorded period.        |
| Biking duration (ms)   | Numeric (Integer)| The duration spent on biking in milliseconds.               |
| Walking duration (ms)  | Numeric (Integer)| The duration spent on walking in milliseconds.              |
| Running duration (ms)  | Numeric (Integer)| The duration spent on running in milliseconds.              |
| Total Duration (ms)    | Numeric (Integer)| The total duration of physical activity recorded in milliseconds.|

**Youtube**
| Columns       | Data Type         | Description                                          |
|---------------|-------------------|------------------------------------------------------|
| title         | String            | Title of the watched YouTube video.                   |
| titleUrl      | String (URL)      | URL link to the YouTube video.                        |
| time          | Date/Time         | Timestamp indicating the time when the video was watched. |
| description   | NaN (Not a Number)| Description or additional details related to the video content, if available. |
| details       | NaN (Not a Number)| Additional information or specifics about the watched video, if available. |
| duration      | Duration (Time)   | Duration of the watched video in hours:minutes:seconds format. |


## Exploratory Data Analysis<a name="exploratory-data-analysis"></a>
The size of the data for Google Fit has changed from being 288 rows down to 202 and for my Youtube data it changed from 43100 records down to 42939.

### Key Insights from EDA

#### Google Fit

#### Trend Analysis

<p align="center">
  <img src="Resources\tab.png" alt="tab" width="600">
</p>

<p align="center">
  <img src="Resources\tal.png" alt="tab" width="600">
</p>

The gaps are due to the drop rows, which don't have heart points recorded on them. From February to August, my move minutes count and heart points gained per day were in line with each other because during this time period I was still studying at university and was mainly focusing on our thesis, so I did not do much physical activity during this time period. On the other hand, during September, I started a nightly routine of walking for 1 hour and 15 minutes to 2 hours every day, thus this spike in all the metrics. The highest amount of heart points I gained in a day is 120 points, which is close to the weekly target of 150 heart points, according to WHO, so essentially I already completed 80% of a weekly target in one day.

#### Correlation/Performance Analysis

<p align="center">
  <img src="Resources\corr.png" alt="corr" width="600">
</p>

1. **Move Minutes count and Other Metrics**:
 - Strong Positive Correlations: Move Minutes count shows strong positive correlations with most other metrics: Calories (kcal), Heart Points, Heart Minutes, Distance (m), and Step count. The correlations range from 0.955 to 1.000, indicating a strong positive linear relationship.
 - Highly Correlated Metrics: Step count, Distance (m), Heart Points, Heart Minutes, and Calories (kcal) exhibit high positive correlations with Move Minutes count, indicating that as Move Minutes count increases, these metrics tend to increase consistently.

2. **Calories (kcal) and Other Metrics**: Calories (kcal) shows similar strong positive correlations as Move Minutes count with Heart Points, Heart Minutes, Distance (m), and Step count.

3. **Heart Points and Heart Minutes**:
 - Extremely High Positive Correlation: Heart Points and Heart Minutes show an almost perfect positive correlation of 0.999986-0.999987, indicating an almost perfect linear relationship. An increase in Heart Points correlates nearly identically with an increase in Heart Minutes.

4. **Distance and Step count**: Distance and Step count are almost perfectly positively correlated (0.999607), showing that they tend to increase together consistently.

5. **Speed Metrics (Average speed, Max speed, Min speed)**:
 - Negative Correlations: Speed metrics show negative correlations with most other metrics but are relatively weaker compared to the strong positive correlations observed earlier. As the speed metrics increase, there's a tendency for the Move Minutes count, Calories, Heart Points, and Heart Minutes to decrease.

#### Speed Analysis

<p align="center">
  <img src="Resources\speed.png" alt="speed" width="600">
</p>

When looking at the various speeds, both average speed and minimum speeds are reasonable and are inline with human capability. However when looking at the max speed it can reach up to 25+ meters per second in value. The only reason I could think of this being recorded was during trips in my friends car when we where conducting our research which required us to go to a coffee farm (Lipa City) outside the city where from (Batangas City).

#### Activity Analysis

<p align="center">
  <img src="Resources\act1.png" alt="act1" width="600">
</p>

<p align="center">
  <img src="Resources\act2.png" alt="act2" width="600">
</p>

In terms of the proportion of my activity duration and respective activity types, walking contributes the most to the number of heart points I gain and the calories I burn.

#### Youtube

#### What content do I typically watch?

<p align="center">
  <img src="Resources\wc1.png" alt="wc1" width="600">
</p>

There are words frequently appearing that are obvious or are in line with the platform. For instance, the "short/s" word references that it might be YouTube shorts that I watched. Words like "https" appear because there are some values in the title column that are not specified and have a url link to the video as a placeholder for it. Another thing to consider is that I use Youtube as the platform where I listen to most of my music, thus the appearance of words like "Official Music", "Music Video", "Video", "Lyric Video", "Live".

<p align="center">
  <img src="Resources\wc2.png" alt="wc2" width="600">
</p>

After filtering through some words a more cohesive visualization of the content I watched on youtube during this time.

Some things to hightlight are:

**Games**
- Blue Archive: I started playing this game at the end of July, have played it ever since, and have watched videos on guides on how to progress faster.
- Genshin Impact: I still actively watch Genshin videos, focusing more on the gameplay and character guides (hence the appearance of the "character" word).
- Victory Nikke (Goddess of Victory: Nikke): I came back to playing this game just recently because of its 1st anniversary event and binge-watched content related to it.
- League of Legends: This is the same with GI, in which I still watch highlight videos from different channels.
- Mortal Kombat: This is the new installment of the game, so I watched content related to it because I couldn't afford the game.

**General Entertainment**
- meme: I watch meme content on Youtube.
- Gaming PC: This mainly pertains to PC building. I love watching these videos since I'm around computers at an early age, so I watch different tech YouTubers build PCs.
- anime: Technically, I play anime-related content, so this might be the reason. I don't use YouTube to watch anime, as I use another app for it (Aniyomi), but I watch some clips of anime content every now and then.
- ASMR: I'm reliant on this type of video because it helps me sleep at night. This is the reason why the word "ear cleaning" also appears, as this is the most common type of ASMR I listen to.
- Virtual Livers: I watch some vtuber content (NIJISANJI EN), especially those vtuber that I genuinely think are entertaining.
- food: I mainly watch food content from Japan and the Philippines.

Overall, my YouTube consumption appears to be a balanced mix of gaming-related content, general entertainment encompassing memes, tech-related videos, anime snippets, ASMR for relaxation, Virtual Livers (NIJISANJI EN), and food-related content from Japan and the Philippines.

#### How many Ads did I encounter?

<p align="center">
  <img src="Resources\ads.png" alt="ads" width="600">
</p>

The "Not Available" counts pertain to videos that are not ads, and the other is, well, ads. The only time I encounter ads is when using Youtube with my phone, as I use an adblocker when I access Youtube on my laptop. I'm surprised that the count of ads (5763) I encountered is low. Then again, I use adblock as YouTube ads are way too aggressive. I think this number will be higher if I didn't use adblock on my laptop, and this count is already 13.4% of the videos I "watched.".

#### What is my average watch/listen time?

<p align="center">
  <img src="Resources\ave.png" alt="ave" width="650">
</p>

Starting from July 17, 2023, to November 19, 2023, my daily average watch or listen time is 16.14 hours, which I think is still an approximation of my actual time. Some key observations are that August 4, 2023, is my graduation day, and I did not access YouTube during this day. The low watch times could be attributed to a power outage. I'm out for social occasions or events. This presents or highlights that my most used application across mobile, desktop, and laptop is indeed YouTube.


## Results and Conclusion<a name="results-and-conclusion"></a>

### Google Fit Analysis

**Trend Analysis**
- The correlation between Move Minutes count and Heart Points reveals distinct trends. From February to August, these metrics aligned due to reduced physical activity during academic commitments. However, a spike in activity from September onwards due to a consistent walking routine led to increased metrics, with the highest daily heart points nearing the WHO's weekly target.

**Correlation/Performance Analysis** 
- Strong positive correlations between Move Minutes count and other metrics such as Calories, Heart Points, Distance, and Step count were observed, indicating a consistent relationship. Heart Points and Heart Minutes showed an almost perfect correlation, while Distance and Step count were closely related.

**Speed Analysis**
- Speed metrics (Average, Max, Min) displayed negative correlations with most other metrics. The high Max speed recorded might have been due to travel in a vehicle during research trips, unlike the more reasonable Average and Minimum speeds.

**Activity Analysis**
- Walking significantly contributed to Heart Points gained and calories burned. This shift in routine impacted the overall metrics significantly.

### Youtube Analysis

**Content Analysis**
- Analysis of frequently occurring words revealed a diverse range of content preferences, including gaming (Blue Archive, Genshin Impact), general entertainment (memes, PC building, anime snippets, ASMR), and specific game-related content (League of Legends, Mortal Kombat).

**Ad Encounters**
- Encountering ads primarily occurred on the mobile app, with a lower count due to ad blocking on the laptop. This represented 13.4% of the videos watched, showcasing the impact of ad blocking on ad exposure.

**Watch/Listen Time**
- The daily average watch or listen time on YouTube over the analyzed period stood at 16.14 hours. Certain days with lower watch times corresponded to significant events or occurrences like graduation or social engagements.

**Conclusion**

The exploratory analysis of Google Fit and YouTube data revealed intricate trends and correlations in fitness metrics and content consumption patterns. Increased physical activity impacted various fitness metrics positively, while YouTube usage patterns demonstrated a diverse range of content preferences. Understanding these trends could help me optimize routines for better fitness outcomes and tailor content strategies for more curated content consumption experiences.

## Recommendations<a name="recommendations"></a>

I guess some things I could recommend to myself are to continue and maintain the walking routine I initiated in September, as it notably increased my physical activity metrics and positively impacted my health indicators. As for my Youtube usage, I think optimizing screen time is necessary to monitor and manage screen time on YouTube so that I can maintain a healthy balance between entertainment, relaxation, and other activities and make sure that YouTube usage doesn't interfere significantly with my other daily routines or activities. Also, I should consider setting personal limits on daily or weekly YouTube usage to strike a balance between entertainment and other aspects of life.
