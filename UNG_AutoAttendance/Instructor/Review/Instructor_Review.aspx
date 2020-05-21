<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Instructor_Review.aspx.cs" Inherits="UNG_AutoAttendance.Instructor.Review.Instructor_Review" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset ="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link href="../../Styling/Review_Style.css" rel="stylesheet" />
    <title>Instructor Review Attendance</title>
</head>

<body>

    <!-- TOP HEADER -->
    <h1 class="top"></h1>

    <!-- LOGO -->
    <div class="logo img">
        <img src="https://ung.edu//_uploads/images/template/2015/logo-large.png" />
        <img src="https://ung.edu//_uploads/images/template/2015/logo-large-bottom.png" />
    </div>

    <form id="form1" runat="server">

        <!-- logout button -->
    <div class="loutbtn"  style="font-size:14pt; position:absolute; top:25px; left: 1px; margin: 10px 410% 10px 90%; ">
        <asp:Button ID="logout_button" style="font-size:14pt;" class="loutbtn" runat="server" Text="Sign Out" OnClick="logout_button_Click" />
    </div>

    <!-- change selection button -->
    <div class="rtrnbtn" style="font-size:14pt; position:absolute; top:25px; left: 1px; margin: 10px 410% 10px 75%; ">
        <asp:Button ID="return_button" style="font-size:14pt;" Class="rtrnbtn" runat="server" Text="Change Selection" OnClick="return_button_Click" />
    </div>

    <!-- review label -->
    <div class="box">
        <asp:Label ID="review_label" class="select" style="color:white; font-size: 16pt; margin-top: -1%; " runat="server" Text="Select an option"></asp:Label>
    </div>

    <!-- big buttons -->
    <div class="rowbox">
        <div class="rowbox">
            <asp:Button ID="sortAttendance_button" class="btns grow" style="background-color: #393333; " runat="server" Text="Overall Report" OnClick="sortAttendance_button_Click" />
            <asp:Button ID="sortStudents_button" class="btns grow" style="background-color: #393333; " runat="server" Text="Student Totals" OnClick="sortStudents_button_Click" />
            <!-- date totals button --> <!-- most absent button --> <!-- students with perfect attend -->   <!-- date totals -->
        </div>

        <div class="rowbox">
            <asp:Button ID="sortDates_button" visible="false" class="btns grow" style="background-color: #393333; " runat="server" Text="Specific Date" OnClick="sortDates_button_Click" />
            <asp:Button ID="build_button" visible="false" runat="server" class="btns grow" style="background-color: #393333; " Text="Build Report" OnClick="build_button_Click" />
        </div>
        <br />
        <div class="box">
            <asp:Label ID="totmeetings_label" class="box" style="color:white; font-size:12pt;" runat="server" Text=""></asp:Label>
        </div>
    </div>


        <!-- script manager... -->
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <!-- ****** SET TO NOT VISIBLE ATM****** -->
                <!-- gridview -->
                <div class="grid-container" style="display:flex; justify-content:center; flex-direction:column; align-items:center;">
                    <div class="grid-item" style="align-content:center; align-self:center; text-align: center;">
                        <asp:GridView ID="GridView1" class="mygrid" Visible="false" HeaderStyle-CssClass="gridheader" RowStyle-CssClass="gridrows" PagerStyle-CssClass="pager" CellSpacing="1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="Student ID" HeaderText="Student ID" SortExpression="Student ID" />
                                <asp:BoundField DataField="Student Name" HeaderText="Student Name" ReadOnly="True" SortExpression="Student Name" />
                                <asp:BoundField DataField="Attendance" HeaderText="Attendance" SortExpression="Attendance" />
                                <asp:BoundField DataField="Class Date" HeaderText="Class Date" ReadOnly="True" SortExpression="Class Date" />
                            </Columns>
                            <HeaderStyle CssClass="gridheader" />
                            <PagerStyle CssClass="pager" />
                            <RowStyle CssClass="gridrows" />
                        </asp:GridView>
                    </div>
                </div>

                <!-- sql data source -->
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AttendanceConnectionString %>" SelectCommand="get_overview" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField1" DefaultValue="" Name="courseId" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <!-- hidden control holding course id -->
                <asp:HiddenField ID="HiddenField1" runat="server" />

                <!-- sql data source 2 -->
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AttendanceConnectionString %>" SelectCommand="ireview" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField1" Name="courseId" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
                <!-- gridview 2 -->
                 <div class="grid-container" style="display:flex; justify-content:center; flex-direction:column; align-items:center;">
                    <div class="grid-item" style="align-content:center; align-self:center; text-align: center;">
                        <asp:GridView ID="GridView2" class="mygrid" Visible="true" HeaderStyle-CssClass="gridheader" RowStyle-CssClass="gridrows" PagerStyle-CssClass="pager" CellSpacing="1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" EmptyDataText="This course has no attendance records" PageSize="11">
                            <Columns>
                                <asp:BoundField DataField="Class Date" HeaderText="Class Date" ReadOnly="True" SortExpression="Class Date" />
                                <asp:BoundField DataField="Student Name" HeaderText="Student Name" ReadOnly="True" SortExpression="Student Name" />
                                <asp:BoundField DataField="Attendance" HeaderText="Attendance" SortExpression="Attendance" />
                            </Columns>
                            <HeaderStyle CssClass="gridheader" />
                            <PagerStyle CssClass="pager" />
                            <RowStyle CssClass="gridrows" />
                        </asp:GridView>
                    </div>
                </div>

                <!-- gridview 3 & 4 -->
                <div class="grid-container" style="display:flex; justify-content:center; flex-direction:column; align-items:center;">
                    <div class="grid-item" style="align-content:center; align-self:center; text-align: center;">
                        <asp:GridView ID="GridView3" Visible="false" class="mygrid" HeaderStyle-CssClass="gridheader" RowStyle-CssClass="gridrows" PagerStyle-CssClass="pager" CellSpacing="1" runat="server" DataSourceID="SqlDataSource3" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="Student Name" HeaderText="Student Name" ReadOnly="True" SortExpression="Student Name" />
                                <asp:BoundField DataField="Total Classes Absent" HeaderText="Total Classes Absent" ReadOnly="True" SortExpression="Total Classes Absent" />
                                <asp:BoundField DataField="Total Classes Present" HeaderText="Total Classes Present" ReadOnly="True" SortExpression="Total Classes Present" />
                            </Columns>
                            <HeaderStyle CssClass="gridheader" />
                            <PagerStyle CssClass="pager" />
                            <RowStyle CssClass="gridrows" />
                        </asp:GridView>&nbsp
                        <asp:GridView ID="GridView4" class="mygrid" HeaderStyle-CssClass="gridheader" RowStyle-CssClass="gridrows" PagerStyle-CssClass="pager" CellSpacing="1" runat="server" AutoGenerateColumns="False">
                            <HeaderStyle CssClass="gridheader" />
                            <PagerStyle CssClass="pager" />
                            <RowStyle CssClass="gridrows" />
                        </asp:GridView>
                    </div>
                </div>

                <!-- sql data source 3 -->
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:AttendanceConnectionString %>" SelectCommand="absent_present_totals" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField1" Name="courseId" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <!-- sqld data source 4 -->

            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="sortAttendance_button" />
                <asp:AsyncPostBackTrigger ControlID="sortStudents_button" />
            </Triggers>
        </asp:UpdatePanel>




    </form>
</body>
</html>
