SELECT *
FROM ocd.patient_info;

-- Distribution Breakdown

-- Gender
SELECT Gender, COUNT(Gender) AS Count, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ocd.patient_info)), 2) AS Percentage
FROM ocd.patient_info
GROUP BY Gender
ORDER BY Percentage DESC;

-- Ethnicity
SELECT Ethnicity, COUNT(Ethnicity) AS Count, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ocd.patient_info)), 2) AS Percentage
FROM ocd.patient_info
GROUP BY Ethnicity
ORDER BY Percentage DESC;

-- Marital Status
SELECT MaritalStatus, COUNT(MaritalStatus) AS Count, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ocd.patient_info)), 2) AS Percentage
FROM ocd.patient_info
GROUP BY MaritalStatus
ORDER BY Percentage DESC;

-- Education Level
SELECT EducationLevel, COUNT(EducationLevel) AS Count, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ocd.patient_info)), 2) AS Percentage
FROM ocd.patient_info
GROUP BY EducationLevel
ORDER BY Percentage DESC;

-- Previous Diagnoses
SELECT PreviousDiagnoses, COUNT(PreviousDiagnoses) AS Count, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ocd.patient_info)), 2) AS Percentage
FROM ocd.patient_info
GROUP BY PreviousDiagnoses
ORDER BY Percentage DESC;

-- Family History Of OCD
SELECT FamilyHistoryOfOCD, COUNT(FamilyHistoryOfOCD) AS Count, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ocd.patient_info)), 2) AS Percentage
FROM ocd.patient_info
GROUP BY FamilyHistoryOfOCD
ORDER BY Percentage DESC;

-- Obsession Type
SELECT ObsessionType, COUNT(ObsessionType) AS Count, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ocd.patient_info)), 2) AS Percentage
FROM ocd.patient_info
GROUP BY ObsessionType
ORDER BY Percentage DESC;

-- Compulsion Type
SELECT CompulsionType, COUNT(CompulsionType) AS Count, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ocd.patient_info)), 2) AS Percentage
FROM ocd.patient_info
GROUP BY CompulsionType
ORDER BY Percentage DESC;

-- Depression Diagnosis
SELECT DepressionDiagnosis, COUNT(DepressionDiagnosis) AS Count, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ocd.patient_info)), 2) AS Percentage
FROM ocd.patient_info
GROUP BY DepressionDiagnosis
ORDER BY Percentage DESC;

-- Anxiety Diagnosis
SELECT AnxietyDiagnosis, COUNT(AnxietyDiagnosis) AS Count, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ocd.patient_info)), 2) AS Percentage
FROM ocd.patient_info
GROUP BY AnxietyDiagnosis
ORDER BY Percentage DESC;

-- Medications
SELECT Medications, COUNT(Medications) AS Count, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ocd.patient_info)), 2) AS Percentage
FROM ocd.patient_info
GROUP BY Medications
ORDER BY Percentage DESC;

-- Y-BOCS Score Obsessions Distribuition
SELECT t1.YBOCSScoreObsessions, t1.Count, t2.AverageYBOCSScoreObsessions, t3.MinimumYBOCSScoreObsessions, t3.MaximumYBOCSScoreObsessions, t4.STDYBOCSScoreObsessions
FROM (
    SELECT YBOCSScoreObsessions, COUNT(*) AS Count
    FROM ocd.patient_info
    GROUP BY YBOCSScoreObsessions
    ORDER BY Count DESC
) AS t1
JOIN (
    SELECT AVG(YBOCSScoreObsessions) AS AverageYBOCSScoreObsessions
    FROM ocd.patient_info
) AS t2
JOIN (
    SELECT MIN(YBOCSScoreObsessions) AS MinimumYBOCSScoreObsessions, MAX(YBOCSScoreObsessions) AS MaximumYBOCSScoreObsessions
    FROM ocd.patient_info
) AS t3
JOIN (
    SELECT STD(YBOCSScoreObsessions) AS STDYBOCSScoreObsessions
    FROM ocd.patient_info
) AS t4;

