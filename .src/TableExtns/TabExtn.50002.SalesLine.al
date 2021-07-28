tableextension 50002 SalesLine_Extn extends "Sales Line"
{
    fields
    {
        field(50000; "Original Unit Price"; Decimal)
        {
            Caption = 'Original Unit Price';
        }
    }

    var
        myInt: Integer;
}