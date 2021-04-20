with crypto, Ada.Text_IO;
use crypto, Ada.Text_IO;
procedure crypto_demo is
   K: keys(6);
begin
   print_key(k);
   New_Line;

   Put_Line("before encryption with caesar : hello ");
   Put("encrypted: "); Put(encrypt_caesar("hello", k) ); New_line;
   Put("decrypted: "); Put(decrypt_caesar( encrypt_caesar("hello", k) , k) );
   New_line; New_Line;

   Put_Line("before encryption with vigenere : ADA is cool ");
   Put("encrypted: "); Put(encrypt_vigenere_with_numbers("ADA is cool", k) ); New_line;
   Put("decrypted: "); Put(decrypt_vigenere_with_numbers( encrypt_vigenere_with_numbers("ADA is cool", k), k) );
   New_line; New_Line;

   Put_Line("before encryption with position : ADA is cool ");
   Put("encrypted: "); Put(encrypt_with_pos("ADA is cool") ); New_line;
end crypto_demo;
