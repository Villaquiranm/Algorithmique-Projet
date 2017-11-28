--with Liste_Generique;
with Participant;
with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;
use Participant;

package body Partie is


    -- Joue une partie.
    -- E : Etat initial
    -- J : Joueur qui commence
    procedure Joue_Partie(E : in out Etat; J : in Joueur) is
    Etat_Courant : Etat := E ;
    C : Coup ;
    Joueur_Courant : Joueur := J ;
    begin
	Affiche_Jeu(Etat_Courant) ;
	while not Est_Gagnant(Etat_Courant,Adversaire(Joueur_Courant)) and not Est_Fini(Etat_Courant) loop
	    if Joueur_Courant = Joueur1 then
		Put(Nom_Joueur1) ;
		C := Coup_Joueur1(Etat_Courant) ;
	    else
		Put(Nom_Joueur2) ;
		C := Coup_Joueur2(Etat_Courant) ;
	    end if ;
	    Affiche_Coup(C) ;
	    Etat_Courant := Etat_Suivant(Etat_Courant, C) ;
	    Affiche_Jeu(Etat_Courant) ;
	    Joueur_Courant := Adversaire(Joueur_Courant) ;
	end loop ;
	if Est_Nul(Etat_Courant) then
	    Put_Line("Personne n'a gagné") ;
	elsif Adversaire(Joueur_Courant) = Joueur1 then
	    Put_Line(Nom_Joueur1 & " a gagné") ;
	else
	    Put_Line(Nom_Joueur2 & " a gagné") ;
	end if ;
    end Joue_Partie ;


end Partie;
