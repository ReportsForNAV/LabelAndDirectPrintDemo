codeunit 50100 "Print Return Label"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure MyProcedure(var SalesHeader: Record "Sales Header")
    var
        Rec: Record "Sales Header";
        RecRef: RecordRef;
    begin
        with Rec do begin
            Rec := SalesHeader;
            if "Document Type" <> "Document Type"::"Return Order" then
                exit;

            Rec.SetRecFilter;

            RecRef.Open(Database::"Sales Header");
            RecRef.SetView(Rec.GetView);
            Report.Print(Report::"Return Label - Direct Print", '', 'Brother QL-800', RecRef);
        end;
    end;
}