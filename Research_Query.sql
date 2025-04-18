CREATE DATABASE Research_Case;

USE Research_Case;

SELECT * from dataset;

/*
Scenario 1: Impact of Internet Access on Mental Health
*/

SELECT 
  regular_access_to_internet,
  AVG(CASE WHEN Anxiety = 'Yes' THEN 1 ELSE 0 END) * 100 AS Anxiety_Percentage,
  AVG(CASE WHEN Depression = 'Yes' THEN 1 ELSE 0 END) * 100 AS Depression_Percentage,
  AVG(CASE WHEN Tiredness = 'Yes' THEN 1 ELSE 0 END) * 100 AS Tiredness_Percentage
FROM dataset
GROUP BY regular_access_to_internet;

 /*Scenario 2: Employment Status and Mental Health*/
SELECT 
  unemployed,
  AVG(CASE WHEN Anxiety = 'Yes' THEN 1 ELSE 0 END) * 100 AS Anxiety_Percentage,
  AVG(CASE WHEN Depression = 'Yes' THEN 1 ELSE 0 END) * 100 AS Depression_Percentage
FROM dataset
GROUP BY unemployed;



/*Scenario 3: Regional Differences in Mental Health*/

SELECT 
  Region,
  AVG(CASE WHEN Depression = 'Yes' THEN 1 ELSE 0 END) * 100 AS Depression_Percentage
FROM dataset
GROUP BY Region;

/*Scenario 4: Gender Differences in Mental Health*/
SELECT 
  Gender,
  AVG(CASE WHEN Panic_attacks = 'Yes' THEN 1 ELSE 0 END) * 100 AS Panic_Attacks_Percentage,
  AVG(CASE WHEN Depression = 'Yes' THEN 1 ELSE 0 END) * 100 AS Depression_Percentage
FROM dataset
GROUP BY Gender;

/*Scenario 5: Relationship Between Mental Health and Employment Gaps*/
SELECT 
  gaps_in_months,
  AVG(CASE WHEN Anxiety = 'Yes' THEN 1 ELSE 0 END) * 100 AS Anxiety_Percentage,
  AVG(CASE WHEN Depression = 'Yes' THEN 1 ELSE 0 END) * 100 AS Depression_Percentage
FROM dataset
GROUP BY gaps_in_months;

/*Scenario 6: Mental Health and Living Arrangements*/
SELECT 
  live_with_parents,
  AVG(CASE WHEN Anxiety = 'Yes' THEN 1 ELSE 0 END) * 100 AS Anxiety_Percentage,
  AVG(CASE WHEN Depression = 'Yes' THEN 1 ELSE 0 END) * 100 AS Depression_Percentage,
  AVG(CASE WHEN Mood_swings = 'Yes' THEN 1 ELSE 0 END) * 100 AS Mood_Swings_Percentage
FROM dataset
GROUP BY live_with_parents;

 /*Scenario 7: Mental Health and Education Level*/
SELECT 
  Education,
  AVG(CASE WHEN Anxiety = 'Yes' THEN 1 ELSE 0 END) * 100 AS Anxiety_Percentage,
  AVG(CASE WHEN Depression = 'Yes' THEN 1 ELSE 0 END) * 100 AS Depression_Percentage,
  AVG(CASE WHEN Mood_swings = 'Yes' THEN 1 ELSE 0 END) * 100 AS Mood_Swings_Percentage
FROM dataset
GROUP BY Education;


/*Scenario 8: Device Usage Patterns and Their Association with Mental Health Symptoms*/

SELECT 
    Device_Type,
    AVG(CASE WHEN Compulsive_behavior = 'Yes' THEN 1 ELSE 0 END) * 100 AS Compulsive_Behavior_Percentage,
    AVG(CASE WHEN Lack_of_concentration = 'Yes' THEN 1 ELSE 0 END) * 100 AS Lack_of_Concentration_Percentage
FROM dataset
GROUP BY Device_Type;




