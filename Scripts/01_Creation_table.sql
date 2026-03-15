-- creation de la table departement 
create table department (
id_departement int ,
nom_departement varchar(100),
manager varchar(100),
budget decimal(10,3),
constraint "id_pk" primary key ("id_departement")
)


-- Creation  de la table employes
create table employes(
id_employe int,
nom varchar(100),
prenom varchar(100),
poste  varchar(100),
id_departement int,
date_embauche date,
date_depart date,
salaire decimal(10,3),
constraint "id_employes_pk" primary key ("id_employe"),
constraint "id_fk" foreign key ("id_departement") references "department"("id_departement")
)


-- Creation de la table performance
create table performance(
id_performance int,
id_employe int,
date_evaluation date,
score int,
objectifs_atteints varchar(20),
constraint "id_perfo_pk" primary key ("id_performance"),
constraint "id_emplo_fk" foreign key ("id_employe") references "employes"("id_employe")
)


-- creation de la table turnover

create table turnover (
id_depart int primary key,
id_employe int,
date_depart date,
type_depart varchar(100),
anciennete varchar(20),
foreign key (id_employe) references employes(id_employe)
);



/* Cohorte d'embauche */

alter table employes 
add COLUMN cohorte varchar(10);

update employes
SET cohorte = to_char(date_embauche,'yyyy-mm');

select cohorte from employes;

