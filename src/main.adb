with Ada.Text_IO;
with Board;

procedure Main is

    package IO renames Ada.Text_IO;
    use Board;

    Quit : Boolean := False;
    Current_Player : Board.Player_Type := Board.X;
    Current_Status : Board.Status_Type := Board.Success;

    procedure Next_Player is
    begin
        Current_Player := (case Current_Player is when Board.X => Board.O, when Board.O => Board.X);
    end Next_Player;

    procedure Input is
        User_Input : Character;
    begin
        if Current_Player = Board.X then
            IO.Put ("x>");
        else
            IO.Put ("o>");
        end if;

        IO.Get (User_Input);

        if User_Input = 'q' then
            Quit := True;
        else
            Current_Status := Board.Play (Current_Player, Board.Position_Type'Value ((1 => User_Input)));
        end if;
    end Input;

begin

    Game:
        loop
            Board.Display;
            IO.Put (ASCII.LF);
            Input;

            case Current_Status is
                when Win => 
                    if Current_Player = Board.X then
                        IO.Put_Line ("x won! Well done.");
                    else
                        IO.Put_Line ("o won! Well done.");
                    end if;

                    Quit := True;
                when Success => Next_Player;
                When Error => IO.Put_Line ("Non playable move. Try again");
            end case;

            exit Game when Quit;
            IO.Put (ASCII.LF);
        end loop Game;

end Main;