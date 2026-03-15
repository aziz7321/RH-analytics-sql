/* Importation des données de la table departement */

copy department
from 'C:\DataLendo\departements.csv'
delimiter ';'
header csv;

alter table department
alter column budget type numeric;

select * from department;

/* Importation des données de la table employe */

copy employes
from 'C:\DataLendo\employes.csv'
delimiter ';'
header csv;

select * from employes;

/* Importation des données de la table performance */

copy performance
from 'C:\DataLendo\performances.csv'
delimiter ';'
header csv;

select * from performance;

/* Importation des données de la table turnover */

copy turnover
from 'C:\DataLendo\turnover.csv'
delimiter ';'
header csv;

select * from turnover;