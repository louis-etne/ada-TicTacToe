package Board is

    type Status_Type is (Success, Error, Win);

    type Position_Type is range 1 .. 9;
    type Cell_Type is (None, X, O);
    subtype Player_Type is Cell_Type range X .. O;

    function Is_Playable (Position : in Position_Type) return Boolean;

    function Play 
        (Player :   in Player_Type; 
         Position : in Position_Type)
        return Status_Type;

    procedure Display;

private
    type Grid_Type is array (Position_Type) of Cell_Type;

end Board;