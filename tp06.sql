-- a. Supprimer dans la table compo toutes les lignes concernant les bons de commande d'avril 2019
SET SQL_SAFE_UPDATES=0;
DELETE FROM compo
    WHERE compo.id_bon IN (SELECT id_bon FROM bon where MONTH(bon.date_cmde) = 4 AND YEAR(bon.date_cmde) = 2019);

-- b. Supprimer dans la table bon tous les bons de commande d'avril 2019.
DELETE FROM bon where MONTH(bon.date_cmde) = 4 AND YEAR(bon.date_cmde) = 2019;