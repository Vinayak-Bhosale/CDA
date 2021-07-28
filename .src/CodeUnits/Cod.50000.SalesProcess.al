codeunit 50000 SalesProcess
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCheckSalesApprovalPossible', '', true, true)]
    local procedure "Approvals Mgmt._OnAfterCheckSalesApprovalPossible"(var SalesHeader: Record "Sales Header")
    begin
        Check_SO_Holds(SalesHeader);
    end;

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

}