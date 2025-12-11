-- a. Mettez en minuscules la désignation de l'article dont l'identifiant est 2
UPDATE article SET designation = LOWER(designation) WHERE id = 2;

-- b. Mettez en majuscules les désignations de tous les articles dont le prix est strictement 
-- supérieur à 10€
UPDATE article SET designation = UPPER(designation) WHERE prix > 10;

-- c. Baissez de 10% le prix de tous les articles qui n'ont pas fait l'objet d'une commande.
UPDATE article
	LEFT JOIN compo on article.id = compo.id_art
	SET prix = (prix * 0.9)
    WHERE id_art IS NULL;

-- d. Une erreur s'est glissée dans les commandes concernant Française d'imports. Les chiffres
-- en base ne sont pas bons.
-- Il faut doubler les quantités de tous les articles commandés à cette société.
UPDATE compo
    INNER JOIN bon ON compo.id_bon = bon.id
    INNER JOIN fournisseur ON bon.id_fou = fournisseur.id
    SET compo.qte = (compo.qte * 2)
    WHERE fournisseur.name = 'Française d''Imports';
    
-- e. Mettez au point une requête update qui permette de supprimer les éléments entre parenthèses dans les désignations.
-- Il vous faudra utiliser des fonctions comme substring et position.
UPDATE article
    SET designation =
    CONCAT(
        SUBSTR(
            designation,
            1,
            POSITION('(' IN designation) - 1
            ),
        SUBSTR(
            designation,
            POSITION(')' IN designation) +1
            )
    );