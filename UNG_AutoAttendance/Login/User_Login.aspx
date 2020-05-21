<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User_Login.aspx.cs" Inherits="UNG_AutoAttendance.Login.User_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset ="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link href="../Styling/Login_Style.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <title>Attendance Sign In</title>
</head>

<body>
    <!-- TOP HEADER - tan bg color row -->
    <h1 class ="top"></h1>

    <!-- LOGO - image & blue bg color row -->
    <div style="background-color: #012560;">
        <div class="logo img" >
            <img src="https://ung.edu//_uploads/images/template/2015/logo-large.png" />
            <img src="https://ung.edu//_uploads/images/template/2015/logo-large-bottom.png" />
        </div>
        <div style="position:center;">
            <h1 style="text-align:center; margin-right: 350px; color:#fff;"></h1>
        </div>
    </div>

    <form id="form1" runat="server">

    
    <div class="box" style="text-align:center;">
        <h1 class="boxhead">Sign In</h1>

        <div class="inner">
            <asp:TextBox ID="uname_textbox" class="mytb" placeholder="Enter Username" runat="server" AutoCompleteType="Disabled"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" class="animated fadeOut" style="color: darkred; font-weight: 600;" runat="server"  ErrorMessage="Required" ControlToValidate="uname_textbox" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        
        <div class="inner">
            <asp:TextBox ID="pword_textbox" class="mytb2"  placeholder="Enter Password" runat="server" AutoCompleteType="Disabled" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" class="animated fadeOut" style="color: darkred; font-weight: 600;" runat="server" ErrorMessage="Required" ControlToValidate="pword_textbox" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        <br />
        <div class="bbox" >
            <div class="entering" style="padding: 0px 0px 0px 0px;">
                <asp:Button ID="login_button" style="background-color: #393333; font-size: 14pt;" class="entering" runat="server" Text="Enter" OnClick="login_button_Click" />
            </div>
        </div>
    </div>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div style="display:flex; justify-content:center; flex-direction:column; text-align:center;">
                    <asp:Label ID="error_label" class="animated fadeOut" Visible="false" runat="server" Text="" style="margin: -12% 10% 10% 10%; position:center; font-family:'Lucida Sans Unicode'; color: darkred; font-weight:700; font-size: 16pt; font-variant: small-caps;"></asp:Label>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="login_button" />
            </Triggers>
        </asp:UpdatePanel>
    
    <div style="text-align:center; color: rgba(255, 255, 255, 0.4); position:fixed; left: 0; bottom: 0; width: 100%;  background-color:#012560;">
        <footer>J.Todd - CIS 4950 - UNG - Spring 2018</footer>
    </div>
    
    </form>
</body>
</html>
