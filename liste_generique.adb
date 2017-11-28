with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Unchecked_Deallocation;

package body liste_generique is

	-- a partir de ce type on peut faire diverse hypotheses sur la facon
	-- dont la liste est representee, notamment en ce qui concerne la
	-- liste vide

	Sentinelle : Element;
	type Cellule is record
	    Val: Element;
	    Suiv: Liste;
	end record;

	type Iterateur_Interne is record
	    Tete: Liste;
	    Actuel: Liste;
	end record;


	procedure Liberer is new Ada.Unchecked_Deallocation (Cellule,Liste);
	procedure Free_Iterateur is new Ada.Unchecked_Deallocation (Iterateur_Interne,Iterateur);


	--Iterateur Code:
	function Creer_Iterateur(L:Liste) return Iterateur is
	begin
	    return new Iterateur_Interne'(L,L);
	end Creer_Iterateur;


	procedure Suivant(It : in out Iterateur) is
	begin
	    It.Actuel := It.Actuel.Suiv;
	end Suivant;


	function Element_Courant(It : Iterateur) return Element is
	begin
	    return It.Actuel.Val;
	end Element_Courant;


	function A_Suivant(It : Iterateur) return Boolean is
	begin
	    return It.Actuel.Suiv/=null;
	end A_Suivant;


	procedure Libere_Iterateur(It : in out Iterateur) is
	begin
	    Liberer(It.Tete) ;
	    Liberer(It.Actuel) ;
	    Free_Iterateur(It) ;
	end Libere_Iterateur ;


---------------------------------------------------------------------------------

	procedure Affiche_Liste (L:in Liste) is
		It : Iterateur := Creer_Iterateur(L);
  	begin
            while A_Suivant(It) loop
		Suivant(It);
                Put(Element_Courant(It));
            end loop;
  	end Affiche_Liste ;


  	-- Insertion d'un element V en tete de liste
  	procedure Insere_Tete (V: in Element; L: in out Liste) is
            A : Liste := new Cellule'(V,L.Suiv) ;
  	begin
            L.Suiv := A;
  	end Insere_Tete;


	-- Libere tous les éléments de la liste sauf la sentinelle
	procedure Libere_Liste (L : in out Liste) is
	    Next : Liste := L.Suiv ;
	    Current : Liste := L ;
	begin
	    while Next/=null loop
		Current := Next ;
		Next := Next.Suiv ;
		Liberer(Current) ;
	    end loop ;
	end Libere_Liste;


	-- Creer une liste avec comme seul élément la sentinelle
	function Creer_Liste return Liste is
	    L : Liste := new Cellule'(Sentinelle,null) ;
	begin
	    return L ;
	end Creer_Liste;

-----------------------------------------------------------------------------------

  end liste_generique;
