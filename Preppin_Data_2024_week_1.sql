/*Input the data
Split the Flight Details field to form:
Date 
Flight Number
From
To
Class
Price
Convert the following data fields to the correct data types:
Date to a date format
Price to a decimal value
Change the Flow Card field to Yes / No values instead of 1 / 0
Create two tables, one for Flow Card holders and one for non-Flow Card holders
Output the data sets*/

SELECT *
    FROM TIL_DATASCHOOL.DS36.PD_2024_W1;

WITH CTE AS
(SELECT STRTOK_TO_ARRAY(flight_details, '//') AS arr
      ,arr[0]::date AS Departure_Date
      ,arr[1]::string AS Flight_Number
      ,arr[2]::string AS From_To
      ,arr[3]::string AS Class
      ,arr[4]::double AS Price
      ,CASE
      WHEN flow_card=1 THEN 'YES'
      ELSE 'NO'
      END AS Flow_Card
      ,bags_checked
      ,meal_type
FROM TIL_DATASCHOOL.DS36.PD_2024_W1
)
,CTE1 AS
(SELECT 
      Departure_date
      ,Flight_Number
      ,From_To
      ,Class
      ,Price
      ,Flow_Card
      ,Bags_Checked
      ,Meal_Type
FROM CTE
)
, CTE2 AS
(
SELECT Departure_date
      ,Flight_Number
      ,STRTOK_TO_ARRAY(From_To, '-') AS arr 
      ,arr[0]::string AS From_
      ,arr[1]::string AS To_
      ,Class
      ,Price
      ,Flow_Card
      ,Bags_Checked
      ,Meal_Type
FROM CTE1
      where Flow_Card='NO' --YES for card users
)
SELECT Departure_date
      ,Flight_Number
      ,From_
      ,To_
      ,Class
      ,Price
      ,Flow_Card
      ,Bags_Checked
      ,Meal_Type
FROM CTE2;
      

