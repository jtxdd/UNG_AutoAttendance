<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Instructor_Insert.aspx.cs" Inherits="UNG_AutoAttendance.Instructor.Insert.Instructor_Insert" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title></title>
</head>

<body>

    <form id="form1" runat="server">

    <div>
        <asp:DropDownList ID="courses_ddl" runat="server"></asp:DropDownList>
        <br />
        <asp:TextBox ID="studentid_textbox" runat="server"></asp:TextBox>
        <asp:TextBox ID="studentfname_textbox" runat="server"></asp:TextBox>
    </div>

    </form>

</body>
</html>
