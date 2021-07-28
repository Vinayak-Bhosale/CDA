tableextension 50000 SalesReceivablesSetup_Extn extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Enable Sales Price Check"; Boolean)
        {
            Caption = 'Enable Sales Price Check';
        }
        field(50001; "Enable Credit Limit Check"; Boolean)
        {
            Caption = 'Enable Credit Limit Check';
        }
        field(50002; "Enable Overdue Check"; Boolean)
        {
            Caption = 'Enable Overdue Check';
        }

    }

    var
        myInt: Integer;
}