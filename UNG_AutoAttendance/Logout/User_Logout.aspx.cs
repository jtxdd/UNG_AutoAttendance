using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace UNG_AutoAttendance.Logout
{
    public partial class User_Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //create item to refresh log out & redirect to log in
            HtmlMeta meta = new HtmlMeta();
            meta.HttpEquiv = "Refresh";
            meta.Content = "5; url=/Login/User_Login.aspx";
            this.Page.Controls.Add(meta);
        }
    }
}