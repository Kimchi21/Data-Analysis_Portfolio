CREATE DATABASE IF NOT EXISTS ocd;

USE ocd;

CREATE TABLE patient_info (
    PatientID INT,
    Age INT,
    Gender VARCHAR(10),
    Ethnicity VARCHAR(50),
    MaritalStatus VARCHAR(20),
    EducationLevel VARCHAR(50),
    OCDDiagnosisDate DATE,
    DurationOfSymptoms INT,
    PreviousDiagnoses VARCHAR(100),
    FamilyHistoryOfOCD VARCHAR(3),
    ObsessionType VARCHAR(50),
    CompulsionType VARCHAR(50),
    YBOCSScoreObsessions INT,
    YBOCSScoreCompulsions INT,
    DepressionDiagnosis VARCHAR(3),
    AnxietyDiagnosis VARCHAR(3),
    Medications VARCHAR(50)
);

SELECT *
FROM ocd.patient_info;

-- check
SHOW VARIABLES LIKE "local_infile";

-- import local data
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Data/ocd/ocd_patient_dataset.csv' INTO TABLE patient_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;