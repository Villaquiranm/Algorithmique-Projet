--with Liste_Generique,
with Participant;
with Ada.Text_IO;
use Participant;

generic
    -- La largeur du plateau de jeu
    Largeur : Integer;
    -- La hauteur du plateau de jeu
    Hauteur : Integer;
    -- Nombre de pions alignés necessaires pour la victoire
    Nbr_Pions : Integer;


package Puissance4 is
    type Coup is private ;
    type Etat is private ;

    -- L'Etat initial est un tableau de null
    procedure Initialiser(E : in out Etat) ;
    -- Calcule l'etat suivant en appliquant le coup
    function Etat_Suivant(E : Etat; C : Coup) return Etat;
    -- Indique si on peut encore jouer
    function Est_Fini(E : Etat) return Boolean;
    -- Indique si l'etat courant est gagnant pour le joueur J
    function Est_Gagnant(E : Etat; J : Joueur) return Boolean;
    -- Indique si l'etat courant est un status quo (match nul)
    function Est_Nul(E : Etat) return Boolean;
    -- Fonction d'affichage de l'etat courant du jeu
    procedure Affiche_Jeu(E : Etat);
    -- Affiche a l'ecran le coup passe en parametre
    procedure Affiche_Coup(C : in Coup);
    -- Retourne le prochaine coup joue par le joueur1
    function Coup_Joueur1(E : Etat) return Coup;
    -- Retourne le prochaine coup joue par le joueur2
    function Coup_Joueur2(E : Etat) return Coup;

private
    type Coup is record
	Colonne: Integer ;
	J: Joueur ;
	Est_Joue: Boolean ;
    end record ;
    type Etat is array(1..Hauteur,1..Largeur) of Coup ;

end Puissance4 ;
