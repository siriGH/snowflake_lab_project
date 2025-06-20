// Create a Schema for External Stages

CREATE OR REPLACE SCHEMA MYDB.external_stages;

// Publicly accessible staging area    
CREATE OR REPLACE STAGE MYDB.external_stages.aws_ext_stage
    url='s3://bucketsnowflakes3';

// listing the files in external stage
list @MYDB.external_stages.aws_ext_stage;

//Case 1: Just Viewing Data from ext stage
select $1, $2, $3, $4, $5, $6 from @MYDB.external_stages.aws_ext_stage/OrderDetails.csv;

//Giving Alias Names to fields
select $1 as OID, $2 as AMT, $3 as PFT, $4 as QNT, $5 as CAT, $6 as SUBCAT 
from @MYDB.external_stages.aws_ext_stage/OrderDetails.csv;

select $1 as OID, $4 as QNT, $2 as AMT from @MYDB.external_stages.aws_ext_stage/OrderDetails.csv;
	

// Transforming Data while loading

// Case 2: load only required fields

CREATE OR REPLACE TABLE MYDB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT
    );
	
COPY INTO MYDB.PUBLIC.ORDERS_EX
    FROM (select s.$1, s.$2 from @MYDB.external_stages.aws_ext_stage s)
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files=('OrderDetails.csv');    

SELECT * FROM MYDB.PUBLIC.ORDERS_EX;

  
// Case3: applying basic transformation by using functions

CREATE OR REPLACE TABLE MYDB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    PROFIT INT,
	AMOUNT INT,    
    CAT_SUBSTR VARCHAR(5),
    CAT_CONCAT VARCHAR(60),
	PFT_OR_LOSS VARCHAR(10)
  );

//Copy Command using a SQL function
COPY INTO MYDB.PUBLIC.ORDERS_EX 
    FROM (select 
            s.$1,
            s.$3,
			s.$2,
            substring(s.$5,1,5),
            concat($5,$6), -- or simply $5||$6
            CASE WHEN s.$3 <= 0 THEN 'LOSS' ELSE 'PROFIT' END 
          FROM @MYDB.external_stages.aws_ext_stage s)
	file_format= (type = csv field_delimiter=',' skip_header=1)
	FILES=('OrderDetails.csv');

SELECT * FROM MYDB.PUBLIC.ORDERS_EX;

// Case 4: Loading sequence numbers in columns

// Create a sequence
create sequence seq1;

CREATE OR REPLACE TABLE MYDB.PUBLIC.LOAN_PAYMENT (
  "SEQ_ID" number default seq1.nextval,
  "Loan_ID" STRING,
  "loan_status" STRING,
  "Principal" STRING,
  "terms" STRING,
  "effective_date" STRING,
  "due_date" STRING,
  "paid_off_time" STRING,
  "past_due_days" STRING,
  "age" STRING,
  "education" STRING,
  "Gender" STRING
 );
 
//Loading the data from S3 bucket
COPY INTO PUBLIC.LOAN_PAYMENT("Loan_ID", "loan_status", "Principal", "terms", "effective_date", "due_date",
"paid_off_time", "past_due_days", "age", "education", "Gender")
    FROM s3://bucketsnowflakes3/Loan_payments_data.csv
    file_format = (type = csv  field_delimiter = ','  skip_header=1);  
				   
//Validate the data
SELECT * FROM PUBLIC.LOAN_PAYMENT;


// Case 5: Using auto increment 

CREATE OR REPLACE TABLE MYDB.PUBLIC.LOAN_PAYMENT2 (
  "LOAN_SEQ_ID" number autoincrement start 1001 increment 1,
  "Loan_ID" STRING,
  "loan_status" STRING,
  "Principal" STRING,
  "terms" STRING,
  "effective_date" STRING,
  "due_date" STRING,
  "paid_off_time" STRING,
  "past_due_days" STRING,
  "age" STRING,
  "education" STRING,
  "Gender" STRING
 );
 
//Loading the data from S3 bucket
COPY INTO PUBLIC.LOAN_PAYMENT2("Loan_ID", "loan_status", "Principal", "terms", "effective_date", "due_date",
"paid_off_time", "past_due_days", "age", "education", "Gender")
    FROM s3://bucketsnowflakes3/Loan_payments_data.csv
    file_format = (type = csv  field_delimiter = ','  skip_header=1);  
				   
//Validate the data
SELECT * FROM PUBLIC.LOAN_PAYMENT2;
