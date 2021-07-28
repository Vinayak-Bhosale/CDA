pageextension 50000 SalesReceivablesSetup_extn extends "Sales & Receivables Setup"
{
    layout
    {
        addafter(Dimensions)
        {
            group("Holds")
            {
                field("Enable Sales Price Check"; Rec."Enable Sales Price Check")
                {
                    ApplicationArea = all;
                }
                field("Enable Credit Limit Check"; Rec."Enable Credit Limit Check")
                {
                    ApplicationArea = all;
                }
                field("Enable Overdue Check"; Rec."Enable Overdue Check")
                {
                    ApplicationArea = all;
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