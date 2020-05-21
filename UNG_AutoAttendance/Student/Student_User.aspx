<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_User.aspx.cs" Inherits="UNG_AutoAttendance.Student.Student_User" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset ="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link href="../Styling/Student_Style.css" rel="stylesheet" />
    <title>Student User</title>
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

    <!-- welcome label -->
    <div class="box">
        <asp:Label ID="welcome_label" style="color: #fff; font-size: 32pt;" runat="server" Text="Welcome"></asp:Label>
    </div>

    <br />
    <br />


    <!-- sql data source getting course list -->
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AttendanceConnectionString %>" SelectCommand="get_courselist" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="studentId" SessionField="ss_id" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <!-- script manager & update panel -->
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <!-- course list DDL -->
                <div class="ddlist">
                    <asp:DropDownList ID="course_ddl" class="ddlist"  DataSourceId="SqlDataSource2" OnDataBound="add_item" DataTextField="Course" DataValueField="courseId" runat="server" OnSelectedIndexChanged="course_ddl_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                </div>
                <!-- hidden control holding course selection -->
                <asp:HiddenField ID="HiddenField1" runat="server" />
                
                <br />
                <br />

                <!-- gridview -->
                <div class="box">
                    <asp:GridView ID="GridView1" class="mygrid" HeaderStyle-CssClass="gridheader" RowStyle-CssClass="gridrows" PagerStyle-CssClass="pager" CellSpacing="1" runat="server" DataSourceID = "SqlDataSource1" AllowPaging="True" ></asp:GridView>
                </div>
                
                <!-- sql data source for student course attendance -->
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AttendanceConnectionString %>" SelectCommand="get_student_records" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="course_ddl" DefaultValue="" Name="courseId" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="HiddenField1" DefaultValue="" Name="studentId" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            
            </ContentTemplate>
            
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="course_ddl" EventName="SelectedIndexChanged" />
            </Triggers>
        
        </asp:UpdatePanel>

    </form>
</body>
</html>
