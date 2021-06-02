/* SQL statements using subqueries to filter the database for requests.Based on The city's Crime Analysis unit provided data requests.   */


/*Question 1  List the name of each officer who has reported more than the average number of crimes officers have reported */
SELECT officer_id
FROM  crime_officers JOIN crime_charges USING(crime_id)
WHERE crime_charges >ALL (SELECT AVG(COUNT(*))FROM crime_charges) ;

                     
/*Question 2 List the criminal names for all criminals who have a less than average number of crimes and aren't listed as violent offenders */
SELECT crmnls.criminal_id, crmnls.first, crmnls.last, crm.crime_id
FROM criminals crmnls
JOIN crimes crm
ON crmnls.criminal_id = crm.criminal_id
WHERE crime_id <ALL (SELECT AVG(COUNT(*)) FROM crimes )
AND crmnls.v_status = 'N';

/*Question 3  List appeal information for each appeal that has less than average number of days between filing and hearing dates */
SELECT * FROM appeals
WHERE AVG((filing_date - hearing_date)) < ALL (SELECT AVG((filing_date - hearing_date));

/*Question 4  List the names of probation officers who have had a less than average number of criminals assigned */
SELECT  prb.last, prb.first, prb.prob_id 
FROM prob_officers prb
JOIN sentences snt
ON prb.prob_id = snt.prob_id
WHERE crime_id <ALL (SELECT AVG (COUNT(*)) FROM sentences;

/*Question 5  List each crime that has had the highest number of appeals recorded */
SELECT crg.crime_id, crg.crime_code, crg.crime_charges, appl.filing_date
FROM crime_charges crg
JOIN appeals appl
ON c.crime_id = a.crime_id
WHERE a.filing_date >ALL (SELECT MAX(filing_date) FROM appeals);

/* Question 6 List the information on crime charges for each charge that has had a fine above average */
SELECT crime_charges
FROM  crime_charges JOIN court_fee USING(crime_id)
WHERE court_fee > ALL (SELECT AVG(COUNT(*))FROM court_fee) ;


/* 7. List the names of all criminals who have had any of the crime code charges involved in crime ID 10089.*/

SELECT crmnls.criminal_id, crmnls.first, crmnls.last, crid.crime_id
FROM criminals crmnls
JOIN crime_code crid
ON crmnls.criminal_id = crid.criminal_id
WHERE crime_code = 10089 



