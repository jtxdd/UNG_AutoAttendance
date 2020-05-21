using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace UNG_AutoAttendance.Instructor.Update
{
    public partial class Instructor_Update : System.Web.UI.Page
    {
        string courseid;
        string studentname;
        string studentid;
        int indexid;
        int status;
        DateTime meetdate;

        protected void Page_Load(object sender, EventArgs e)
        {
            //pass session variable
            courseid = (string)Session["ss_courseid"];
            HiddenField1.Value = (string)Session["ss_courseid"];
            
            //on first loading
            if (!IsPostBack)
            {
                //
            }
            else if (IsPostBack)
            {
                GridView1.DataBind();
            }

        }

        protected void logout_button_Click(object sender, EventArgs e)
        {
            //user click and get redirected to logout page
            Response.Redirect("~/Logout/User_Logout.aspx");
        }

        protected void return_button_Click(object sender, EventArgs e)
        {
            //user click and return to initial instructor form
            Response.Redirect("~/Instructor/Instructor_User.aspx");
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //get the rox index of the selected item
            indexid = GridView1.SelectedIndex;

            //get the student id to update - using the row index & column index
            studentid = Convert.ToString(GridView1.Rows[indexid].Cells[1].Text);
            studentname = Convert.ToString(GridView1.Rows[indexid].Cells[2].Text);

            //get the date to update - using the index
            meetdate = Convert.ToDateTime(GridView1.Rows[indexid].Cells[4].Text);
            
            //assign the student id to the hidden control
            HiddenField2.Value = studentid;
            
            //assign the meet date to the hidden control, convert for parameter pass format
            HiddenField3.Value = meetdate.ToString("d");

            //call the method to run the stored procedure
            update_attendance();
            //make sure new data is bound
            GridView1.DataBind();
        }

        protected void update_attendance()
        {
        
            //db access
            string cncn = ConfigurationManager.ConnectionStrings["hookup"].ConnectionString;
            using (SqlConnection dbhookup = new SqlConnection(cncn))
            {
                dbhookup.Open();
                //execute stored procedure: "change_attendance"
                using (SqlCommand cmd = new SqlCommand("change_attendance", dbhookup))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    //parameters to pass: course from selections; selected student & date for updating to present;
                    cmd.Parameters.AddWithValue("@courseId", HiddenField1.Value);
                    cmd.Parameters.AddWithValue("@studentId", HiddenField2.Value);
                    cmd.Parameters.AddWithValue("@meetDate", HiddenField3.Value);
                    //status returns int for "number of rows affected"
                    status = cmd.ExecuteNonQuery();
                    //1 = good input, good update
                    if (status == 1)
                    {
                        Label2.Text = "Updated Attendance: " + studentname + " " + "set to present for " + meetdate.ToString("D");
                    }
                    //status should never be > 1; status < 1 means nothing updated;
                    else if (status != 1)
                    {
                        Label2.Text = "Failed to update attendance, try again or contact administrator";
                    }
                }
            }
        }
    }
}