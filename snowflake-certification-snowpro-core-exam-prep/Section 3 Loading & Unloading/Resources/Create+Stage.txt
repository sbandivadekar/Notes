// Show all named stages
SHOW STAGES;

// List files in user stage;
LIST @~;

// List files in user stage;
LIST @%LOAN_PAYMENT;


// Database to manage stage objects, fileformats etc.

CREATE OR REPLACE DATABASE manage_db;

CREATE OR REPLACE SCHEMA external_stages;


// Creating external stage

CREATE OR REPLACE STAGE manage_db.external_stages.aws_stage
    url='s3://bucketsnowflakes3'
    credentials=(aws_key_id='ABCD_DUMMY_ID' aws_secret_key='1234abcd_key');


// Description of external stage

DESC STAGE manage_db.external_stages.aws_stage; 
    
    
// Alter external stage   

ALTER STAGE aws_stage
    SET credentials=(aws_key_id='XYZ_DUMMY_ID' aws_secret_key='987xyz');
    
    
// Publicly accessible staging area    

CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage
    url='s3://bucketsnowflakes3';

// List files in stage

LIST @aws_stage;



