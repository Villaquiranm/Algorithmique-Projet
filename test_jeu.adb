with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;
--with liste_generique;


procedure Test_jeu is

	procedure Put_Integer(I : in Integer) is
	begin
		Put(I, 3); -- max 3 chiffres...
	end Put_Integer;

	-- implementation d'un ABR d'entiers
	package liste_Integer is
		new Liste_Generique(Integer,1, Put_Integer, "=", "<");
	use liste_Integer;

	L : Liste;
	It: Iterateur;
begin
	L := Creer_Liste;
	Insere_Tete(10,L);
	Affiche_Liste(L);
end Test_jeu;