-- Y-BOCS Score Compulsions Distribuition
SELECT t1.YBOCSScoreCompulsions, t1.Count, t2.AverageYBOCSScoreCompulsions, t3.MinimumYBOCSScoreCompulsions, t3.MaximumYBOCSScoreCompulsions, t4.STDYBOCSScoreCompulsions
FROM (
    SELECT YBOCSScoreCompulsions, COUNT(*) AS Count
    FROM ocd.patient_info
    GROUP BY YBOCSScoreCompulsions
    ORDER BY Count DESC
) AS t1
JOIN (
    SELECT AVG(YBOCSScoreCompulsions) AS AverageYBOCSScoreCompulsions
    FROM ocd.patient_info
) AS t2
JOIN (
    SELECT MIN(YBOCSScoreCompulsions) AS MinimumYBOCSScoreCompulsions, MAX(YBOCSScoreCompulsions) AS MaximumYBOCSScoreCompulsions
    FROM ocd.patient_info
) AS t3
JOIN (
    SELECT STD(YBOCSScoreCompulsions) AS STDYBOCSScoreCompulsions
    FROM ocd.patient_info
) AS t4;

-- Comparative Analysis

-- Based on Obsession Type and Compulsion Type
-- By Gender
SELECT
    ObsessionType,
    SUM(CASE WHEN Gender = 'Female' THEN Count ELSE 0 END) AS Female,
    SUM(CASE WHEN Gender = 'Male' THEN Count ELSE 0 END) AS Male
FROM (
    SELECT
        ObsessionType,
        Gender,
        COUNT(*) AS Count
    FROM ocd.patient_info
    GROUP BY ObsessionType, Gender
) AS subquery
GROUP BY ObsessionType;

SELECT
    CompulsionType,
    SUM(CASE WHEN Gender = 'Female' THEN Count ELSE 0 END) AS Female,
    SUM(CASE WHEN Gender = 'Male' THEN Count ELSE 0 END) AS Male
FROM (
    SELECT
        CompulsionType,
        Gender,
        COUNT(*) AS Count
    FROM ocd.patient_info
    GROUP BY CompulsionType, Gender
) AS subquery
GROUP BY CompulsionType;

-- By Ethnicity
SELECT
    ObsessionType,
    SUM(CASE WHEN Ethnicity = 'African' THEN Count ELSE 0 END) AS African,
    SUM(CASE WHEN Ethnicity = 'Hispanic' THEN Count ELSE 0 END) AS Hispanic,
    SUM(CASE WHEN Ethnicity = 'Asian' THEN Count ELSE 0 END) AS Asian,
    SUM(CASE WHEN Ethnicity = 'Caucasian' THEN Count ELSE 0 END) AS Caucasian
FROM (
    SELECT
        ObsessionType,
        Ethnicity,
        COUNT(*) AS Count
    FROM ocd.patient_info
    GROUP BY ObsessionType, Ethnicity
) AS subquery
GROUP BY ObsessionType;

SELECT
    CompulsionType,
    SUM(CASE WHEN Ethnicity = 'African' THEN Count ELSE 0 END) AS African,
    SUM(CASE WHEN Ethnicity = 'Hispanic' THEN Count ELSE 0 END) AS Hispanic,
    SUM(CASE WHEN Ethnicity = 'Asian' THEN Count ELSE 0 END) AS Asian,
    SUM(CASE WHEN Ethnicity = 'Caucasian' THEN Count ELSE 0 END) AS Caucasian
FROM (
    SELECT
        CompulsionType,
        Ethnicity,
        COUNT(*) AS Count
    FROM ocd.patient_info
    GROUP BY CompulsionType, Ethnicity
) AS subquery
GROUP BY CompulsionType;

-- By Marital Status
SELECT
    ObsessionType,
    SUM(CASE WHEN MaritalStatus = 'Single' THEN Count ELSE 0 END) AS Single,
    SUM(CASE WHEN MaritalStatus = 'Divorced' THEN Count ELSE 0 END) AS Divorced,
    SUM(CASE WHEN MaritalStatus = 'Married' THEN Count ELSE 0 END) AS Married
FROM (
    SELECT
        ObsessionType,
        MaritalStatus,
        COUNT(*) AS Count
    FROM ocd.patient_info
    GROUP BY ObsessionType, MaritalStatus
) AS subquery
GROUP BY ObsessionType;

SELECT
    CompulsionType,
    SUM(CASE WHEN MaritalStatus = 'Single' THEN Count ELSE 0 END) AS Single,
    SUM(CASE WHEN MaritalStatus = 'Divorced' THEN Count ELSE 0 END) AS Divorced,
    SUM(CASE WHEN MaritalStatus = 'Married' THEN Count ELSE 0 END) AS Married
FROM (
    SELECT
        CompulsionType,
        MaritalStatus,
        COUNT(*) AS Count
    FROM ocd.patient_info
    GROUP BY CompulsionType, MaritalStatus
) AS subquery
GROUP BY CompulsionType;

