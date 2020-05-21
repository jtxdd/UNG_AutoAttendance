<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Instructor_User.aspx.cs" Inherits="UNG_AutoAttendance.Instructor.Instructor_User" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset ="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link href="../Styling/Instructor_Style.css" rel="stylesheet" />
    <title>Instructor User</title>
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
    <div class="loutbtn" style="font-size: 14pt; position:absolute; top:25px; left: 1px; margin: 10px 410% 10px 90%; ">
        <asp:Button ID="logout_button" class="loutbtn" runat="server" Text="Sign Out" OnClick="logout_button_Click" />
    </div>

    <div class="rtrnbtn" style="position:absolute; font-size:14pt; top:25px; left: 1px; margin: 10px 410% 10px 75%; ">
        <asp:Button ID="roster_button" Class="rtrnbtn" style="font-size:14pt;" runat="server" Text="Add Roster" OnClick="roster_button_Click" />
    </div>
        
    <!-- welcome label -->
    <div class="box" style="text-align:center;">
        <asp:Label ID="welcome_label" runat="server" style="display:flex; flex-direction:column; justify-content:center; color: #fff; font-size: 26pt; margin-right:1%;" Text="Welcome"></asp:Label>
    </div>
    
    <br />
    <br />

    <!-- script manager & update panel -->
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <!-- COURSES DROP DOWN LIST - instructor must select a course to view tasks -->
                <div class="box" style="text-align:center; display:flex; flex-direction:column; justify-content:center; margin-left:1%;">
                    <asp:DropDownList ID="course_ddlist" runat="server" OnDataBound="add_item" OnSelectedIndexChanged="course_ddlist_SelectedIndexChanged" DataSourceId="SqlDataSource1" class="ddlist" DataValueField="courseId" DataTextField="courseName" AutoPostBack="True" Visible="False"></asp:DropDownList>
                </div>

                <!-- hidden for selections -->
                <asp:HiddenField ID="HiddenField1" runat="server" />

                <!-- sql data source for DDL -->
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AttendanceConnectionString %>" SelectCommand="get_coursesteach" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField1" Name="instructorId" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <br />
                <br />

                <!-- TASK BUTTONS - instructor must select a task to continue -->
                <div class="box">
                    <asp:Label ID="task_label" runat="server" class="select" Text="Select A Task" Visible="False"></asp:Label>
                </div>
                
                <br />
                <br />
                <br />
                <br />

                <div class="box_row">
                    <!-- collect button -->
                    <div class="box_row">
                        <asp:Button ID="collect_button" class="btns grow" style="background-color:#393333;" runat="server" Text="Collect" Visible="False" OnClick="collect_button_Click" />
                    </div>
                    <!-- update button -->
                    <div class="box_row">
                        <asp:Button ID="update_button" class="btns grow" style="background-color:#393333; "  runat="server" Text="Update" Visible="False" OnClick="update_button_Click" />
                    </div>
                    <!-- review button -->
                    <div class="box_row">
                        <asp:Button ID="review_button" class="btns grow" style="background-color:#393333; "  runat="server" Text="Review" Visible="False" OnClick="review_button_Click" />
                    </div>
                </div>

            </ContentTemplate>

            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="course_ddlist" />
            </Triggers>
        </asp:UpdatePanel>


    </form>
</body>
</html>
