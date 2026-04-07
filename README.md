<div align="center">

# 💰 MoneyWise

### Votre finances. Votre contrôle.

![Java](https://img.shields.io/badge/Java-21_LTS-orange?style=for-the-badge&logo=java)
![JavaFX](https://img.shields.io/badge/JavaFX-21-blue?style=for-the-badge&logo=javafx)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Maven](https://img.shields.io/badge/Maven-3.9-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white)
![License](https://img.shields.io/badge/Licence-Académique-purple?style=for-the-badge)

> Application desktop de gestion de portefeuille personnel — 100% hors ligne, sécurisée et intuitive.

</div>

---

## 📋 Table des matières

- [Présentation](#-présentation)
- [Fonctionnalités](#-fonctionnalités)
- [Captures d'écran](#-captures-décran)
- [Stack technique](#-stack-technique)
- [Prérequis](#-prérequis)
- [Installation](#-installation)
- [Base de données](#-base-de-données)
- [Lancer l'application](#-lancer-lapplication)
- [Structure du projet](#-structure-du-projet)
- [Équipe](#-équipe)

---

## 🎯 Présentation

**MoneyWise** est une application desktop développée en **Java 21 + JavaFX 21** dans le cadre d'un projet universitaire. Elle permet à tout utilisateur de centraliser, visualiser et analyser ses mouvements financiers en temps réel, sans connexion internet requise.

### Problématique

De nombreuses personnes éprouvent des difficultés à suivre leurs finances personnelles au quotidien. L'absence d'un outil centralisé, simple et accessible conduit souvent à :
- Des dépassements de budget fréquents
- Une mauvaise visibilité sur les dépenses
- Une incapacité à épargner de manière structurée

### Solution

MoneyWise répond à ce besoin en offrant une interface intuitive avec :
- Suivi des transactions en temps réel
- Alertes budgétaires automatiques (80% et 100%)
- Export PDF et Excel des données
- Fonctionnement 100% hors ligne

---

## ✨ Fonctionnalités

| Module | Description | Statut |
|--------|-------------|--------|
| 🔐 **Authentification** | Inscription, connexion, session, BCrypt | ✅ Réalisé |
| 💳 **Transactions** | CRUD complet, filtres multi-critères, pagination | ✅ Réalisé |
| 📊 **Dashboard** | KPI temps réel, graphiques, résumé mensuel | ✅ Réalisé |
| 🏷 **Catégories** | 7 catégories système + personnalisées | ✅ Réalisé |
| 🔔 **Alertes Budget** | Notifications 80%/100%, popup, badge sidebar | ✅ Réalisé |
| 📤 **Export** | PDF (PDFBox) et Excel (Apache POI) | ✅ Réalisé |
| 👤 **Profil** | Informations, sécurité, préférences | ✅ Réalisé |
| 👑 **Administration** | Gestion utilisateurs, journaux | ⚠️ Partiel |

---

[//]: # (## 📸 Captures d'écran)

[//]: # ()
[//]: # (<div align="center">)

[//]: # ()
[//]: # (### Page de connexion)

[//]: # (![Login]&#40;docs/screenshots/login.png&#41;)

[//]: # ()
[//]: # (### Dashboard)

[//]: # (![Dashboard]&#40;docs/screenshots/dashboard.png&#41;)

[//]: # ()
[//]: # (### Gestion des transactions)

[//]: # (![Transactions]&#40;docs/screenshots/transactions.png&#41;)

[//]: # ()
[//]: # (### Statistiques & Graphiques)

[//]: # (![Statistiques]&#40;docs/screenshots/statistiques.png&#41;)

[//]: # ()
[//]: # (### Alertes & Budgets)

[//]: # (![Alertes]&#40;docs/screenshots/alertes.png&#41;)

[//]: # ()
[//]: # (</div>)

---

## 🛠 Stack technique

```
┌─────────────────────────────────────────────────┐
│  VUE          JavaFX 21  •  FXML  •  CSS        │
├─────────────────────────────────────────────────┤
│  CONTRÔLEUR   9 Controllers JavaFX               │
├─────────────────────────────────────────────────┤
│  MODÈLE       7 Entités Java (POJO)              │
├─────────────────────────────────────────────────┤
│  DAO          7 DAOs  •  JDBC  •  PreparedStmt   │
├─────────────────────────────────────────────────┤
│  BASE         MySQL 8.0  •  7 tables             │
└─────────────────────────────────────────────────┘
```

| Composant | Technologie | Version |
|-----------|-------------|---------|
| Langage | Java JDK LTS | 21 |
| UI Framework | JavaFX | 21.0.2 |
| Base de données | MySQL via JDBC | 8.3.0 |
| Hachage MDP | jBCrypt | 0.4 |
| Export PDF | Apache PDFBox | 3.0.1 |
| Export Excel | Apache POI (OOXML) | 5.2.5 |
| Icônes | Ikonli FontAwesome 5 | 12.3.1 |
| Build | Maven | 3.9+ |

---

## 📦 Prérequis

Avant de lancer MoneyWise, assurez-vous d'avoir installé :

| Logiciel | Version minimale | Lien |
|----------|-----------------|------|
| **JDK** (Java Development Kit) | 21 LTS | [adoptium.net](https://adoptium.net) |
| **MySQL Server** | 8.0+ | [mysql.com](https://www.mysql.com) |
| **Maven** | 3.9+ | [maven.apache.org](https://maven.apache.org) |
| **IDE** (recommandé) | IntelliJ IDEA | [jetbrains.com](https://www.jetbrains.com/idea/) |

---

## 🚀 Installation

### 1. Cloner le dépôt

```bash
git clone https://github.com/votre-repo/moneywise.git
cd moneywise
```

### 2. Créer la base de données

Connectez-vous à MySQL et exécutez le script SQL fourni :

```bash
mysql -u root -p < moneywise_db.sql
```

Ou manuellement dans MySQL :

```sql
CREATE DATABASE IF NOT EXISTS moneywise_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
```

### 3. Configurer la connexion

Ouvrez le fichier `src/main/java/com/project/dao/DatabaseConnection.java` et adaptez selon votre configuration :

```java
private static final String URL =
    "jdbc:mysql://localhost:3306/moneywise_db" +
    "?useSSL=false&serverTimezone=UTC";

private static final String USER     = "root";     // ← votre utilisateur MySQL
private static final String PASSWORD = "";          // ← votre mot de passe MySQL
```

### 4. Compiler le projet

```bash
mvn clean compile
```

---

## 🗄 Base de données

Le script `moneywise_db.sql` crée automatiquement :

### Tables

```
moneywise_db
├── utilisateur        → Comptes utilisateurs (standard + admin)
├── categorie          → Catégories système (7) + personnalisées
├── transaction        → Mouvements financiers ENTREE/SORTIE
├── budget             → Plafonds par catégorie/mois/année
├── alerte             → Notifications SEUIL_80 et SEUIL_100
├── export             → Historique des exports PDF/Excel
└── journal_activite   → Log des actions critiques
```

### Données initiales

✅ **7 catégories système** insérées automatiquement :
`Alimentation` · `Transport` · `Logement` · `Santé` · `Loisirs` · `Education` · `Autres`

✅ **Compte administrateur** par défaut :
- Email : `admin@moneywise.sn`
- ⚠️ **Important** : définir le mot de passe à la première connexion via l'application

### Schéma relationnel simplifié

```
utilisateur ──1────0..*──▶ transaction
utilisateur ──1────0..*──▶ budget
utilisateur ──1────0..*──▶ export
transaction ──*────1   ──▶ categorie
budget      ──*────1   ──▶ categorie
budget      ──1────0..*──▶ alerte
```

---

## ▶ Lancer l'application

```bash
mvn clean javafx:run
```

Ou depuis IntelliJ IDEA :
1. Ouvrir le projet (File → Open → dossier `moneywise`)
2. Attendre le chargement Maven
3. Cliquer **Run** sur la classe `App.java`

### Première connexion

1. Cliquez sur **"Créer un compte"** depuis la page de login
2. Remplissez le formulaire (nom, email, mot de passe ≥ 6 caractères)
3. Vous êtes automatiquement connecté après inscription

---

## 📁 Structure du projet

```
moneywise/
├── src/
│   ├── main/
│   │   ├── java/com/project/
│   │   │   ├── App.java                    ← Point d'entrée JavaFX
│   │   │   ├── controller/                 ← 9 Contrôleurs FXML
│   │   │   │   ├── HomeController.java
│   │   │   │   ├── TransactionController.java
│   │   │   │   ├── StatistiqueController.java
│   │   │   │   ├── AlertesController.java
│   │   │   │   ├── ProfilController.java
│   │   │   │   ├── LoginController.java
│   │   │   │   ├── InscriptionController.java
│   │   │   │   ├── SidebarController.java
│   │   │   │   └── TransactionModalController.java
│   │   │   ├── dao/                        ← Accès base de données
│   │   │   │   ├── DatabaseConnection.java
│   │   │   │   ├── UtilisateurDAO.java
│   │   │   │   ├── TransactionDAO.java
│   │   │   │   ├── BudgetDAO.java
│   │   │   │   ├── CategorieDAO.java
│   │   │   │   ├── AlerteDAO.java
│   │   │   │   └── JournalDAO.java
│   │   │   ├── model/                      ← Entités métier
│   │   │   │   ├── Utilisateur.java
│   │   │   │   ├── Transaction.java
│   │   │   │   ├── Budget.java
│   │   │   │   ├── Categorie.java
│   │   │   │   ├── Alerte.java
│   │   │   │   └── Export.java
│   │   │   ├── enums/
│   │   │   │   ├── TypeTransaction.java    ← ENTREE / SORTIE
│   │   │   │   ├── TypeAlerte.java         ← SEUIL_80 / SEUIL_100
│   │   │   │   └── FormatExport.java       ← PDF / EXCEL
│   │   │   └── utils/
│   │   │       ├── SessionManager.java
│   │   │       ├── NavigationHelper.java
│   │   │       ├── AlerteHelper.java
│   │   │       ├── DateHelper.java
│   │   │       └── ResponsiveHelper.java
│   │   └── resources/com/project/
│   │       ├── view/                       ← Fichiers FXML (interfaces)
│   │       ├── style/                      ← Feuilles CSS JavaFX
│   │       └── fonts/                      ← Polices DejaVu (export PDF)
│   └── module-info.java
├── moneywise_db.sql                        ← Script base de données
├── pom.xml                                 ← Configuration Maven
└── README.md
```

---

## 👥 Équipe

Projet réalisé par une équipe de 4 développeurs — **Université, Mars 2026**

| # | Nom & Prénom | Rôle |
|---|-------------|------|
| 01 | **Mohamed Lamarane Diallo** | Chef de projet · Architecture · Backend (BDD, sécurité, DAOs) |
| 02 | **Absa Fall** | Développement Frontend JavaFX (FXML, CSS, UX/UI, animations) |
| 03 | **Amadou Pagay Ba** | Module Transactions · Dashboard · Graphiques JavaFX |
| 04 | **Babacar Mbemba Sylla Cissé** | Module Export (PDF/Excel) · Alertes · Tests |

---

## 🔐 Sécurité

- ✅ Mots de passe hachés avec **BCrypt** (coût 12)
- ✅ Requêtes SQL via **PreparedStatement** (anti-injection)
- ✅ Validation côté client et serveur
- ✅ Journal d'activité pour toutes les actions critiques
- ✅ Vérification du solde avant chaque transaction de sortie

---

## 📄 Licence

Projet académique — **Tous droits réservés**  
Développé dans le cadre d'un cours de développement logiciel.

---

<div align="center">

**MoneyWise** — *Votre finances. Votre contrôle.*

Made with ❤️ by the MoneyWise Team · Mars 2026

</div>