/*Scenario 9: Correlation Between Multiple Mental Health Conditions and Employment Status*/
SELECT 
    mental_health_conditions.num_conditions, COUNT(*) AS num_individuals,
    AVG(CASE WHEN employed_at_least_part_time = 'Yes' THEN 1 ELSE 0 END) * 100 AS employment_rate,
    AVG(CASE WHEN unemployed = 'Yes' THEN 1 ELSE 0 END) * 100 AS unemployment_rate,
    AVG(gaps_in_months) AS avg_gap_duration
FROM (
    SELECT id,
        (CASE WHEN Anxiety = 'Yes' THEN 1 ELSE 0 END +
         CASE WHEN Depression = 'Yes' THEN 1 ELSE 0 END +
         CASE WHEN Mood_swings = 'Yes' THEN 1 ELSE 0 END +
         CASE WHEN Panic_attacks = 'Yes' THEN 1 ELSE 0 END +
         CASE WHEN Compulsive_behavior = 'Yes' THEN 1 ELSE 0 END +
         CASE WHEN Tiredness = 'Yes' THEN 1 ELSE 0 END) AS num_conditions
    FROM dataset
) mental_health_conditions
JOIN dataset ON mental_health_conditions.id = dataset.id
GROUP BY mental_health_conditions.num_conditions
ORDER BY mental_health_conditions.num_conditions DESC;


/*Scenario 10: Analyzing Mental Health Trends Across Different Age Groups*/
SELECT 
    Age,
    AVG(CASE WHEN Anxiety = 'Yes' THEN 1 ELSE 0 END) * 100 AS Anxiety_Rate,
    AVG(CASE WHEN Depression = 'Yes' THEN 1 ELSE 0 END) * 100 AS Depression_Rate,
    AVG(CASE WHEN Panic_attacks = 'Yes' THEN 1 ELSE 0 END) * 100 AS Panic_Attack_Rate,
    AVG(CASE WHEN Tiredness = 'Yes' THEN 1 ELSE 0 END) * 100 AS Tiredness_Rate
FROM dataset
GROUP BY Age
ORDER BY Age;


/*Explanation:
- Objective: To identify how mental health condition rates vary across age groups.
- Grouping: By age categories.
- Metrics Calculated: Percentages for various mental health conditions.

Solution:
Age-specific mental health programs can be designed to address the unique needs of each group.*/

/*Scenario 11: Exploring the Relationship Between Education Level and Employment Gaps
Finding:
Education level may influence the duration of employment gaps and the likelihood 
of experiencing mental health conditions during those gaps.*/
SELECT 
    Education,
    AVG(gaps_in_months) AS Avg_Gap_Duration,
    AVG(CASE WHEN Anxiety = 'Yes' THEN 1 ELSE 0 END) * 100 AS Anxiety_Rate_During_Gap
FROM dataset
WHERE gap_in_resume = 'Yes'
GROUP BY Education;


/*Explanation:
- Objective: To analyze how education level affects employment gaps and associated 
  mental health conditions.
- Filtering: Focuses on individuals with employment gaps.
- Metrics Calculated: Average gap duration and anxiety rates during gaps.

Solution:
Education-specific career support and mental health resources can assist individuals 
in minimizing employment gaps and managing related stress.*/


/*Scenario 12: Assessing the Impact of Unemployment on Internet Access and Mental Health
Finding:
Unemployment may reduce regular access to the internet, which in turn could affect 
mental health due to social isolation or lack of resources.*/
SELECT 
    unemployed,
    AVG(CASE WHEN regular_access_to_internet = 'Yes' THEN 1 ELSE 0 END) * 100 AS Internet_Access_Rate,
    AVG(CASE WHEN Depression = 'Yes' THEN 1 ELSE 0 END) * 100 AS Depression_Rate
FROM dataset
GROUP BY unemployed;

/*Explanation:
- Objective: To explore the relationship between unemployment, internet access, and depression.
- Grouping: Based on unemployment status.
- Metrics Calculated: Internet access rates and depression rates.

Solution:
- Providing internet access to unemployed individuals may help reduce feelings of 
  isolation and provide better access to job opportunities and mental health resources.
- Insight: Unemployed individuals may have lower internet access and higher depression rates.
- Recommendation: Programs that offer internet access and mental health support 
to unemployed individuals.

*/