-- By Education Level
SELECT
    ObsessionType,
    SUM(CASE WHEN EducationLevel = 'Some College' THEN Count ELSE 0 END) AS `Some College`,		 -- Enclosed in backticks for spaces
    SUM(CASE WHEN EducationLevel = 'College Degree' THEN Count ELSE 0 END) AS `College Degree`,
    SUM(CASE WHEN EducationLevel = 'High School' THEN Count ELSE 0 END) AS `High School`,
    SUM(CASE WHEN EducationLevel = 'Graduate Degree' THEN Count ELSE 0 END) AS `Graduate Degree`
FROM (
    SELECT
        ObsessionType,
        EducationLevel,
        COUNT(*) AS Count
    FROM ocd.patient_info
    GROUP BY ObsessionType, EducationLevel
) AS subquery
GROUP BY ObsessionType;

SELECT
    CompulsionType,
    SUM(CASE WHEN EducationLevel = 'Some College' THEN Count ELSE 0 END) AS `Some College`,		 -- Enclosed in backticks for spaces
    SUM(CASE WHEN EducationLevel = 'College Degree' THEN Count ELSE 0 END) AS `College Degree`,
    SUM(CASE WHEN EducationLevel = 'High School' THEN Count ELSE 0 END) AS `High School`,
    SUM(CASE WHEN EducationLevel = 'Graduate Degree' THEN Count ELSE 0 END) AS `Graduate Degree`
FROM (
    SELECT
        CompulsionType,
        EducationLevel,
        COUNT(*) AS Count
    FROM ocd.patient_info
    GROUP BY CompulsionType, EducationLevel
) AS subquery
GROUP BY CompulsionType;

-- Previous Diagnoses
SELECT
    ObsessionType,
    SUM(CASE WHEN PreviousDiagnoses = 'MDD' THEN Count ELSE 0 END) AS MDD,
    SUM(CASE WHEN PreviousDiagnoses = 'None' THEN Count ELSE 0 END) AS None,
    SUM(CASE WHEN PreviousDiagnoses = 'PTSD' THEN Count ELSE 0 END) AS PTSD,
	SUM(CASE WHEN PreviousDiagnoses = 'GAD' THEN Count ELSE 0 END) AS GAD,
    SUM(CASE WHEN PreviousDiagnoses = 'Panic Disorder' THEN Count ELSE 0 END) AS `Panic Disorder`
FROM (
    SELECT
        ObsessionType,
        PreviousDiagnoses,
        COUNT(*) AS Count
    FROM ocd.patient_info
    GROUP BY ObsessionType, PreviousDiagnoses
) AS subquery
GROUP BY ObsessionType;

SELECT
    CompulsionType,
    SUM(CASE WHEN PreviousDiagnoses = 'MDD' THEN Count ELSE 0 END) AS MDD,
    SUM(CASE WHEN PreviousDiagnoses = 'None' THEN Count ELSE 0 END) AS None,
    SUM(CASE WHEN PreviousDiagnoses = 'PTSD' THEN Count ELSE 0 END) AS PTSD,
	SUM(CASE WHEN PreviousDiagnoses = 'GAD' THEN Count ELSE 0 END) AS GAD,
    SUM(CASE WHEN PreviousDiagnoses = 'Panic Disorder' THEN Count ELSE 0 END) AS `Panic Disorder`
FROM (
    SELECT
        CompulsionType,
        PreviousDiagnoses,
        COUNT(*) AS Count
    FROM ocd.patient_info
    GROUP BY CompulsionType, PreviousDiagnoses
) AS subquery
GROUP BY CompulsionType;

-- By Family History Of OCD
SELECT
    ObsessionType,
    SUM(CASE WHEN FamilyHistoryOfOCD = 'No' THEN Count ELSE 0 END) AS No,
    SUM(CASE WHEN FamilyHistoryOfOCD = 'Yes' THEN Count ELSE 0 END) AS Yes
FROM (
    SELECT
        ObsessionType,
        FamilyHistoryOfOCD,
        COUNT(*) AS Count
    FROM ocd.patient_info
    GROUP BY ObsessionType, FamilyHistoryOfOCD
) AS subquery
GROUP BY ObsessionType;

SELECT
    CompulsionType,
    SUM(CASE WHEN FamilyHistoryOfOCD = 'No' THEN Count ELSE 0 END) AS No,
    SUM(CASE WHEN FamilyHistoryOfOCD = 'Yes' THEN Count ELSE 0 END) AS Yes
FROM (
    SELECT
        CompulsionType,
        FamilyHistoryOfOCD,
        COUNT(*) AS Count
    FROM ocd.patient_info
    GROUP BY CompulsionType, FamilyHistoryOfOCD
) AS subquery
GROUP BY CompulsionType;