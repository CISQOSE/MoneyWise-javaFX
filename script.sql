-- ============================================================
--  MONEYWISE — Script de création de la base de données
--  Version 1.0 — Mars 2026
--  Compatible : MySQL 8.0+
-- ============================================================

-- Création et sélection de la base
CREATE DATABASE IF NOT EXISTS moneywise_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE moneywise_db;

-- ============================================================
--  CRÉATION DES TABLES
-- ============================================================

-- ============================================================
--  TABLE : utilisateur
--  (Dépendance : aucune - table de base)
-- ============================================================
CREATE TABLE IF NOT EXISTS utilisateur (
  id               INT          NOT NULL AUTO_INCREMENT,
  nom              VARCHAR(100) NOT NULL,
  email            VARCHAR(150) NOT NULL,
  mot_de_passe     VARCHAR(255) NOT NULL,
  date_inscription DATE         NOT NULL DEFAULT (CURRENT_DATE),
  est_actif        BOOLEAN      NOT NULL DEFAULT TRUE,
  est_admin        BOOLEAN      NOT NULL DEFAULT FALSE,
  niveau_acces     INT(2)       NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
--  TABLE : categorie
--  (Dépendance : utilisateur)
-- ============================================================
CREATE TABLE IF NOT EXISTS categorie (
  id             INT         NOT NULL AUTO_INCREMENT,
  nom            VARCHAR(80) NOT NULL,
  icone          VARCHAR(50) NULL,
  est_systeme    BOOLEAN     NOT NULL DEFAULT FALSE,
  utilisateur_id INT         NULL,

  PRIMARY KEY (id),
  CONSTRAINT fk_categorie_utilisateur
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
--  TABLE : transaction
--  (Dépendance : utilisateur, categorie)
-- ============================================================
CREATE TABLE IF NOT EXISTS transaction (
  id               INT          NOT NULL AUTO_INCREMENT,
  montant          DOUBLE       NOT NULL CHECK (montant > 0),
  type             ENUM('ENTREE','SORTIE') NOT NULL,
  date_transaction DATE         NOT NULL,
  description      VARCHAR(255) NULL,
  utilisateur_id   INT          NOT NULL,
  categorie_id     INT          NOT NULL,
  date_saisie      DATETIME     NOT NULL DEFAULT NOW(),

  PRIMARY KEY (id),
  CONSTRAINT fk_transaction_utilisateur
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id)
    ON DELETE CASCADE,
  CONSTRAINT fk_transaction_categorie
    FOREIGN KEY (categorie_id) REFERENCES categorie(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
--  TABLE : budget
--  (Dépendance : utilisateur, categorie)
-- ============================================================
CREATE TABLE IF NOT EXISTS budget (
  id             INT    NOT NULL AUTO_INCREMENT,
  montant_max    DOUBLE NOT NULL CHECK (montant_max > 0),
  mois           INT(2) NOT NULL CHECK (mois BETWEEN 1 AND 12),
  annee          INT(4) NOT NULL,
  est_actif      BOOLEAN NOT NULL DEFAULT TRUE,
  utilisateur_id INT    NOT NULL,
  categorie_id   INT    NOT NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_budget_periode (utilisateur_id, categorie_id, mois, annee),
  CONSTRAINT fk_budget_utilisateur
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id)
    ON DELETE CASCADE,
  CONSTRAINT fk_budget_categorie
    FOREIGN KEY (categorie_id) REFERENCES categorie(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
--  TABLE : alerte
--  (Dépendance : budget)
-- ============================================================
CREATE TABLE IF NOT EXISTS alerte (
  id          INT          NOT NULL AUTO_INCREMENT,
  message     VARCHAR(255) NOT NULL,
  date_alerte DATETIME     NOT NULL DEFAULT NOW(),
  type_alerte ENUM('SEUIL_80','SEUIL_100') NOT NULL,
  est_lue     BOOLEAN      NOT NULL DEFAULT FALSE,
  budget_id   INT          NOT NULL,

  PRIMARY KEY (id),
  CONSTRAINT fk_alerte_budget
    FOREIGN KEY (budget_id) REFERENCES budget(id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
--  TABLE : export
--  (Dépendance : utilisateur)
-- ============================================================
CREATE TABLE IF NOT EXISTS export (
  id             INT          NOT NULL AUTO_INCREMENT,
  format         ENUM('PDF','EXCEL') NOT NULL,
  date_export    DATETIME     NOT NULL DEFAULT NOW(),
  chemin_fichier VARCHAR(500) NOT NULL,
  periode_debut  DATE         NOT NULL,
  periode_fin    DATE         NOT NULL CHECK (periode_fin >= periode_debut),
  utilisateur_id INT          NOT NULL,

  PRIMARY KEY (id),
  CONSTRAINT fk_export_utilisateur
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
--  TABLE : journal_activite
--  (Dépendance : utilisateur)
-- ============================================================
CREATE TABLE IF NOT EXISTS journal_activite (
  id             INT          NOT NULL AUTO_INCREMENT,
  utilisateur_id INT          NOT NULL,
  action         VARCHAR(60)  NOT NULL,
  details        VARCHAR(500) NULL,
  date_action    DATETIME     NOT NULL DEFAULT NOW(),
  adresse_ip     VARCHAR(45)  NULL,

  PRIMARY KEY (id),
  CONSTRAINT fk_journal_utilisateur
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
--  INSERTION DES DONNÉES INITIALES
-- ============================================================

-- ============================================================
--  Catégories système
-- ============================================================
INSERT INTO categorie (nom, icone, est_systeme, utilisateur_id) VALUES
('Alimentation',  'shopping-cart', TRUE, NULL),
('Transport',     'car',           TRUE, NULL),
('Logement',      'home',          TRUE, NULL),
('Santé',         'heartbeat',     TRUE, NULL),
('Loisirs',       'gamepad',       TRUE, NULL),
('Education',     'graduation-cap',TRUE, NULL),
('Autres',        'ellipsis-h',    TRUE, NULL);

-- ============================================================
--  Compte administrateur par défaut
--  Mot de passe : Admin1234 (hash bcrypt généré par l'app)
--  IMPORTANT : Changer le mot de passe à la première connexion !
-- ============================================================
INSERT INTO utilisateur (nom, email, mot_de_passe, date_inscription, est_actif, est_admin, niveau_acces)
VALUES (
  'Administrateur',
  'admin@moneywise.sn',
  '$2a$12$placeholder_change_this_password_hash',
  CURRENT_DATE,
  TRUE,
  TRUE,
  1
);

-- ============================================================
--  FIN DU SCRIPT
-- ============================================================