/* ********************************************* */
/* BD sur l'immobilier				 */
/* AUTEUR : M. Lamolle 		DATE : 2013	 */
/* VERSION : 1.0				 */
/* ********************************************* */

-- création du schéma
drop schema immo cascade;
create schema immo;

-- création des tables
create table immo.Agence (noAgence varchar(4), rue varchar(32), ville varchar(32), codePostal varchar(5),
constraint pk_noAgence primary key (noAgence) );

create table immo.Personnel (noPers int, nom varchar(32), prenom varchar(32), fonction varchar(32), genre varchar(1), 
dateNais date, salaire float, noAgence varchar(4),
constraint pk_noPersimmo primary key (noPers), constraint ck_genre check (genre in ('M', 'm', 'F', 'f') or genre is null) ,
constraint fk_Pers_Agenc foreign key (noAgence) references immo.agence (noAgence) );

create table immo.Proprietaire (noProprio int, nom varchar(32), prenom varchar(32), adresse varchar(64), 
noTel varchar(10),constraint pk_noProprio primary key (noProprio) );

create table immo.ALouer (noPropriete int, rue varchar(32), ville varchar(32), codePostal varchar(5), type varchar(1), 
piece int, location int, noProprio int, noPers int, noAgence varchar(4),
constraint pk_noPropriete primary key (noPropriete), constraint ck_type check (type in ('M', 'A') or type is null),
constraint fk_Alouer_Proprio foreign key (noProprio) references immo.proprietaire (noProprio),
constraint fk_Alouer_Personnel foreign key (noPers) references immo.personnel (noPers),
constraint fk_Alouer_Agenc foreign key (noAgence) references immo.agence (noAgence) );

create table immo.Client (noClt int, nom varchar(32), prenom varchar(32), adresse varchar(64), noTel varchar(14), 
typePref varchar(1), locMax int, constraint pk_noClt primary key (noClt), 
constraint ck_typePref check (typePref in ('M', 'A') or typePref is null) );

create table immo.Visite (noClt int, noPropriete int, datVisit date, commentaire text,
constraint pk_noCltnoPropriete primary key (noClt, noPropriete),
constraint fk_Visit_Clt foreign key (noClt) references immo.client (noClt),
constraint fk_Visit_Alouer foreign key (noPropriete) references immo.aLouer (noPropriete) );

create table immo.Inscription (noClt int, noAgence varchar(4), noPers int, datInscrit date,
constraint pk_noCltnoAgencenoPers primary key (noClt, noAgence, noPers),
constraint fk_Inscription_Clt foreign key (noClt) references immo.client (noClt),
constraint fk_Inscription_Agenc foreign key (noAgence) references immo.agence (noAgence),
constraint fk_Inscription_Personnel foreign key (noPers) references immo.personnel (noPers) );

-- ---------------------------------------------------------------------------
-- INSERTION
-- ---------------------------------------------------------------------------
-- Agence
insert into immo.Agence values ('A005', '67 rue St Michel', 'Toulouse', '31000');
insert into immo.Agence values ('A007','Place du bourg','Bordeaux', '33000');
insert into immo.Agence values ('A003','24 Rue des roses','Paris', '75000');
insert into immo.Agence values ('A004','60 Bld Foch', 'Lyon','69000');
insert into immo.Agence values ('A002','5 Ave Prévert','Paris', '75020');

-- Personnel
insert into immo.Personnel values (21, 'Blanc', 'Jean', 'Gérant', 'M', '1-10-60', 6000,'A005');
insert into immo.Personnel values (37, 'Beige', 'Anne', 'Assistant', 'F', '10-11-70', 2400,'A003');
insert into immo.Personnel values (14, 'Roux', 'Daniel', 'Vendeur', 'M', '24-03-78', 3600,'A003');
insert into immo.Personnel values (9, 'Titan', 'Marie', 'Assistant', 'F', '19-02-70', 1800,'A007');
insert into immo.Personnel values (5, 'Brun', 'Sylvie', 'Gérant', 'F', '3-06-80', 4800,'A003');
insert into immo.Personnel values (41, 'H', 'Julie', 'Assistant', 'F', '13-06-65', 1800,'A005');

-- Proprietaire = noProprio	Nom	Prenom	adresse	noTel
insert into immo.Proprietaire values (46, 'Long', 'Bruno', '15, quai des berges 33000 Bordeaux', '0390063002');
insert into immo.Proprietaire values (87, 'Court', 'Claude', '21 rue des pavés 75000 Paris', '0665677891');
insert into immo.Proprietaire values (40, 'Grand', 'Brigitte', '36 quai des orfèvres 75000 Paris', '0887196350');
insert into immo.Proprietaire values (93, 'Lutin', 'Guy', '1 ave de l''Elysée 75000 Paris', '0181524107');

-- Alouer
insert into immo.Alouer values (14, '15 place du lac', 'Bordeaux', '33000', 'M', 6, 1300, 46, 9, 'A007');
insert into immo.Alouer values (94, '6 Champs Elysées', 'Toulouse', '31000', 'A', 4, 800, 87, 41, 'A005');
insert into immo.Alouer values (4, '43 des peupliers', 'Paris', '75004', 'A', 3, 700, 40, null, 'A003');
insert into immo.Alouer values (36, '17 bld central', 'Paris', '75001', 'A', 3, 750,	93, 37, 'A003');
insert into immo.Alouer values (21, '45 chemin du lac', 'Paris', '75020', 'M', 5, 1200, 87,	37, 'A003');
insert into immo.Alouer values (16, '9 ave de l''aéroport', 'Paris', '75020', 'A', 4,900, 93, 14, 'A003');

-- Client = noClt	Nom	Prenom	adresse	noTel	typePref	locMax
insert into immo.Client values (76, 'Martin', 'Jean', '31, rue du capial 31000 Toulouse', '06 67 75 92 12', 'A', 850);
insert into immo.Client values (56, 'Michel', 'Simon', '33 quai des brumes 33000 Bordeaux', '03 27 32 61 73', 'A', 700);
insert into immo.Client values (74, 'René', 'Pierre', '30, rue de Dax 33000 Bordeaux', '03 34 93 47 90', 'M', 1500);
insert into immo.Client values (62, 'Lulu', 'Marie', '75, bld St Germain 75000 Paris', '01 48 70 61 73', 'A', 1200);

-- inscription = noClt	NoAgence	noPers	datInscrit
insert into immo.inscription values (76, 'A005', 41,	'2-01-06');
insert into immo.inscription values (56, 'A003', 37,	'11-04-05');
insert into immo.inscription values (74, 'A003', 37,	'16-11-04');
insert into immo.inscription values (62, 'A007', 9, '7-03-05');

-- Visite = noClt	NoPropriete	datVisit	commentaire
insert into immo.Visite values (56,	14, '4-09-06', 'Trop petit');
insert into immo.Visite values (76,	4, '20-08-06', 'Trop éloigné');
insert into immo.Visite values (56,	4, '26-06-06');
insert into immo.Visite values (62,	14, '14-06-06',	'Pas de salle à manger');
insert into immo.Visite values (56,	36, '28-04-06');	
