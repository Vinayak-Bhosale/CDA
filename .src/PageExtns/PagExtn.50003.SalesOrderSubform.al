pageextension 50003 SalesOrderSubform_Extn extends "Sales Order Subform"
{
    layout
    {
        modify("Unit Price")
        {
            Editable = AllowedUser;
        }
    }

    trigger OnOpenPage()
    begin
        SetSalesPriceChangeAllowed(AllowedUser);
    end;

    var
        AllowedUser: Boolean;

    procedure SetSalesPriceChangeAllowed(Var AllowedUser: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        AllowedUser := false;
        if UserSetup.Get(UserId) then
            if UserSetup."Allowed Change Price" = true then
                AllowedUser := true;
    end;
}