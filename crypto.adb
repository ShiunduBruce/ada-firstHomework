package body crypto is

   -- prints components of a keys record (single_key and multi_keys)
   procedure print_key(k: keys) is
   begin
      Put("Generated single_key is: "); Put(k.single_key); New_Line;
      Put("Generated multi_keys list is: ");
      for I in k.multi_keys'Range loop
       Put( k.multi_keys(I) );
      end loop;
      New_Line;
   end print_key;

   -- shifts Character to n times within its case range
   ---whether its a lower case or upper case
   function shift_char(c: Character; n:Integer) return Character is
      charValue : Integer;
      char : Character;
   begin
      if not Is_Upper(c) and not Is_Lower(c) then
         return c;
      end if;

      charValue :=  Character'Pos(c) + n mod 26;
      char := Character'Val(charValue);

      if Is_Upper(c) and not Is_Upper(char) then
         charValue := charValue - 26;
      end if;
      if Is_Lower(c) and not Is_Lower(char) then
         charValue := charValue - 26;
      end if;
      return  Character'Val(charValue);
   end shift_char;


   -- encrypts Srting by shifting each Character n times using single_key from k
   function encrypt_caesar(x:String; k:keys ) return String is
   begin
      return encrypt_string(x, k.single_key);
   end encrypt_caesar;

   -- encrypts String by shifting each Character
   --using multi_keys from k by iterating throw the keys over and over
   function encrypt_vigenere_with_numbers(x:String; k:keys ) return String is
      encrypted_string: String := x;
   begin
      for I in k.multi_keys'Range loop
         encrypted_string := encrypt_string( encrypted_string, k.multi_keys(I) );
       end loop;
      return encrypted_string;

   end encrypt_vigenere_with_numbers;

   -- encrypts Srting by shifting each Character n times
   --- n is the Character position relatively to its current case range
   -- its a lower case or upper case
   function encrypt_with_pos(x:String) return String is
      encrypted_string: String(x'Range);
      pos : Natural;
   begin
      for I in x'Range loop
         if Is_Upper( x(I) ) then
            pos := Character'Pos( x(I) ) - 65;
         elsif Is_Lower(x(I) ) then
            pos := Character'Pos( x(I) ) - 97;
         else
            pos := 0;
         end if;
         encrypted_string(I) := shift_char(x(I),  pos) ;
      end loop;
      return encrypted_string;
   end encrypt_with_pos;

    -- decrypts a previously encrypted caesar cipher (opposite of encrypt_caesar)
   function decrypt_caesar(x:String; k:keys ) return String is
      key : Integer := 26 - ( k.single_key mod 26 );
   begin
      return encrypt_string(x, key);
   end decrypt_caesar;

   -- decrypts a previously encrypted vigenere cipher
   -- of encrypt_vigenere_with_numbers)
   function decrypt_vigenere_with_numbers(x:String; k:keys ) return String is
      decrypted_string: String := x;
      key: Natural;
   begin
      for I in reverse k.multi_keys'Range loop
         key :=26 - ( k.multi_keys(I) mod 26 );
         decrypted_string := encrypt_string( decrypted_string, key );
      end loop;
      return decrypted_string;
   end decrypt_vigenere_with_numbers;

   --generates a random Natural number between 0 to 26
   function Generate_key return Natural is
      package Random_nat is new Ada.Numerics.Discrete_Random (Natural);
      G : Random_nat.Generator;
   begin
      Random_nat.Reset(G);
      return Random_nat.Random(G) rem 26;
   end Generate_key;

    -- generates a keys_arr type array of random Natural numbers between 0 to 26
   function Generate_keys(len: Positive) return keys_arr is
      arr : keys_arr(1..len);
   begin
      for i in 1..len loop
         arr(i) := Generate_key;
      end loop;
      return arr;
   end Generate_keys;

   --shifts a string by the given integer
   function encrypt_string(x:String; k:Natural ) return String is
        encrypted_string : String(x'Range);
   begin
      for I in x'Range loop
         encrypted_string(I) := shift_char(x(I), k);
      end loop;
      return encrypted_string;
   end encrypt_string;


end crypto;
