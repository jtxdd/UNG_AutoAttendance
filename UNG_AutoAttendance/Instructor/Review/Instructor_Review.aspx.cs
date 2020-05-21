using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace UNG_AutoAttendance.Instructor.Review
{
    public partial class Instructor_Review : System.Web.UI.Page
    {
        string courseid;
        int totalmeetings;

        protected void Page_Load(object sender, EventArgs e)
        {
            //pass session variable
            courseid = (string)Session["ss_courseid"];
            HiddenField1.Value = (string)Session["ss_courseid"];
            
            //on first loading
            if (!IsPostBack)
            {
                //db access
                string cncn = ConfigurationManager.ConnectionStrings["hookup"].ConnectionString;
                using (SqlConnection dbhookup = new SqlConnection(cncn))
                {
                    dbhookup.Open();
                    //execute stored procedure: "change_attendance"
                    using (SqlCommand cmd = new SqlCommand("select count(distinct meetDate) as \"Total Class Dates\" from meeting where courseId = @courseId", dbhookup))
                    {
                        cmd.CommandType = CommandType.Text;
                        //parameters to pass: course from selections; selected student & date for updating to present;
                        cmd.Parameters.AddWithValue("@courseId", HiddenField1.Value);
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                //assign db results
                                totalmeetings = reader.GetInt32(0);
                                totmeetings_label.Text = "Total Class Meetings: " + totalmeetings.ToString();
                            }
                        }
                    }
                }
            }
            else if (IsPostBack)
            {
                GridView2.DataBind();
            }

        }

        protected void logout_button_Click(object sender, EventArgs e)
        {
            //click log out and get redirected to logout page
            Response.Redirect("~/Logout/User_Logout.aspx");
        }          

        protected void return_button_Click(object sender, EventArgs e)
        {
            //instructor click change selection, go to main instructor page
            Response.Redirect("~/Instructor/Instructor_User.aspx");
        }           

        protected void sortDates_button_Click(object sender, EventArgs e)           //REPORT BY DATES
        {

        }

        protected void sortStudents_button_Click(object sender, EventArgs e)        //REPORT BY STUDENTS
        {
            GridView2.Visible = false;
            GridView3.Visible = true;
            GridView3.DataBind();
        }

        protected void sortAttendance_button_Click(object sender, EventArgs e)      //REPORT BY ATTENDANCE
        {
            //GridView1.Visible = true;
            //GridView1.DataBind();
            GridView2.DataBind();
            GridView2.Visible = true;
            GridView3.Visible = false;

        }

        protected void build_button_Click(object sender, EventArgs e)               //CUSTOM REPORT
        {

        }
    }
}