with Ada.Text_IO;
with Ada.Integer_Text_IO;

package body Board is
    package IO renames Ada.Text_IO;
    package IIO renames Ada.Integer_Text_IO;

    Grid : Grid_Type := (others => None);

    function Is_Playable ( Position : in Position_Type) return Boolean is
    begin
        return (case Grid (Position) is
            when None => True,
            when others => False);
    end Is_Playable;

    function Play 
        (Player :   in Player_Type; 
         Position : in Position_Type)
        return Status_Type
    is

        function Has_Won return Boolean is
            Col_Count : Integer := 0;
            Row_Count : Integer := 0;
            Diag_Count : Integer := 0;
        begin
            for I in Position_Type range 1 .. 3 loop
                for J in Position_Type range 1 .. 3 loop
                    if Grid ((I - 1) * 3 + J) = Player then
                        Col_Count := Col_Count + 1;
                    end if;

                    if Grid ((J - 1) * 3 + I) = Player then
                        Row_Count := Row_Count + 1;
                    end if;
                end loop;
            end loop;

            if Grid (1) = Player then
                Diag_Count := Diag_Count + 1;
            end if;

            if Grid (5) = Player then
                Diag_Count := Diag_Count + 1;
            end if;

            if Grid (9) = Player then
                Diag_Count := Diag_Count + 1;
            end if;

            return Col_Count = 3 or else Row_Count = 3 or else Diag_Count = 3;
        end Has_Won;

    begin
        if Is_Playable (Position) then
            Grid (Position) := Player;
            return (if Has_Won then Win else Success);
        else
            return Error;
        end if;
    end Play;

    procedure Display is
    begin
        for I in Grid'Range loop
            case Grid (I) is
                when X    => IO.Put (" x ");
                when O    => IO.Put (" o ");
                when None => 
                    IO.Put ("[");
                    IIO.Put (Integer(I), Width => 0);
                    IO.Put ("]");
            end case;

            if I /= 9 and then  I mod 3 = 0 then
                IO.Put (ASCII.LF);
            end if;
        end loop;
    end Display;

end Board;