-- Database: afroune project database 

-- DROP DATABASE IF EXISTS "afroune project database ";

CREATE DATABASE "afroune project database "
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'French_France.1252'
    LC_CTYPE = 'French_France.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


	----create clients table 
	create table clients (
id_client serial primary key,
nom VARCHAR (50) not  null , 
prenom varchar (50) not null,
adresse varchar (70) not null,
age  smallint CHECK (age >= 18),
email varchar(150) not null unique ,
phone_number varchar  (15) not null unique ,
profession VARCHAR (100) ,
budget numeric(5, 2)  not null,  
superficie_maison numeric(4, 2) ,
animalVoulu VARCHAR(50) ,
nombre_achat smallint
	);

	select * from clients 


	---create animalerie table 
CREATE TABLE animalerie (        
    id_animalerie serial PRIMARY KEY,
    adresse VARCHAR(50) NOT NULL,
    code_postal SMALLINT NOT NULL,
    numero_identification_fiscale VARCHAR(20) NOT NULL UNIQUE,
    nom VARCHAR(50) NOT NULL,
    site_web VARCHAR(80) UNIQUE,
    services TEXT,
    type_animal VARCHAR(30),
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
);

select * from animalerie 


----create association table between animalerie et clients 
CREATE TABLE association_animalerie_clients (
    id_association serial PRIMARY KEY, 
    identifiant_animalerie serial REFERENCES animalerie(id_animalerie),
    identifiant_client serial  REFERENCES clients(id_client)
);


----modification de association_animalerie_clients  (renommer )
	ALTER TABLE association_animalerie_clients RENAME TO client_animalerie ;
	select * from client_animalerie ----> correcte


---create animaux table 
create table animaux (
id_animal serial  primary key not null unique ,  
nom VARCHAR  (30) not null, 
espece VARCHAR (30),
sexe char (2),
race VARCHAR (30),
couleur varchar (20),
taille varchar (20),
prix numeric (4, 2),
disponibilite BOOLEAN,
dossierMédical TEXT,
matricule   VARCHAR  (30) unique ,
identifiant_animalerie serial references  animalerie(id_animalerie)
);

	select * from  animaux

	----(changement de nom de la colonne doosierMédical) 
	ALTER TABLE animaux RENAME COLUMN dossierMédical TO dossier_medical;
	select * from  animaux


	---create association table betwenn clients and animaux 
	create table assoc_cliens_animaux (
		id_assoc serial primary key not null unique,
client serial  REFERENCES clients(id_client),
animal serial REFERENCES animaux(id_animal) 
	);

----->	debut modification
	ALTER TABLE assoc_cliens_animaux RENAME TO clients_animaux;
	select * from assoc_cliens_animaux; -----> fausse 
select * from clients_animaux;----->correcte
	----- fin modification 



------> salutaions ceci est un essai pour voir si la synchronisation marche 


