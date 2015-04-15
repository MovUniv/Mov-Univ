create or replace function listProprioALouer(varchar, varchar) returns text as $$
	DECLARE
		c record;
		contenuAAlouer text='';
		vendeur immo.personnel.noPers%type;
	BEGIN
		select noPers into vendeur from immo.Personnel where nom =$1 and prenom= $2;
		if (not found)
		then
			raise exception '% % n est pas dans la base de donnée',$1, $2;
		end if;
			contenuAAlouer:= 'Nom : ' || $1 || ' Prenom : ' || $2 || E'\n'; 
		for c in (select noPropriete, rue, ville, codePostal, type from immo.ALouer where noPers = vendeur and alouer.noPropriete not in (select distinct noPropriete from immo.visite))
		LOOP
			contenuAAlouer:=contenuAAlouer || c.noPropriete || ' ' || c.rue  || ' ' || c.ville  || ' ' || c.codePostal  || ' ' S|| c.type || E'\n'; 
		END LOOP;

		return contenuAAlouer;

		END;
$$ language plpgsql;