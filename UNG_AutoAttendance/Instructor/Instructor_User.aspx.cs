using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UNG_AutoAttendance.Instructor
{
    public partial class Instructor_User : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //pass session variables
            string instructorId = (string)Session["ss_id"];
            HiddenField1.Value = (string)Session["ss_id"];
            //on first loading...
            if (!IsPostBack)
            {
                //display welcome message + the users name
                welcome_label.Text = "Welcome " + (string)Session["ss_person_name"];

                //make sure the course DDL is visible
                course_ddlist.Visible = true;
            }
            //else
        }

        protected void course_ddlist_SelectedIndexChanged(object sender, EventArgs e)
        {
            //assign course selection to session variable
            Session["ss_courseid"] = course_ddlist.SelectedValue;
            
            //change control visibility-------
            course_ddlist.Visible = false;
            task_label.Visible = true;
            collect_button.Visible = true;
            update_button.Visible = true;
            review_button.Visible = true;
            //--------------------------------
        }

        protected void add_item(object sender, EventArgs e)
        {
            //for adding default DDL item - "select course" prompt
            course_ddlist.Items.Insert(0, new ListItem("--Select A Course--", "0"));    //create
            course_ddlist.Items[0].Selected = true;                                     //make it selected
            course_ddlist.Items[0].Attributes["disabled"] = "disabled";                 //disable it after focused
        }

        protected void collect_button_Click(object sender, EventArgs e)
        {
            //instructor click COLLECT task
            Response.Redirect("~/Instructor/Collect/Instructor_Collect.aspx");
        }

        protected void update_button_Click(object sender, EventArgs e)
        {
            //instructor click UPDATE task
            Response.Redirect("~/Instructor/Update/Instructor_Update.aspx");
        }

        protected void review_button_Click(object sender, EventArgs e)
        {
            //instructor click REVIEW task
            Response.Redirect("~/Instructor/Review/Instructor_Review.aspx");
        }

        protected void logout_button_Click(object sender, EventArgs e)
        {
            //logout click, go to logout page
            Response.Redirect("~/Logout/User_Logout.aspx");
        }

        protected void roster_button_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Instructor/Insert/Instructor_Insert.aspx");
        }
    }
}