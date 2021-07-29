codeunit 50000 SalesProcess
{
    //Procedure to call a procedure which will check hold are applicable to Sales Order
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCheckSalesApprovalPossible', '', true, true)]
    local procedure "Approvals Mgmt._OnAfterCheckSalesApprovalPossible"(var SalesHeader: Record "Sales Header")
    begin
        Check_SO_Holds(SalesHeader);
    end;

    //Procedure to check whether holds are applicable to sales order
    local procedure Check_SO_Holds(var SalesHeader: Record "Sales Header")
    begin
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            SalesHeader.TestField(SalesHeader."Bill-to Customer No.");

            SalesHeader."Overdue Hold" := false;
            SalesHeader."Credit Limit Hold" := false;
            SalesHeader."Sales Price Hold" := false;

            Check_SO_CreditLimit_Hold(SalesHeader);
            Check_SO_SalesPrice_Hold(SalesHeader);
            Check_SO_Overdue_Hold(SalesHeader);
        end;
    end;

    //Procedure to check whether Overdue hold is applicable
    local procedure Check_SO_Overdue_Hold(var SalesHeader: Record "Sales Header")
    var
        Customer: Record Customer;
    begin
        Customer.Get(SalesHeader."Bill-to Customer No.");
        IF Customer.CalcOverdueBalance() > 0 then begin
            SalesHeader."Overdue Hold" := true;
            SalesHeader.Modify();
        end;
    end;

    //Procedure to check whether Credit Limit hold is applicable
    local procedure Check_SO_CreditLimit_Hold(var SalesHeader: Record "Sales Header")
    var
        Customer: Record Customer;
    begin
        Customer.Get(SalesHeader."Bill-to Customer No.");
        IF (Customer.GetTotalAmountLCY() > Customer."Credit Limit (LCY)") then begin
            SalesHeader."Credit Limit Hold" := true;
            SalesHeader.Modify();
        end
    end;

    //Procedure to check whether Sales Price hold is applicable 
    local procedure Check_SO_SalesPrice_Hold(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Reset();
        SalesLine.SetRange(SalesLine."Document Type", SalesHeader."Document Type");
        SalesLine.SetRange(SalesLine."Document No.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                if (SalesLine."Unit Price" <> SalesLine."Original Unit Price") then begin
                    SalesHeader."Sales Price Hold" := true;
                    SalesHeader.Modify();
                    exit;
                end;
            until SalesLine.Next() = 0;
    end;

    //Procedure to capture Original Unit Price

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateUnitPrice', '', true, true)]
    local procedure "Sales Line_OnAfterUpdateUnitPrice"
    (
        var SalesLine: Record "Sales Line";
        xSalesLine: Record "Sales Line";
        CalledByFieldNo: Integer;
        CurrFieldNo: Integer
    )
    begin
        SalesLine."Original Unit Price" := SalesLine."Unit Price";
    end;

}