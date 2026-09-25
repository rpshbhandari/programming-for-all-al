codeunit 50101 "Loan Repayment Event Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertVendor(var Rec: Record Vendor)
    begin
        Message('New vendor %1 created — remember to review repayment schedules.', Rec."No.");
    end;
}
