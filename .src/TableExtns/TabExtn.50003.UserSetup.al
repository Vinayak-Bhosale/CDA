tableextension 50003 UserSetup_Extn extends "User Setup"
{
    fields
    {
        field(50000; "Allowed Change Price"; Boolean)
        {
            Caption = 'Allowed Change Price';
        }
    }

    var
        myInt: Integer;
}