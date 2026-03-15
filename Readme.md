<div align="center">
  <h1>📊 Projet RH Analytics</h1>
  <p><strong>Analyse de données RH avec SQL • Projet d'entraînement</strong></p>
  <p>
    <img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white" />
    <img src="https://img.shields.io/badge/VS_Code-007ACC?style=for-the-badge&logo=visual-studio-code&logoColor=white" />
    <img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" />
    <img src="https://img.shields.io/badge/Markdown-000000?style=for-the-badge&logo=markdown&logoColor=white" />
  </p>
  <p>
    <a href="#-description-du-projet">Description</a> •
    <a href="#-structure-des-données">Données</a> •
    <a href="#-questions-métier">Questions</a> •
    <a href="docs/insights.md">📘 Insights</a> •
    <a href="#-auteur">Contact</a>
  </p>
  <p>
    <a href="docs/insights.md">
      <img src="https://img.shields.io/badge/📊_Accéder_aux_Insights-Cliquez_ici-blue?style=for-the-badge" />
    </a>
  </p>
</div>

---

## 📑 Table des matières
- [📋 Description du projet](#-description-du-projet)
- [🎯 Contexte et objectifs](#-contexte-et-objectifs)
- [🗂️ Structure des données](#️-structure-des-données)
- [🔍 Questions métier](#-questions-métier)
- [📊 Principaux insights](#-principaux-insights)
- [🛠️ Technologies utilisées](#️-technologies-utilisées)
- [🚀 Installation et exécution](#-installation-et-exécution)
- [📁 Structure du projet](#-structure-du-projet)
  - [📁 [scripts/] - Scripts SQL](#-scripts---scripts-sql)
  - [📁 [data/] - Données sources](#-data---données-sources)
  - [📁 [docs/] - Documentation](#-docs---documentation)
- [📈 Résultats clés](#-résultats-clés)
- [📘 Rapport d'analyse complet](#-rapport-danalyse-complet)
- [🎯 Compétences développées](#-compétences-développées)
- [👥 Auteur] : ABDOULAZIZ KEITA

---

## 📋 Description du projet

Ce projet est un **exercice personnel d'analyse de données RH** réalisé dans le cadre de ma formation en SQL.

À partir de **4 fichiers CSV** téléchargés publiquement, j'ai construit une base de données PostgreSQL et répondu à **15 questions métier** pour simuler une mission d'analyste RH.

L'objectif était de **mettre en pratique** :
- La création et la gestion de bases de données relationnelles
- L'écriture de requêtes SQL complexes (joins, CTE, fenêtrage)
- L'enrichissement des données avec des colonnes dérivées
- L'analyse et la synthèse de résultats métier

---

## 🎯 Contexte et objectifs

Ce projet simule une mission d'analyse pour un **service RH fictif**. À partir des données fournies, j'ai cherché à :

1. **Auditer la situation** des effectifs
2. **Analyser la performance** individuelle et collective
3. **Mesurer le turnover** et la rétention
4. **Identifier les talents** et les points de vigilance
5. **Proposer des recommandations** actionnables

Les données couvrent une période de **5 ans (2019-2023)** et concernent **1 500 employés** répartis dans **10 départements**.

---

## 🗂️ Structure des données

### 📌 Modèle relationnel

```mermaid
erDiagram
    departements ||--o{ employes : contient
    employes ||--o{ performances : realise
    employes ||--o{ turnover : concerne
    
    departements {
        int id_departement PK
        string nom_departement
        string manager
        decimal budget
    }
    
    employes {
        int id_employe PK
        string nom
        string prenom
        string poste
        int id_departement FK
        date date_embauche
        date date_depart
        decimal salaire
        int anciennete
        string cohorte
    }
    
    performances {
        int id_performance PK
        int id_employe FK
        date date_evaluation
        int score
        string objectifs_atteints
    }
    
    turnover {
        int id_depart PK
        int id_employe FK
        date date_depart
        string type_depart
        string anciennete
    }
}