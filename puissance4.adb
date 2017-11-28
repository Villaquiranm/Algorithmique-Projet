--with Liste_Generique,
with Participant;
with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;
use Participant;

package body Puissance4 is

    --type Coup is record
    --  Colonne: Integer ;
    --  J: Joueur ;

    -- L'Etat initial est un tableau 
    procedure Initialiser(E : in out Etat) is
    begin
	for i in 1..Hauteur loop
	    for k in 1..Largeur loop
		E(i,k).Colonne := k ;
		E(i,k).Est_Joue := False ;
	    end loop ;
	end loop ;
    end Initialiser ;


    -- Calcule l'etat suivant en appliquant le coup
    function Etat_Suivant(E : Etat; C : Coup) return Etat is
	Etat_Suiv : Etat := E ;
	Ligne : Integer := 1 ;
    begin
	while Etat_Suiv(Ligne,C.Colonne).Est_Joue loop
	    Ligne := Ligne+1 ;
	end loop ;
	Etat_Suiv(Ligne,C.Colonne) := C ;
	return Etat_Suiv ;
    end Etat_Suivant ;


    -- Indique si on peut encore jouer
    function Est_Fini(E : Etat) return Boolean is
    begin
	for i in E'range(1) loop
	    for k in E'range(2) loop
		if not E(i,k).Est_Joue then
		    return False ;
		end if ;
	    end loop ;
	end loop ;
	return True ;
    end Est_Fini ;


    -- Indique si l'etat courant est gagnant pour le joueur J
    function Est_Gagnant(E : Etat; J : Joueur) return Boolean is
    Ligne : Integer ;
    Colonne : Integer ;
    Compteur_Pions : Integer ;
    begin
	for i in E'range(1) loop
	    for k in E'range(2) loop
		Ligne := i ;
		Colonne := k ;
		Compteur_Pions := 0 ;
		while ((Ligne <= Hauteur) and then (E(Ligne,k).Est_Joue) and then (E(Ligne,k).J = J)) loop --On regarde si il y a Nbr_Pions alignés sur la Colonne
		    Compteur_Pions := Compteur_Pions+1 ;
		    Ligne := Ligne+1 ;
		    if Compteur_Pions = Nbr_Pions then
			return True ;
		    end if ;
		end loop ;
		Compteur_Pions := 0 ;
		while ((Colonne <= Largeur) and then (E(i,Colonne).Est_Joue) and then (E(i,Colonne).J = J)) loop --On regarde si il y a Nbr_Pions alignés sur la Ligne
		    Compteur_Pions := Compteur_Pions+1 ;
		    Colonne := Colonne+1 ;
		    if Compteur_Pions = Nbr_Pions then
			return True ;
		    end if ;
		end loop ;
		Ligne := i ;
		Colonne := k ;
		Compteur_Pions := 0 ;
		while ((Colonne <= Largeur and Ligne <= Hauteur) and then (E(Ligne,Colonne).Est_Joue) and then (E(Ligne,Colonne).J = J)) loop --On regarde en diagonale droite
		    Compteur_Pions := Compteur_Pions+1 ;
		    Colonne := Colonne+1 ;
		    Ligne := Ligne+1 ;
		    if Compteur_Pions = Nbr_Pions then
			return True ;
		    end if ;
		end loop ;
		Ligne := i ;
		Colonne := k ;
		Compteur_Pions := 0 ;
		while ((Colonne > 0 and Ligne <= Hauteur) and then (E(Ligne,Colonne).Est_Joue) and then (E(Ligne,Colonne).J = J)) loop --On regarde en diagonale gauche
		    Compteur_Pions := Compteur_Pions+1 ;
		    Colonne := Colonne-1 ;
		    Ligne := Ligne+1 ;
		    if Compteur_Pions = Nbr_Pions then
			return True ;
		    end if ;
		end loop ;
	    end loop ;
	end loop ;
	return False ;
    end Est_Gagnant ;


    -- Indique si l'etat courant est un status quo (match nul)
    function Est_Nul(E : Etat) return Boolean is
    begin
	if not Est_Gagnant(E,Joueur1) and not Est_Gagnant(E,Joueur2) then
	    return True ;
	end if ;
	return False ;
    end Est_Nul ;


    -- Fonction d'affichage de l'etat courant du jeu
    procedure Affiche_Jeu(E : Etat) is
 
    begin
	Put(" ");
	for i in 1..Largeur loop
	    Put(Integer'Image(i)) ;
	end loop ;
	New_Line ;
	for i in reverse 1..Hauteur loop
	    Put(" ");
	    for k in 1..Largeur loop
		Put("|") ;
		if E(i,k).Est_Joue then
		    if E(i,k).J = Joueur1 then
			Put("X") ;
		    else
			Put("O") ;
		    end if ;
		else
		    Put(" ") ;
		end if ;
	    end loop ;
	    Put("|") ;
	    New_Line ;
	end loop ;
	for i in 1..Largeur loop
	    Put("---") ;
	end loop ;
	New_Line ;
    end Affiche_Jeu ;


    -- Affiche a l'ecran le coup passe en parametre
    procedure Affiche_Coup(C : in Coup) is
    begin
	Put_Line(Joueur'Image(C.J) & " joue : " & Integer'Image(C.Colonne)) ;
    end Affiche_Coup ;


    -- Retourne le prochaine coup joue par le joueur1
    function Coup_Joueur1(E : Etat) return Coup is
    C : Coup ;
    begin
	Put(" -> Numéro de colonne : ") ;
	Get(C.Colonne) ;
	if C.Colonne < 1 or C.Colonne > Largeur then
	    Put_Line("Le numéro de colonne est compris entre 1 et " & Integer'Image(Largeur)) ;
	    Put_Line("Recommencez") ;
	    return Coup_Joueur1(E) ;
	elsif E(Hauteur,C.Colonne).Est_Joue then
	    Put_Line("La colonne est déjà remplie") ;
	    Put_Line("Jouez une autre colonne") ;
	    return Coup_Joueur1(E) ;
	end if ;
	C.J := Joueur1 ;
	C.Est_Joue := True ;
	return C ;
    end Coup_Joueur1 ;


    -- Retourne le prochaine coup joue par le joueur2
    function Coup_Joueur2(E : Etat) return Coup is
    C : Coup ;
    begin
	Put(" -> Numéro de colonne : ") ;
	Get(C.Colonne) ;
	if C.Colonne < 1 or C.Colonne > Largeur then
	    Put_Line("Le numéro de colonne est compris entre 1 et " & Integer'Image(Largeur)) ;
	    Put_Line("Recommencez") ;
	    return Coup_Joueur2(E) ;
	elsif E(Hauteur,C.Colonne).Est_Joue then
	    Put_Line("La colonne est déjà remplie") ;
	    Put_Line("Jouez une autre colonne") ;
	    return Coup_Joueur2(E) ;
	end if ;
	C.J := Joueur2 ;
	C.Est_Joue := True ;
	return C ;
    end Coup_Joueur2 ;


end Puissance4 ;
