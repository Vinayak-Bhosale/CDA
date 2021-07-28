pageextension 50001 SalesOrder_Extn extends "Sales Order"
{
    layout
    {
        addafter(General)
        {
            group(Hold)
            {
                field("Sales Price Hold"; Rec."Sales Price Hold")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Credit Limit Hold"; Rec."Credit Limit Hold")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Overdue Hold"; Rec."Overdue Hold")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
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