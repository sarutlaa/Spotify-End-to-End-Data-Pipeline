
# Spotify's-End-to-End-Data-Pipeline

Leveraging AWS Services for Enhanced Music Streaming Insights specifically tailored for extracting, transforming, and loading (ETL) Spotify's data to gain profound insights into the dynamics of the Top 100 Global playlists. The data pipeline commences by retrieving information from the Spotify API, then processing the data to make it suitable for analysis. The refined data is subsequently loaded into Amazon S3, and Amazon Athena is employed to query the processed data. AWS Glue plays a pivotal role in cataloging and managing metadata throughout the process.


## AWS Services Used

1. **AWS S3 (Simple Service Storage)**    :
    Amazon S3 (Simple Storage Service) is a       highly scalable and versatile object storage service offered by Amazon Web Services (AWS).
2. **AWS Lambda**    :
    AWS Lambda is a serverless compute service provided by Amazon Web Services (AWS) that enables developers to run code without provisioning 
    or managing servers. It allows you to execute code in response to events and automatically scales the infrastructure based on the workload. 
    AWS Lambda code can be triggered to the response to events like changes in S3, CloudWatch or other AWS services
3. **AWS Cloud Watch**    :
    Amazon CloudWatch, provided by Amazon Web Services (AWS), is a robust monitoring and observability service. It 
    empowers users to gather and monitor diverse metrics, oversee log files, establish alarms, and automatically take actions in response 
    to modifications in AWS resources.
5. **AWS Glue**     :
    AWS Glue is a fully managed extract, transform, and load (ETL) service provided by Amazon Web Services (AWS). It simplifies the process 
    of preparing and loading data for analytics, allowing developers and data engineers to build scalable and efficient data pipelines. AWS Glue
    Data Catalg is a metadata repository that makes it easy to discover and manage data in AWS.
6. **AWS Athena**    :
    Amazon Athena is an interactive query service provided by Amazon Web Services (AWS) that allows users to analyze data directly in Amazon Simple
    Storage Service (S3) using standard SQL queries. Athena is serverless, meaning there is no infrastructure to manage, and it scales automatically
    to handle large datasets.


## Languages/Packages Used

1. Python Pandas
2. SQL - Structured Query Langugae
2. SpotifyAPI - spotipy 


## Architecture


    [![Architecture](https://github.com/sarutlaa/Spotify-End-to-End-Data-Pipeline/assets/141533429/8b85c3c4-c633-4858-a9c1-daf14a81d1b9)](https://github.com/sarutlaa/Spotify-End-to-End-Data-Pipeline/blob/main/Architecture.png)


## Project WorkFlow



    Step 1: In this project the data from Spotify   API is feteched and stored in S3 through the lambda function code.
    Two buckets namely, raw_data and transformed data are created accordingly.
    Step 2: Upon loading the data into the S3, the transformation lambda function is triggered and the .json file is 
    converted into the tables to do 2 tasks:
        - Creating the transformed data ( artists, albums, songs) into the transformed S3 bucket using pandas in lambda 
        functions. 
        - Once the transformation is done, the older files are moved to the processed bucket inside the transformation
        bucket.
    Step 3: Once the transformed data is available in S3 bucket, AWS Glue crawlers are created to crawl the repective 
    S3 buckets and fetch the data into the specified database.
    Step 4:  The tables from AWS DataCatalog are accessed through the Athena to get the meaning insights of the different 
    tables built. Please refer to the .sql files attached for the insights found on songs, album and artists data. 

In a nutshell, Its execution flow is :

Extract Data from Spotify API ----> Triggering Lambda Functions( Every 1 day) ----> Run the extract code ---->
Store the raw data in S3 bucket ----> Trigger tranform function whenever new data is in S3 raw data bucket ---->
Transform data and Load it in AWS Data Catalog tables ----> Finding the insights about the Top 100 songs using Athena. 

## Data Source: 


Spotify API developers account : https://developer.spotify.com/ , For access to the Spotify Playlists.


## Things to Note Down
1. Make sure to user the IAM user roles for accessing the AWS services and Allocate IAM policies for the AWS services interacting with each other.
2. I faced an issue while loading the data from the AWS Glue crawler into Athena, the issue was the data feteched was not in proper format, I figured out that, the SerDe in AWS Glue by defalut is of the format "org.apache.hadoop.mapred.TextInputFormat", But instead to resolve the comma separated issue, you can use "org.apache.hadoop.hive.serde2.OpenCSVSerde" parameter.
3. Second issue was the AWS Glue was not reading the proper column names for the artist table created through crawler. One has to edit the column names manually from the Edit JSON option.
4. Even though the transformation code in the Lambda Function is written to get the datetime format for date related columns. AWS Glue crawler has considered it as a STRING type. Convert this STRING type to date format using date_parse in Athena for Date time related SQL Analysis.
5. This Project can further be enhanced by importing the Athena results/tables in to the Visualization Tools like Tableau or Amazon Quicksight. 
