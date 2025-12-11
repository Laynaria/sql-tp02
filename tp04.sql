-- a. Listez les articles dans l’ordre alphabétique des désignations
SELECT * from article ORDER BY designation;
-- b. Listez les articles dans l’ordre des prix du plus élevé au moins élevé
SELECT * from article ORDER BY prix DESC;
-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix
-- ascendant
SELECT * FROM article WHERE designation LIKE '%Boulon%' ORDER BY prix DESC;
-- d. Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT * FROM article WHERE designation LIKE '%sachet%';
-- e. Listez tous les articles dont la désignation contient le mot « sachet »
-- indépendamment de la casse !
SELECT * FROM article WHERE LOWER(designation) LIKE '%sachet%';
-- f. Listez les articles avec les informations fournisseur correspondantes. Les résultats
-- doivent être triées dans l’ordre alphabétique des fournisseurs et par article du prix le
-- plus élevé au moins élevé.
SELECT * FROM article INNER JOIN fournisseur ON article.id_fou = fournisseur.id ORDER BY fournisseur.name ASC, article.prix DESC;
-- g. Listez les articles de la société « Dubois & Fils »
SELECT * from article INNER JOIN fournisseur ON article.id_fou = fournisseur.id WHERE fournisseur.name = 'Dubois & Fils';
-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT fournisseur.name, AVG(article.prix) as moyenne from article
    INNER JOIN fournisseur ON article.id_fou = fournisseur.id WHERE fournisseur.name = 'Dubois & Fils'
    GROUP BY fournisseur.name;
-- i. Calculez la moyenne des prix des articles de chaque fournisseur
SELECT fournisseur.name, AVG(article.prix) as moyenne from article
    INNER JOIN fournisseur ON article.id_fou = fournisseur.id
    GROUP BY fournisseur.name;
-- j. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le
-- 05/04/2019 à 12h00.
SELECT * FROM bon WHERE date_cmde BETWEEN '2019-03-01' AND '2019-04-05';
-- k. Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT * FROM bon
    INNER JOIN compo ON bon.id = compo.id_bon
    INNER JOIN article on article.id = compo.id_art
    WHERE designation LIKE '%boulon%';
-- l. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom
-- du fournisseur associé.
SELECT bon.id as bon_id, fournisseur.name as fournisseur_name FROM bon
    INNER JOIN compo ON bon.id = compo.id_bon
    INNER JOIN article on article.id = compo.id_art
    INNER JOIN fournisseur on fournisseur.id = article.id_fou
    WHERE designation LIKE '%boulon%';
-- m. Calculez le prix total de chaque bon de commande
SELECT bon.id as bon_id, SUM(article.prix) as somme FROM bon
    INNER JOIN compo ON bon.id = compo.id_bon
    INNER JOIN article on article.id = compo.id_art
    INNER JOIN fournisseur on fournisseur.id = article.id_fou
    GROUP BY bon_id;
-- n. Comptez le nombre d’articles de chaque bon de commande
SELECT bon.id as bon_id, SUM(compo.qte) as somme FROM bon
    INNER JOIN compo ON bon.id = compo.id_bon
    INNER JOIN article on article.id = compo.id_art
    INNER JOIN fournisseur on fournisseur.id = article.id_fou
    GROUP BY bon.id;
-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et
-- affichez le nombre d’articles de chacun de ces bons de commande
SELECT bon.id as bon_id, SUM(compo.qte) as somme FROM bon
    INNER JOIN compo ON bon.id = compo.id_bon
    INNER JOIN article on article.id = compo.id_art
    INNER JOIN fournisseur on fournisseur.id = article.id_fou
    GROUP BY bon.id
    HAVING somme > 25;
-- p. Calculez le coût total des commandes effectuées sur le mois d’avril


-- a. Sélectionnez les articles qui ont une désignation identique mais des fournisseurs
-- différents (indice : réaliser une auto-jointure i.e. de la table avec elle-même)
-- b. Calculez les dépenses en commandes mois par mois (indice : utilisation des fonctions
-- MONTH et YEAR)
-- c. Sélectionnez les bons de commandes sans article (indice : utilisation de EXISTS)
-- d. Calculez le prix moyen des bons de commande par fournisseur.-- 