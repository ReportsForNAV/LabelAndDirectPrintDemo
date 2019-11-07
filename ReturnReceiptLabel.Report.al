Report 50100 "Sales Return Label"
{
    // Copyright (c) 2017-2019 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

    Caption = 'Sales Return Label';
    ProcessingOnly = true;
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Args; "ForNAV Label Args.")
        {
            DataItemTableView = sorting("Report ID");
            UseTemporary = true;
            column(ReportForNavId_2; 2)
            {
            }
        }
        dataitem(Label; "Sales Header")
        {
            DataItemTableView = where("Document Type" = const("Return Order"));
            RequestFilterFields = "No.", "Shipment Date";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PrintLabel;
            end;

            trigger OnPreDataItem()
            begin
                ShowLabelWarning;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Orientation; Args.Orientation)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Orientation';

                        trigger OnValidate()
                        begin
                            Args.Validate(Orientation, Args.Orientation);
                        end;
                    }
                    field(OneLabelPerPackage; Args."One Label per Package")
                    {
                        ApplicationArea = Basic;
                        Caption = 'One Label per Package';
                    }
                    field(ForNavOpenDesigner; Args."Open Designer")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Design';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            Args.GetOrientationForRequestPage;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        Codeunit.Run(Codeunit::"ForNAV First Time Setup");
        Commit;
    end;

    local procedure PrintLabel()
    var
        CreateLabel: Codeunit "ForNAV Label Mgt.";
    begin
        case Args.Orientation of
            Args.Orientation::Landscape:
                Args."Report ID" := Report::"ForNAV Label Landscape";
            Args.Orientation::Portrait:
                Args."Report ID" := Report::"ForNAV Label Portrait";
        end;
        Args.CreateLabels(Label);
    end;

    local procedure ShowLabelWarning()
    var
        LabelWarning: Codeunit "ForNAV Label Warning";
    begin
        LabelWarning.ShowLabelWarning(Label.Count);
    end;
}

