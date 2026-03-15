/* 1.	Combien d’employés sont actuellement actifs ? */

select count(*) from employes
where date_depart is null;

/* 2.	Combien de départs avons-nous eu sur les 12 derniers mois ? */

select count(*) from employes
where date_depart is not null and date_depart >=(CURRENT_DATE - INTERVAL '12 months');

/* 3.	Quels départements ont le turnover le plus élevé ? */

select d.nom_departement, ROUND((count(e.date_depart) * 100.0 / count(e.id_employe)),2) as "Taux de turnover en %"
from employes e
join department d on e.id_departement = d.id_departement
group by d.nom_departement
order by  (count(e.date_depart) * 100.0 / count(e.id_employe)) DESC ;

/* 4.	Quel est le salaire moyen par département ? */

SELECT d.nom_departement,
ROUND(avg(e.salaire),2) as Salaire_Moyen 
from department d
join employes e on d.id_departement = e.id_departement
GROUP BY d.nom_departement
ORDER BY salaire_moyen DESC;

/* 5.	Quels employés ont plus de 5 ans d’ancienneté ? */

SELECT * from employes
where anciennete > 5;

/* 6.	Classez les départements par performance moyenne trimestrielle. */

select d.nom_departement,
       ROUND(avg(p.score),2) as Performance_moyen
from department d
join employes e ON e.id_departement = d.id_departement
join performance p on e.id_employe = p.id_employe
GROUP BY d.nom_departement
ORDER BY Performance_Moyen DESC;

/* 7.	Identifier les 10 meilleurs employés sur 3 derniers trimestres. */

SELECT 
    e.nom,
    e.prenom,
    ROUND(AVG(p.score), 2) as Score_moyen
FROM performance p
left JOIN employes e ON e.id_employe = p.id_employe
GROUP BY e.nom, e.prenom
HAVING COUNT(*) >= 3
ORDER BY score_Moyen DESC
LIMIT 10 ;

/* 8.	Identifier les employés les moins performants et leur département. */

select e.nom,
       e.prenom,
       d.nom_departement,
       ROUND(AVG(p.score),2) as Moyenne_des_Performance
from employes e
LEFT JOIN department d ON e.id_departement = d.id_departement
left join performance p ON e.id_employe = p.id_employe
GROUP BY e.nom,e.prenom,d.nom_departement
HAVING  avg(p.score) < 60;

/* 9.	Calculer la rétention moyenne par cohorte d’embauche. */
with cohortes as (
SELECT to_char(date_embauche, 'yyyy-mm') as mois_embauche,
       count(*) as Nombre_embauches,
       --  retention de 3 mois
       SUM(CASE 
        WHEN date_depart is null or date_depart >= date_embauche + INTERVAL ' 3 months'  THEN  1 
        ELSE 0
       END) as restant_3_mois,
       SUM(CASE 
        WHEN date_depart is NULL or date_depart >= date_embauche + INTERVAL '6 months' THEN  1
        ELSE 0  
       END) as restant_6_mois,
       SUM(CASE 
        WHEN date_depart is null or date_depart >= date_embauche + INTERVAL '12 months' THEN  1
        else 0
       END) as restant_12_mois
from employes
GROUP BY mois_embauche
)
SELECT
    mois_embauche as cohorte,
    nombre_embauches,
    round(restant_3_mois*100.0/nombre_embauches,2) as retention_3_mois,
    round(restant_6_mois*100.0/nombre_embauches,2) as retention_6_mois,
    round(restant_12_mois*100.0/nombre_embauches,2) as retention_12_mois
from cohortes
ORDER BY cohorte,nombre_embauches,retention_3_mois,retention_6_mois,retention_12_mois;

    --- Autre façon moins personnalisée

SELECT cohorte,
       ROUND(AVG(anciennete),2) as Anciennete_Moyenne
from employes
GROUP BY cohorte
ORDER BY Anciennete_Moyenne;

/* 10.	Quels départements recrutent le plus souvent ? */

SELECT d.nom_departement,
       COUNT(e.id_employe) as recrutement
from department d
LEFT JOIN employes e ON d.id_departement = e.id_departement
GROUP BY d.nom_departement
ORDER BY recrutement DESC;

/* 11.	Quelle proportion des départs est volontaire vs involontaire ? */

select 
 type_depart,
 count(*) as Nombre_depart,
 round(COUNT(*)*100.0 / SUM(COUNT(*)) OVER(),2) as proportion
from turnover
GROUP BY type_depart;


/* 12.	Quelle est la distribution des postes par ancienneté ? */

select poste,
       CASE 
        WHEN anciennete < 2 THEN  '0 - 2 ans'
        when anciennete BETWEEN 2 and 5 THEN '2 - 5 ans'
        ELSE '5 ans plus'
       END as Tranche_Anciennete,
       COUNT(*) as Nombre_employe
from employes
GROUP BY poste,Tranche_Anciennete;

/* 13.	Quels employés n’ont pas encore reçu de feedback cette année ? */
select e.id_employe,
       e.nom,
       e.prenom
from employes e
LEFT join performance p ON e.id_employe = p.id_employe
and EXTRACT(year from p.date_evaluation) = EXTRACT(year from CURRENT_DATE)
where e.date_depart is NULL and p.id_employe is NULL;

/* 14.	Segmentez les employés par niveau de performance : faible / moyen / élevé. */

SELECT 
         Categorie_de_Performance as "Niveau de Performance",
         count(*) as "Nombre_employés"
from Cat_Performance 
GROUP BY Categorie_de_Performance;

/* 15.	Générer un tableau résumé avec KPIs par département et par cohorte. */

select d.nom_departement,
       e.cohorte as Cohorte_Embauche,
       count(*) as Effectif,
       round(AVG(e.salaire),2) as Salaire_Moyen,
       round(AVG(p.score),2) as Score_Moyen,
       round(AVG(e.anciennete),2) as Anciennete_Moyene
from employes e
LEFT join department d ON e.id_departement = d.id_departement
LEFT join performance p ON e.id_employe = p.id_employe
GROUP BY d.nom_departement,e.cohorte
ORDER BY d.nom_departement,e.cohorte;

    








        
