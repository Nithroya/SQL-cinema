-- Creation de la base de donnée cinema

CREATE DATABASE IF NOT EXISTS complex cinemas CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Creation des tables

CREATE TABLE administrateurs
( id INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nom VARCHAR(30) NOT NULL,
  prenom VARCHAR(30) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE cinemas
( id INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nom VARCHAR(30) NOT NULL,
  adresse VARCHAR(90) NOT NULL,
	tel INT(10) NOT NULL,
	email VARCHAR(60) NOT NULL,
	id_administrateur INT(10),
	CONSTRAINT fk_cinemas_administrateurs_id FOREIGN KEY (id_administrateur) REFERENCES administrateurs(id)
) ENGINE=InnoDB;

CREATE TABLE salles
(	id INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  libelle VARCHAR(30) NOT NULL,
	capacite INT(10) NOT NULL,
	id_cinema INT(10),
	CONSTRAINT fk_salles_cinemas_id FOREIGN KEY (id_cinema) REFERENCES cinemas(id)
) ENGINE=InnoDB;

CREATE TABLE seances
(	id INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  horaires DATETIME NOT NULL,
	id_salle INT(10),
	CONSTRAINT fk_seances_salles_id FOREIGN KEY (id_salle) REFERENCES salles(id),
	id_film INT(10),
	CONSTRAINT fk_seances_films_id FOREIGN KEY (id_film) REFERENCES films(id)
) ENGINE=InnoDB;

CREATE TABLE films
(	id INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
	titre VARCHAR(60) NOT NULL,
	realisateur VARCHAR(30) NOT NULL,
	synopsis VARCHAR(300) NOT NULL,
	duree TIME NOT NULL,
	date_sortie DATE NOT NULL,
	id_genre INT(10),
	CONSTRAINT fk_films_genres_id FOREIGN KEY (id_genre) REFERENCES genres(id)
) ENGINE=InnoDB;

CREATE TABLE genres
(	id INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  libelle VARCHAR(30) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE tarifs
(	id INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL ,
  categorie_prix VARCHAR(30) NOT NULL,
  prix FLOAT(10.2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE tickets
(	id INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL ,
	date_achat DATE NOT NULL,
	quantite INT(10) NOT NULL,
	id_cinema INT(10),
	CONSTRAINT fk_tickets_cinemas_id FOREIGN KEY (id_cinema) REFERENCES cinemas(id),
	id_seance INT(10),
	CONSTRAINT fk_tickets_seances_id FOREIGN KEY (id_seance) REFERENCES seances(id),
	id_client INT(10),
	CONSTRAINT fk_tickets_clients_id FOREIGN KEY (id_client) REFERENCES clients(id),
	id_tarif INT(10),
	CONSTRAINT fk_tickets_tarifs_id FOREIGN KEY (id_tarif) REFERENCES tarifs(id)
) ENGINE=InnoDB;

CREATE TABLE clients
(	id INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nom VARCHAR(30) NOT NULL,
  prenom VARCHAR(30) NOT NULL,
	age INT(10) NOT NULL, 
	email VARCHAR(60) NOT NULL UNIQUE,
	categorie VARCHAR(30) NOT NULL,
	mot_de_passe VARCHAR(60)
) ENGINE=InnoDB;

-- Exemeple d'insertion

INSERT INTO administrateurs (nom, prenom) VALUES 
	('Manger', 'Antoine'), ('Alban', 'Romain');
INSERT INTO cinemas (nom , adresse, tel, email, id_administrateur) VALUES 
	('Les Balladins Plages' , '16 rue des plages 22700 Perros-guirec' , '0252451700', 'perros.balladin@balladin.com', '1'), 
	('Les Balladins' , '27 rue de la gare 2200', '0252451701', 'lannion.balladin@balladin.com', '2');
INSERT INTO salles (libelle , capacite, id_cinema) VALUES 
	('Kenavo', '60', '1') , ('Trestraou', '80', '1'), ('Cormoran', '60', '2'), ('Macareux', '90', '2'), ('Albatros', '60', '2');
INSERT INTO seances (horaires, id_salle, id_film) VALUES 
	('2021-07-27 10:30:00', '1', '1'), ('2021-07-27 14:30:00', '2', '2'), ('2021-07-27 20:45:00', '2', '2'), ('2021-07-27 10:30:00', '3', '3'), 
	('2021-07-27 18:00:00', '3', '1'), ('2021-07-27 14:30:00', '4', '2'), ('2021-07-27 20:45:00', '4', '2'), ('2021-07-27 20:45:00', '5', '3');
INSERT INTO films (titre, realisateur, synopsis, duree, date_sortie, id_genre) VALUES 
	('La vie cachée des castors' , 'Tabernacle Yvon' , 'La vie déroutante de la famille Castors qui découvre les joies des activités à la neige. A découvrir en famille', '01:30:00', '2021-07-27', '5'),
	('La petit maison dans la prairie - la revanche' , 'Inglass Charles', "La famille Inglass décide de devenir riche. Dans une course effrénée à découvrir du pétrol, Charles Inglass dévoile son véritable visage. Le bucheron va faire voller des têtes. ", '02:30:00', '2021-07-15', '4'),
	('Harry Potter - le retour de Voldemort' , 'Beyrie Fabien', "Saperlipopette, un moldu à découvert un objet maqique qui à fait revenir Tom Jedusor. Tentera t'il de planter sa baguette dans le dos de harry... ", '02:40:00', '2021-07-10', '1');
INSERT INTO genres (libelle) VALUES 
	('Action') ,('Animé') ,('Comédies') ,('Horreur') ,('Jeunesse');
INSERT INTO tarifs (categorie_prix, prix) VALUES 
	('Plein tarif', '9.20' ), ('Étudiant', '7.60' ), ('Moins de 14 ans', '5.90');


INSERT INTO clients (nom, prenom, age, email, mot_de_passe) VALUES 
	('Andria', 'Piggins', '21', 'apiggins0@arizona.edu', '$2a$12$LItOO4XR2Uzot/K5IM/LbuhvQNGRnyYVwSlNGq1k7c54frpLp5iuC'),
	('Hugh', 'Sanson', '32', 'hsanson1@fc2.com', '$2a$12$rUJx1Mez4j7ybqR4OyMY1OMmAVMzRLRdpXXro/BhY8jXYSaebdeJO'),
	('Merwyn', 'Woodrooffe', '30', 'mwoodrooffe2@foxnews.com', '$2a$12$lm7QMFwVthTsBQcVQB2mZuf4bvVWPaxgxMghwSTVQp0zCPnygUqtC'),
	('Barrett', 'Sunock', '45', 'bsunock3@ning.com', '$2a$12$ljJw4UnSKS0V.x7DigaDUOyRLYrpyF75LQsZbRRQRuMlbik59VGAi'),
	('Arielle', 'Slyman', '53', 'aslyman4@army.mil', '$2a$12$kdnXqDRTtS0yfLkQ0Cs/o.FTeR82ki0JlCZPb37Z3WXIdmC0eDNxq'),
	('Lenette', 'Harbour', '12', 'lharbour5@sohu.com', '$2a$12$QBysewVin2YvyTQtmZYFtuPVQgczTUdDZmUkmht9BdIeFfqZpFqGS'),
	('Pryce', 'Priestnall', '27', 'ppriestnall6@ihg.com', '$2a$12$gcbLLGHmHvVby5AFQoyc.u0KmtcfAMNtwQ3EIvOFrl0/KbPCoAS0K'),
	('Kettie', 'Dagworthy', '18', 'kdagworthy7@jalbum.net', '$2a$12$0wuFuQpBn1SPTN4PJK.tbuuj//k51wUBDYhvy8DtixNmAfK.mk/Bu');

INSERT INTO tickets (date_achat, quantite, id_cinema, id_tarif, id_seance, id_client) VALUES 
('2021-07-27', '2', '1', '1', '9', '3');


-- Utilisation d'un utilitaire de sauvegarde de la base de données :
-- mysqldump -u root -p root -h localhost:8889 > cinema.sql