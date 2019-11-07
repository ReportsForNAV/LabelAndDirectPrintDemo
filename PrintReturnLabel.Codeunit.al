codeunit 50100 "Print Return Label"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure MyProcedure(var SalesHeader: Record "Sales Header")
    var
        Rec: Record "Sales Header";
    begin
        with Rec do begin
            Rec := SalesHeader;
            if "Document Type" <> "Document Type"::"Return Order" then
                exit;

            Rec.SetRecFilter;
            Report.Run(Report::"Sales Return Label", true, false, Rec);
        end;
    end;
}