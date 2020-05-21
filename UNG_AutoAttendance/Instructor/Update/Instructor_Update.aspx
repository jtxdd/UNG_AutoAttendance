<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Instructor_Update.aspx.cs" Inherits="UNG_AutoAttendance.Instructor.Update.Instructor_Update" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset ="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link href="../../Styling/Update_Style.css" rel="stylesheet" />
    <title>Instructor Update Attendance</title>
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
        <asp:Button ID="logout_button" style="font-size:14pt;" class="loutbtn"  runat="server" Text="Sign Out" OnClick="logout_button_Click" />
    </div>

    <!-- change selection button -->
    <div class="rtrnbtn" style="position:absolute; font-size:14pt; top:25px; left: 1px; margin: 10px 410% 10px 75%; ">
        <asp:Button ID="return_button" Class="rtrnbtn" style="font-size:14pt;" runat="server" Text="Change Selection" OnClick="return_button_Click" />
    </div>

        <!-- update panel -->
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <!-- status label -->
                <div class="box">
                    <asp:Label ID="lbl1" style="color:white; font-size: 16pt; margin-top: -1%; " Text="Select a student to update attendance" runat="server"></asp:Label>
                </div>

                <br />

                <!-- container for gridview centering... -->
                <div class="grid-container" style="display:flex; justify-content:center; flex-direction:column; align-items:center;">
                    <div class="grid-item" style="align-content:center; align-self:center; text-align: center;">
                        <!-- gridview -->
                        <asp:GridView ID="GridView1" runat="server" class="mygrid" HeaderStyle-CssClass="gridheader" RowStyle-CssClass="gridrows" PagerStyle-CssClass="pager" CellSpacing="1" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" >
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" SelectText="Select" />
                            </Columns>
                            <HeaderStyle CssClass="gridheader" />
                            <PagerStyle CssClass="pager" />
                            <RowStyle CssClass="gridrows" />
                        </asp:GridView>
                    </div>
                </div>
                <br />
                <br />
                <!-- status label -->
                <div class="box animated fadeOut">
                    <asp:Label ID="Label2" class="animated fadeOut" style="color:white; font-size: 16pt; margin-top: -1%; " Text="" runat="server"></asp:Label>
                </div>

                <!-- hidden control holding course id -->
                <asp:HiddenField ID="HiddenField1" runat="server" />

                <!-- sql data source for gridview -->
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AttendanceConnectionString %>" SelectCommand="get_absents2" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField1" Name="courseId" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
                <!-- hidden control holding selected id -->
                <asp:HiddenField ID="HiddenField2" runat="server" />

                <!-- hidden control holding meet date -->
                <asp:HiddenField ID="HiddenField3" runat="server" />


            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="SelectedIndexChanged" />
            </Triggers>
        </asp:UpdatePanel>



        <!--  -->

    </form>
</body>
</html>
