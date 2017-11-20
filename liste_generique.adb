with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Unchecked_Deallocation;

package body liste_generique is

	-- a partir de ce type on peut faire diverse hypotheses sur la facon
	-- dont la liste est representee, notamment en ce qui concerne la
	-- liste vide
	type Cellule is record
		Val: Integer;
		Suiv: Liste;
	end record;
  type Iterateur_Interne is record
    Actual:Liste;
  end record

  procedure Next (It:in out Iterateur_Interne) is
  begin
    if (Has_next(It))then
      It:=It.Actual.next;
    end if;
  end Next;
  procedure Has_next (It:in Iterateur_Interne) is
  begin
    return (!(It=NULL));
  end Has_next;

	-- Procedure de liberation d'une Cellule (accedee par Liste)
	procedure Liberer is new Ada.Unchecked_Deallocation (Cellule, Liste);


	-- creation: init a null
	function Cree_Liste return Liste is
	begin
		return null;
	end Cree_Liste;

	-- liberation: vider et c'est tout...
	procedure Libere_Liste (L : in out Liste) is
	begin
		Vide(L);
	end Libere_Liste;


  ------------------------------------------------------------------------------
  -- BLOC 1:

  	-- true si liste vide, false sinon
  	function Est_Vide (L: in Liste) return Boolean is
  	begin
              return (L=null);
  	end Est_Vide;


  	-- insertion d'un element V en tete de liste
  	procedure Insere_Tete (V: Integer; L: in out Liste) is
          A:Liste;
  	begin
          A:=new Cellule'(V,L);
          L:=A;
  	end Insere_Tete;


  	-- affichage de la liste, dans l'ordre de parcours
  	procedure Affiche (L: in Liste) is
          c:Liste;
  	begin
          if L=NULL then
              Raise Erreur_liste_vide;
          else

              c:=L;
              put("le valeur c'est:"&Integer'image(c.Val));
              new_line;
              while (c.suiv/=null)loop
                  put("le valeur c'est:"&Integer'image(c.suiv.Val));
                  new_line;
                  c:=c.suiv;
              end loop;
              put("--------------------------------------------");
              new_line;
          end if;
      exception when erreur_liste_vide=>
              put_line("le tableau est vide");
  	end Affiche;


  	-- recherche sequentielle d'un element dans la liste
  	function Est_Present (V: Integer; L: Liste) return Boolean is
          c:Liste;
  	begin
          c:=L;
          if (c.val=V)then
              return true;
          end if;
          while (c.suiv/=null)loop
              c:=c.suiv;
              if (c.val=V)then
                  return true;
              end if;
          end loop;
  		return false;
  	end Est_Present;


  ------------------------------------------------------------------------------
  -- BLOC 2:

  	-- Vide la liste
  	procedure Vide (L: in out Liste) is
          suivant:Liste;
  	begin
          while (L/=NULL) loop
              suivant:=L.suiv;
              Liberer(L);
              L:=Suivant;
          end loop;
  	end Vide;


  	-- insertion d'un element V en queue de liste
  	procedure Insere_Queue (V: Integer; L: in out Liste) is
  	     A:Liste;
           b:Liste;
  	begin
          b:=L;
          A:=new Cellule'(V,NULL);
          if (L/=NULL)then
              while (b.suiv/=Null) loop
                  b:=b.suiv;
  	        end loop;
              b.suiv:=A;
          else
          L:=A;
          end if;
         	end Insere_Queue;


  ------------------------------------------------------------------------------
  -- BLOC 3:

  	-- suppression de l'element en tete de liste
  	procedure Supprime_Tete (L: in out Liste; V: out Integer) is
          prochain:Liste;
  	begin
          if (L=NULL) then
             raise Erreur_Liste_Vide;
          else
              Prochain:=L.suiv;
              V:=L.Val;
              liberer(L);
              L:=Prochain;
          end if;
  	end Supprime_Tete;


  	-- suppression l'element en queue de listes
  	procedure Supprime_Queue (L: in out Liste; V: out Integer) is
          b:Liste;
      begin
          b:=L;
          if (L.suiv=NULL) then
              liberer(L);
          elsif(L=NULL) then
              Raise Erreur_liste_vide;
          else
               while (b.all.suiv.suiv/=Null) loop
                  b:=b.suiv;
  	         end loop;
               V:=b.suiv.Val;
               liberer(b.suiv);
          end if;

  	end Supprime_Queue;


  	-- suppression de la premiere occurence de V dans la liste
  	procedure Supprime_Premiere_Occurence (V: in Integer; L: in out Liste) is
         avant:Liste;
         maintenant:Liste;
         prochain:Liste;
      begin
          if(L=NULL) then
              Raise Erreur_liste_vide;
          else
              maintenant:=L;
              avant:=NULL;
              while ((maintenant.suiv/=Null)and(maintenant.val/=V)) loop
                  avant:=maintenant;
                  maintenant:=maintenant.suiv;
                  prochain:=maintenant.suiv;
  	        end loop;
              if (maintenant.val/=v)then
                  put("Le valeur n'est pas présent");
              else
                  if (avant=Null)then
                      L:=maintenant.suiv;
                      liberer(maintenant);
                  else
                      avant.suiv:=prochain;
                      liberer(maintenant);
                  end if;
              end if;
          end if;
  	end Supprime_Premiere_Occurence;


  	-- suppression de toutes les occurences de V de la liste
  	procedure Supprime (V: in Integer; L: in out Liste) is
         avant:Liste;
         maintenant:Liste;
         suivant:Liste;
      begin
          if(L=NULL) then
              Raise Erreur_liste_vide;
          elsif (L.suiv=Null) then
              liberer(L);
          else
              maintenant:=L;
              avant:=NULL;
              suivant:=L.suiv;
              while (maintenant/=Null) loop
                  if maintenant.val=v then
                      if avant=NULL then
                          L:=suivant;
                          liberer(maintenant);
                      else
                          avant.suiv:=suivant;
                          liberer(maintenant);
                      end if;

                  else
                      avant:=maintenant;
                      put("Le valeur n'est pas présent");
                      New_line;
                  end if;

                  maintenant:=suivant;
                  if suivant/=NULL then
                      suivant:=suivant.suiv;
                  end if;

  	        end loop;

          end if;
  	end Supprime;


  ------------------------------------------------------------------------------
  -- BLOC 4:

  	-- inversion l'ordre des elements dans une liste
  	-- (sans allocation et en temps lineaire)
  	procedure Inverse (L: in out Liste) is
          avant,maintenant,suivant:Liste;
  	begin
          maintenant:=L;
          suivant:=l.suiv;
          avant:=NULL;
          while l.suiv/=Null loop
              suivant.suiv:=maintenant;
              maintenant.suiv:=avant;
              avant:=maintenant;
              maintenant:=l.suiv;
              suivant:=maintenant.suiv;
          end loop;

  	end Inverse;

  end liste_generique;
