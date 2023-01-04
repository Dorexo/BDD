/*a*/
SELECT nom, salaire FROM employe
WHERE 1000<salaire AND salaire<1500
ORDER BY salaire, nom;
/*b*/
SELECT nom, salaire, com FROM employe
WHERE comm IS NOT NULL;
/*c*/
SELECT nom, date_embauche, FROM employe
WHERE date_embauche>'2001-01-01' AND date_embauche<'2001-12-31'
ORDER BY date_embauche;
/*d*/
SELECT * FROM employe
WHERE fonction!='secretaire';
/*e*/
SELECT nom FROM employe
WHERE fonction='directeur' AND num_service IN (20,30);
/*f*/
SELECT * FROM employe
WHERE LOWER(nom) LIKE 'le%'
ORDER BY LENGTH(nom),nom;
/*g*/
SELECT 
	nom,
	(current_date-date_embauche) AS "Durée d’embauche" 
FROM employe 
ORDER BY (current_date-date_embauche);
/*h*/
SELECT nom,
	fonction,(salaire+coalesce(comm,0)) as "Revenu mensuel" 
FROM employe 
ORDER BY "Revenu mensuel";
/*i*/
SELECT COUNT(*) FROM employe 
WHERE comm>(0.25*salaire);
/*j*/
SELECT 
	MIN(salaire) AS "salaire min", 
	ROUND(AVG(salaire),2) AS "salaire moy", 
	MAX(salaire) AS "salaire max", 
	ROUND(MAX(salaire)/MIN(salaire)) AS "rapport max/min" 
FROM employe;