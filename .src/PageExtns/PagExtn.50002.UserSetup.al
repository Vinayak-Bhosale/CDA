pageextension 50002 UserSetup_Extn extends "User Setup"
{
    layout
    {
        addafter("Allow Posting To")
        {
            field("Allowed Change Price"; Rec."Allowed Change Price")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}