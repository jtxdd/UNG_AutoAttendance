<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Instructor_Collect.aspx.cs" Inherits="UNG_AutoAttendance.Instructor.Collect.Instructor_Collect" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset ="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link href="../../Styling/Collect_Style.css" rel="stylesheet" />
    <title>Instructor Collect Attendance</title>
</head>

<body>

    <!-- TOP HEADER -->
    <h1 class ="top"></h1>

    <!-- LOGO -->
    <div class="logo img">
        <img src="https://ung.edu//_uploads/images/template/2015/logo-large.png" />
        <img src="https://ung.edu//_uploads/images/template/2015/logo-large-bottom.png" />
    </div>

    <form id="form1" runat="server">

        <!-- logout button -->
        <div class="loutbtn" style="font-size:14pt; position:absolute; top:25px; left: 1px; margin: 10px 410% 10px 90%; ">
            <asp:Button ID="logout_button" style="font-size:14pt;" class="loutbtn" runat="server" Text="Sign Out" OnClick="logout_button_Click" />
        </div>  

        <!-- change selection button -->
        <div class="loutbtn" style="position:absolute; font-size:14pt; top:25px; left: 1px; margin: 10px 410% 10px 75%; ">
            <asp:Button ID="change_button" style="font-size:14pt;" class="changebtn" runat="server" Text="Change Selection" />
        </div>

        <!-- "saving" header with animated ellipses . . . -->
        <div class="headtop">
            <div class="saving">
                <h1 style="color: #fff; font-size: 20pt; ">Collecting Attendance<span>.</span><span>.</span><span>.</span></h1>
            </div>
        </div>
        <!-- date label -->
        <div style="text-align: center; margin: 0 -2% 0 0;">
            <asp:Label ID="dateof_label" runat="server" style="color: #fff; font-size: 14pt; text-align: center;" Text=""></asp:Label>
            <br />
            <br />
        </div>

    <!-- script manager & update panel -->
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
            <!-- grid layout -->   
            <div class="grid-container">
                <!-- absent box  -->
                <div class="grid-item" style=" padding: 5px; text-align:center; margin: -15% 0 0 0;">
                    <h4 style="color:#fff; text-align:center;">Absent</h4>
                    <!-- gridview 1 -->
                        <div class="box">
                            <asp:GridView ID="GridView1" runat="server" class="mygrid" HeaderStyle-CssClass="gridheader" RowStyle-CssClass="gridrows" PagerStyle-CssClass="pager" CellSpacing="1" DataSourceID="SqlDataSource1"></asp:GridView>
                        </div>
                </div>
               
                <!-- labels & input textbox -->
                <div class="grid-item">
                    <div style="text-align:left;">
                        <!-- status label -->
                        <asp:Label ID="status_label" class="animated fadeOut" style="color: #fff; font-size: 14pt; text-align: left; "  runat="server"  Text=""></asp:Label>
                    </div>
                    <div style="text-align:center; margin: 0 0 0 -10%;">
                        <asp:TextBox ID="id_textbox" class="mytb" style="text-align:center" placeholder="Swipe Card or Enter ID" runat="server" AutoPostBack="True" OnTextChanged="id_textbox_TextChanged" AutoCompleteType="Disabled" TextMode="Password"></asp:TextBox>
                    </div>
                    <!-- div holding finished button
                    <div class="btmdiv">
                        <div class="btmdiv finbtn">
                            <asp:Button ID="done_button" class="finbtn"  runat="server" Text="Finished" />
                        </div>
                    </div>
                    -->
                </div>

                <!-- present box -->
                <div class="grid-item" style=" padding: 5px; text-align:center; margin: -15% 0 0 0;">
                    <h4 style="color:#fff; text-align:center;">Present</h4>
                        <div class="box">
                            <asp:GridView ID="GridView2" runat="server" class="mygrid" HeaderStyle-CssClass="gridheader" RowStyle-CssClass="gridrows" PagerStyle-CssClass="pager" CellSpacing="1" DataSourceID="SqlDataSource2"></asp:GridView>
                        </div>
                </div>
            </div>

            <!-- hidden control: holding value from course selection -->
            <asp:HiddenField ID="HiddenField1" runat="server" />

            <!-- hidden control: holding date for this meeting -->
            <asp:HiddenField ID="HiddenField2" runat="server" />

            <!-- sql data source for populating ABSENT -->
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AttendanceConnectionString %>" SelectCommand="get_absentMeeting" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField1" Name="courseId" PropertyName="Value" Type="String" />
                    <asp:ControlParameter ControlID="HiddenField2" DbType="Date" Name="meetDate" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>

            <!-- sql data source for populating PRESENT -->
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AttendanceConnectionString %>" SelectCommand="get_presentMeeting" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField1" Name="courseId" PropertyName="Value" Type="String" />
                    <asp:ControlParameter ControlID="HiddenField2" DbType="Date" Name="meetDate" PropertyName="Value" />
                </SelectParameters>
                </asp:SqlDataSource>

            </ContentTemplate>
            
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="id_textbox" EventName="TextChanged" />
            </Triggers>

        </asp:UpdatePanel>

    </form>
</body>
</html>
