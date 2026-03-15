-- Colonnes dérivée

/* Ancienneté */

alter table employes 
add column anciennete int;

update employes
set anciennete = extract(year from age(COALESCE(date_depart,CURRENT_DATE),date_embauche));


/* Score Moyen par employés */

CREATE VIEW Score_moyen_par_employe as 
SELECT id_employe,
       ROUND(avg(score),2) score_moyen
from performance 
GROUP BY id_employe;

SELECT * from  Score_moyen_par_employe;

/* Categorie de Performance */

CREATE View Cat_Performance as
SELECT p.id_employe,
       p.score_moyen,
       CASE 
        WHEN p.score_moyen < 60  THEN  'Faible'
        WHEN p.score_moyen BETWEEN 60 and 80 then 'Moyenne'
        ELSE  'Elévé'
       END as Categorie_de_Performance
FROM Score_moyen_par_employe p;


SELECT * from cat_performance;


SELECT Categorie_de_Performance,
       COUNT(*) as Nombre_employe 
from Cat_Performance
GROUP BY Categorie_de_Performance;

-- cohorte d’embauche

create View cohorte_embauche AS
SELECT
        cohorte,
        COUNT(*) as "Nombres embauchés"
from employes
GROUP BY cohorte;

SELECT * from cohorte_embauche;
