using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UNG_AutoAttendance
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public override void ProcessRequest(HttpContext context)
        {
            context.Response.Redirect("~/Login/User_Login.aspx", true);
        }
    }
}