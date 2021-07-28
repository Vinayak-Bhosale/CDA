tableextension 50001 SalesHeader_Extn extends "Sales Header"
{
    fields
    {
        field(50000; "Sales Price Hold"; Boolean)
        {
            Caption = 'Sales Price Hold';
        }
        field(50001; "Credit Limit Hold"; Boolean)
        {
            Caption = 'Credit Limit Hold';
        }
        field(50002; "Overdue Hold"; Boolean)
        {
            Caption = 'Overdue Hold';
        }
    }

    var
        myInt: Integer;
}