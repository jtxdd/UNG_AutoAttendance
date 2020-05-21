using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UNG_AutoAttendance.Student
{
    public partial class Student_User : System.Web.UI.Page
    {
        string studentId;

        protected void Page_Load(object sender, EventArgs e)
        {
            //pass session variables
            studentId = (string)Session["ss_id"];
            HiddenField1.Value = (string)Session["ss_id"];

            //first page load
            if (!IsPostBack)
            {
                //assign session name to label
                welcome_label.Text = "Welcome " + (string)Session["ss_person_name"];
            }
            //returning from db
            else if (IsPostBack)
            {
                //make the gridview visible and bind the data
                GridView1.Visible = true;
                GridView1.DataBind();
            }
        }

        protected void add_item (object sender, EventArgs e)
        {
            //add a default item to the drop down list when binding the course list data
            course_ddl.Items.Insert(0, new ListItem("--Select A Course--", "0"));
            course_ddl.Items[0].Selected = true;
            course_ddl.Items[0].Attributes["disabled"] = "disabled";
        }

        protected void logout_button_Click(object sender, EventArgs e)
        {
            //click logout button, get redirected to logout page
            Response.Redirect("~/Logout/User_Logout.aspx");
        }

        protected void course_ddl_SelectedIndexChanged(object sender, EventArgs e)
        {
            //assign the selected course data values to the gridview & show the grid
            GridView1.DataBind();
            GridView1.Visible = true;
        }
    }
}