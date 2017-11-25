with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;
with liste_generique;


procedure Test_jeu is

	procedure Put_Integer(I : in Integer) is
	begin
		Put(I, 3); -- max 3 chiffres...
	end Put_Integer;

	-- implementation d'un ABR d'entiers
	package liste_Integer is
		new Liste_Generique(Integer,0, Put_Integer, "=", "<");
	use liste_Integer;
	L : Liste;
begin
	L := Creer_Liste;
	Insere_Tete(10,L);
	Insere_Tete(1,L);
	Insere_Tete(5,L);
	Insere_Tete(6,L);
	Affiche_Liste(L);
	Libere_Liste(L);
end Test_jeu;
