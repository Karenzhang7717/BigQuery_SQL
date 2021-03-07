USE COMPETITION;

#Q1
SELECT C.Lname, C.Fname, T.StudioName FROM COMPETITOR AS C, TEACHER AS T WHERE C.TeacherID=T.TeacherID;

#Q2
SELECT T.StudioName, COUNT(*) AS StudentCount FROM COMPETITOR AS C, TEACHER AS T WHERE C.TeacherID=T.TeacherID GROUP BY T.StudioName;

#Q3
SELECT T.StudioName, COUNT(*) AS TeacherCount FROM TEACHER AS T GROUP BY T.StudioName;

#Q4
SELECT T.Lname, COUNT(*) AS StudentCount FROM COMPETITOR AS C, TEACHER AS T WHERE C.TeacherID=T.TeacherID
GROUP BY T.Lname HAVING count(T.Lname)>1;

#Q5
SELECT C.Fname, C.Lname, O.Title, O.Genre FROM COMPETITOR AS C, COMPOSITION AS O, PERFORMANCE AS P
WHERE C.CompetitorID=P.CompetitorID AND O.Genre='Romantic';

#Q6
SELECT O.*, P.CategoryID FROM COMPOSITION AS O 
LEFT OUTER JOIN PERFORMANCE AS P ON O.MusicID=P.MusicID;

#Q7
DROP VIEW IF EXISTS SCORE_ANALYSIS;
CREATE VIEW SCORE_ANALYSIS 
AS SELECT C.Age, P.Score FROM COMPETITOR AS C, PERFORMANCE AS P
WHERE C.CompetitorID=P.CompetitorID;

#Q8
SELECT* FROM SCORE_ANALYSIS
ORDER BY Score DESC;

#Q9
SELECT MAX(Score), AVG(Score), MIN(Score) FROM SCORE_ANALYSIS;

#Q10
ALTER TABLE COMPOSITION 
ADD Copyright varchar(30) DEFAULT 'SOCAN';
SELECT * FROM COMPOSITION;

#Q11
SELECT LName, FName FROM COMPETITOR AS C 
WHERE NOT EXISTS(SELECT LName, FName 
FROM (PERFORMANCE AS P JOIN COMPETITOR AS CO ON P.CompetitorID=CO.CompetitorID) JOIN CATEGORY AS A ON P.CategoryID=A.CategoryID
WHERE CO.Age <=A.AgeMax AND CO.Age >=A.AgeMin AND C.CompetitorID = CO.CompetitorID);

#Q12
ALTER TABLE COMPETITOR
ADD CONSTRAINT AGE_CONSTRAINT CHECK (Age<=18 AND Age >=5);
SELECT * FROM COMPETITOR;

#Q13
UPDATE STUDIO SET Name = 'Harmony Studio' WHERE Name='Harmony Inc.';
SELECT * FROM STUDIO;
SELECT * FROM TEACHER;

#the change updates both the STUDIO and TEACHER table. This is because both of the tables have
#StudioName, and StudioName from TEACHER table is a foreign key that references from STUDIO. The TEACHER table has a "ON UPDATE CASCADE" trigger to get updates from STUDIO.

#Q14
#The removal of composition by Beethoven will be unsuccessful because of the foreign key constraint.
#If the composition by Beethoven is removed from COMPOSITION table, then any table that references composition as a foreign key
# will be affected. Although PERFORMANCE references COMPOSITION MusicID as its foreign key, the PERFORMANCE table does not have a trigger 'ON UPDATE CASCADE'.
#Therefore, PERFORMANCE table will not be affected if COMPOSITION table is updated.

#Q15
#A "certification" trigger is created to check updates from TEACHER table, if any row is updated.
#The code will ask proof of certification before any modification to TEACHER table, so that each teacher needs to have a proof of certification
# before being added to the TEACHER table.




