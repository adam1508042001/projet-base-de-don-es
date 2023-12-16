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


INSERT INTO animaux (nom, espece, sexe, race, couleur, taille, prix, disponibilite, dossier_medical , matricule, identifiant_animalerie)
VALUES
    ('Whiskers', 'Chat de compagnie', 'M', 'Siamois', 'Blanc', '30 cm', 700, TRUE, 'À jour', 'w123xxyyz', 1),
    ('Mittens', 'Chat de compagnie', 'F', 'Persan', 'Gris', '25 cm', 650, TRUE, 'Pas à jour', 'm45556abc', 1),
    ('Oliver', 'Chat de garde', 'M', 'Maine Coon', 'Marron', '35 cm', 800, TRUE, 'À jour', 'o74589def', 1),
    ('Chloe', 'Chat de compagnie', 'F', 'Bengal', 'Tacheté', '28 cm', 750, TRUE, 'Pas à jour', 'c123ghi', 1),
    ('Luna', 'Chat de garde', 'F', 'Norvégien', 'Blanc et noir', '32 cm', 780, TRUE, 'À jour', 'l456jkl', 1),
    ('Leo', 'Chat de compagnie', 'M', 'Ragdoll', 'Bleu', '27 cm', 700, TRUE, 'Pas à jour', 'r789mno', 1),
    ('Misty', 'Chat de garde', 'F', 'Sibérien', 'Crème', '30 cm', 820, TRUE, 'À jour', 'm123pqr', 1),
    ('Max', 'Chat de compagnie', 'M', 'Chartreux', 'Gris', '26 cm', 720, TRUE, 'Pas à jour', 'm45sdfstu', 1),
    ('Lucy', 'Chat de garde', 'F', 'Abyssin', 'Roux', '31 cm', 800, TRUE, 'À jour', 'l789vwx', 1),
    ('Oscar', 'Chat de compagnie', 'M', 'Birman', 'Blanc', '29 cm', 700, TRUE, 'Pas à jour', 'o123yz', 1),
    ('Sophie', 'Chat de garde', 'F', 'Bombay', 'Noir', '33 cm', 850, TRUE, 'À jour', 's456abc', 1),
    ('Charlie', 'Chat de compagnie', 'M', 'Sphynx', 'Rose', '24 cm', 730, TRUE, 'Pas à jour', 'c789def', 1),
    ('Nala', 'Chat de garde', 'F', 'Oriental', 'Bleu', '28 cm', 780, FALSE, 'À jour', 'n123ghi', 1),
    ('Simba', 'Chat de compagnie', 'M', 'Scottish Fold', 'Blanc et gris', '25 cm', 700, TRUE, 'Pas à jour', 's456jkl', 1),
    ('Zoe', 'Chat de garde', 'F', 'Burmese', 'Marron', '30 cm', 820, FALSE, 'À jour', 'z789mno', 1),
    ('Gizmo', 'Chat de compagnie', 'M', 'Himalayen', 'Crème', '26 cm', 720, TRUE, 'Pas à jour', 'g123pqr', 1),
    ('Mia', 'Chat de garde', 'F', 'Manx', 'Noir', '31 cm', 800, TRUE, 'À jour', 'm456stu', 1),
    ('Rocky', 'Chat de compagnie', 'M', 'Siamese', 'Brun', '27 cm', 700, TRUE, 'Pas à jour', 'r789vwx', 1),
    ('Lily', 'Chat de garde', 'F', 'Russian Blue', 'Gris', '32 cm', 850, TRUE, 'À jour', 'l123xyz', 1),
    ('Tiger', 'Chat de compagnie', 'M', 'Devon Rex', 'Tigré', '28 cm', 730, TRUE, 'Pas à jour', 't456abc', 1),
    ('Sali', 'Perroquet', 'M', 'Ara', 'Multicolore', '40 cm', 800, TRUE, 'À jour', 't123xyz1', 1),
    ('Caan', 'Perroquet', 'F', 'Ara', 'Multicolore', '40 cm', 800, TRUE, 'À jour', 't123xyz2', 1),
    ('Sunny', 'Perroquet', 'M', 'Ara', 'Multicolore', '40 cm', 800, TRUE, 'À jour', 't123xyz3', 1),
    ('Spike', 'Perroquet', 'F', 'Ara', 'Multicolore', '40 cm', 800, TRUE, 'À jour', 't123xyz4', 1),
    ('Rainbow', 'Perroquet', 'M', 'Ara', 'Multicolore', '40 cm', 800, TRUE, 'À jour', 't123xyz5', 1),
    ('Twinkle', 'Perroquet', 'F', 'Ara', 'Multicolore', '40 cm', 800, TRUE, 'À jour', 't123xyz6', 1),
    ('Flash', 'Canari', 'M', 'Canari', 'Jaune', '15 cm', 100, TRUE, 'Pas à jour', 'p456abc1', 1),
    ('Buddy', 'Canari', 'F', 'Canari', 'Jaune', '15 cm', 100, TRUE, 'Pas à jour', 'p456abc2', 1),
    ('Sky', 'Canari', 'M', 'Canari', 'Jaune', '15 cm', 100, TRUE, 'Pas à jour', 'p456abc3', 1),
    ('Sunshine', 'Canari', 'F', 'Canari', 'Jaune', '15 cm', 100, TRUE, 'Pas à jour', 'p456abc4', 1),
    ('Pebbles', 'Canari', 'M', 'Canari', 'Jaune', '15 cm', 100, TRUE, 'Pas à jour', 'p456abc5', 1),
    ('Daisy', 'Canari', 'F', 'Canari', 'Jaune', '15 cm', 100, TRUE, 'Pas à jour', 'p456abc6', 1),
    ('Sparky', 'Canari', 'M', 'Canari', 'Jaune', '15 cm', 100, TRUE, 'Pas à jour', 'p456abc7', 1),
    ('Sugar', 'Canari', 'F', 'Canari', 'Jaune', '15 cm', 100, TRUE, 'Pas à jour', 'p456abc8', 1),
    ('Melody', 'Canari', 'M', 'Canari', 'Jaune', '15 cm', 100, TRUE, 'Pas à jour', 'p456abc9', 1),
    ('Luna', 'Canari', 'F', 'Canari', 'Jaune', '15 cm', 100, TRUE, 'Pas à jour', 'p456abc10', 1),
    ('Charlie', 'Perruche', 'M', 'Perruche ondulée', 'Gris et Jaune', '20 cm', 200, TRUE, 'Pas à jour', 's123ghi12', 1),
    ('Olivia', 'Perruche', 'F', 'Perruche ondulée', 'Rose', '20 cm', 200, TRUE, 'Pas à jour', 's123ghi13', 1),
    ('Max', 'Perruche', 'M', 'Perruche ondulée', 'Bleu', '20 cm', 200, TRUE, 'Pas à jour', 's123ghi14', 1),
    ('Lucy', 'Perruche', 'F', 'Perruche ondulée', 'Jaune', '20 cm', 200, TRUE, 'Pas à jour', 's123ghi15', 1),
    ('Zara', 'Tortue', 'F', 'Tortue des steppes', 'Vert', 'Petite', 30, TRUE, 'À jour', 'ZAR456', 1),
    ('Rex', 'Lézard', 'M', 'Iguane vert', 'Vert', 'Grande', 80, FALSE, 'Pas à jour', 'REX789', 1),
    ('Luna', 'Serpent', 'F', 'Boa constrictor', 'Jaune', 'Moyenne', 60, TRUE, 'À jour', 'LUN234', 1),
    ('Draco', 'Lézard', 'M', 'Dragon barbu', 'Orange', 'Petite', 40, TRUE, 'À jour', 'DRC567', 1),
    ('Terra', 'Tortue', 'F', 'Tortue de terre', 'Brun', 'Grande', 70, FALSE, 'Pas à jour', 'TER890', 1),
    ('Spike Jr.', 'Serpent', 'M', 'Python royal', 'Noir', 'Petite', 35, TRUE, 'À jour', 'SPK567', 1),
    ('Flash', 'Lézard', 'M', 'Caméléon', 'Multicolore', 'Petite', 45, TRUE, 'À jour', 'FLS123', 1), 
       ('Felix', 'Chien de garde', 'M', 'Berger Allemand', 'Noir', '80 cm', 1200, TRUE, 'À jour', 'x95462zed', 1),
    ('Luna', 'Chien de compagnie', 'F', 'Golden Retriever', 'Doré', '60 cm', 1000, TRUE, 'Vaccins à jour', 'y987abc', 1),
    ('Rocky', 'Chien de garde', 'M', 'Rottweiler', 'Noir et feu', '75 cm', 1100, TRUE, 'Carnet de santé complet', 'z789def', 1),
    ('Bella', 'Chien de compagnie', 'F', 'Labrador', 'Chocolat', '65 cm', 900, TRUE, 'Vaccins à jour', 'a123ghi', 1),
    ('Max', 'Chien de garde', 'M', 'Doberman', 'Noir et feu', '70 cm', 1300, TRUE, 'Carnet de santé à jour', 'b456jkl', 1),
    ('Daisy', 'Chien de compagnie', 'F', 'Beagle', 'noir', '35 cm', 800, TRUE, 'Vaccins à jour', 'c789mno', 1),
    ('Simba', 'Chien de compagnie', 'M', 'Shiba Inu', 'Roux', '40 cm', 950, TRUE, 'Vaccins en ordre', 'd123pqr', 1),
    ('Molly', 'Chien de garde', 'F', 'Dogue allemand', 'Arlequin', '85 cm', 1500, TRUE, 'Suivi médical complet', 'e456stu', 1),
    ('Charlie', 'Chien de compagnie', 'M', 'Cavalier King Charles', 'Blenheim', '30 cm', 700, TRUE, 'Vaccins à jour', 'f789vwx', 1),
    ('Roxy', 'Chien de garde', 'F', 'Bouledogue français', 'Fauve', '35 cm', 1000, TRUE, 'Carnet de santé à jour', 'g123yz', 1),
    ('Rocky', 'Chien de compagnie', 'M', 'Teckel', 'Noir', '25 cm', 600, TRUE, 'Vaccins à jour', 'k789abc', 1),
    ('Zoe', 'Chien de garde', 'F', 'Husky', 'Gris', '60 cm', 1200, TRUE, 'Carnet de santé complet', 'l123def', 1),
    ('Teddy', 'Chien de compagnie', 'M', 'Cocker Spaniel', 'Noir', '40 cm', 850, TRUE, 'Vaccins à jour', 'm456ghi', 1),
    ('Loki', 'Chien de garde', 'M', 'Akita', 'roux', '70 cm', 1300, TRUE, 'Suivi médical complet', 'n789jkl', 1),
    ('Coco', 'Chien de compagnie', 'F', 'Shih Tzu', 'Blanc', '25 cm', 700, TRUE, 'Vaccins à jour', 'o123mno', 1),
    ('Maximus', 'Chien de garde', 'M', 'Bullmastiff', 'Bringé', '80 cm', 1400, TRUE, 'Carnet de santé à jour', 'p456pqr', 1),
    ('Mia', 'Chien de compagnie', 'F', 'Chihuahua', 'Fauve', '20 cm', 500, TRUE, 'Vaccins à jour', 'q789stu', 1),
    ('Oscar', 'Chien de garde', 'M', 'Schnauzer', 'Noir et argent', '45 cm', 950, TRUE, 'Suivi médical complet', 'r123vwx', 1),
    ('Lucy', 'Chien de compagnie', 'F', 'Pomeranian', 'Crème', '30 cm', 800, TRUE, 'Vaccins à jour', 's456yz', 1),
    ('Thor', 'Chien de garde', 'M', 'Dalmatien', 'Noir et blanc', '60 cm', 1100, TRUE, 'Carnet de santé à jour', 't789abc', 1);

   
   select * from animaux 
   

SELECT * 
FROM animaux 
JOIN animalerie ON animaux.identifiant_animalerie = animalerie.id_animalerie
WHERE animalerie.type_animal = 'domestique';


DELETE FROM animaux;
select * from animaux 


-------> pour remmettre le id animal commençant par 1 :
-- Réinitialiser la séquence pour la colonne id_animal à 1
SELECT setval('animaux_id_animal_seq', 1, false);
-----> supprimer toutes les valeurs de la table animaux 
DELETE FROM animaux;
--->reremplir la table par les anciennes valeurs.



select * from clients_animaux;
