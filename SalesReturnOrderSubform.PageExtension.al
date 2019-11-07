pageextension 50100 "My Sales Return Order Subform" extends "Sales Return Order Subform"
{
    layout
    {
        addfirst(Control1)
        {
            field(FooBar; FooBar)
            {
                ApplicationArea = All;

            }
        }
    }

}