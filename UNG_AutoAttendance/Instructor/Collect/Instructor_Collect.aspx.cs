using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace UNG_AutoAttendance.Instructor.Collect
{
    public partial class Instructor_Collect : System.Web.UI.Page
    {
        string courseid, incoming_data, presentid;
        DateTime date1 = DateTime.Now;
        int status;

        protected void Page_Load(object sender, EventArgs e)
        {
            //on first loading
            if (!IsPostBack)
            {
                //assign today's date to date label with format like "Monday, April 8, 2018" - for user display
                dateof_label.Text = date1.ToString("D");

                //assign today's date to hidden control with format like "4/8/18" - for db parameter
                HiddenField2.Value = date1.ToString("d");

                //invoke create meeting method to create a new class meeting
                create_meeting();

                //set the cursor inside the input textbox
                id_textbox.Focus();
            }
            //after processing the input & returning from the db - do this
            else if (IsPostBack)
            {
                //set the cursor inside the input textbox
                id_textbox.Focus();
                //bind any data source changes to grid views to update the data displayed
                GridView1.DataBind();
                GridView2.DataBind();
            }
        }

        protected void logout_button_Click(object sender, EventArgs e)
        {
            //click the logout button, get redirected to logout form
            Response.Redirect("~/Logout/User_Logout.aspx");
        }

        protected void id_textbox_TextChanged(object sender, EventArgs e)
        {
            //CONDITION TO PROCESS 1 : a good swipe ALWAYS starts with a % sign
            if (id_textbox.Text.StartsWith("%"))
            {
                //assign the unformatted data 
                incoming_data = id_textbox.Text;

                //assign the student id - from extracting values in the unformatted data 
                presentid = incoming_data.Substring(1, 9);

                //invoke method to update attendance & pass parameter holding student id
                transmit_ID(presentid);
            }

            //CONDITION TO PROCESS 2 : a student id ALWAYS starts with a 9 && is 9 characters long
            else
            {
                //verify keys entered start with a 9 & 9 characters long
                if (id_textbox.Text.StartsWith("9") && id_textbox.Text.Length == 9)
                {
                    //assign the student id (no addt'l processing req'd)
                    presentid = id_textbox.Text;

                    //invoke method to update attendance & pass parameter holding student id
                    transmit_ID(presentid);
                }
                //input not meeting condition 1 or 2 : must be invalid - don't process - display error mssg
                else
                {
                    status_label.Text = "Poor input, try again";
                }
            }
            
        }
        public void transmit_ID(string presentid)
        {
            //pass session variable
            courseid = (string)Session["ss_courseid"];
            HiddenField1.Value = (string)Session["ss_courseid"];

            //transmit student id - use for update procedure
            SqlConnection dbhookup = new SqlConnection(ConfigurationManager.ConnectionStrings["hookup"].ConnectionString);
            dbhookup.Open();

            SqlCommand cmd = new SqlCommand("update_attendance", dbhookup);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@studentId", presentid);
            cmd.Parameters.AddWithValue("@courseId", courseid);

            //assign status to command, 1 = "1 row(s) affected" -- == successful update;
            status = cmd.ExecuteNonQuery();
            
            if (status == 2)
            {
                status_label.Text = "Recorded";
                id_textbox.Text = string.Empty;
                presentid = string.Empty;
            }
            else if (status != 2)
            {
                status_label.Text = "Something happened - try again";
                id_textbox.Text = string.Empty;
                presentid = string.Empty;
            }
        }

        public void create_meeting()
        {
            //pass session variable
            courseid = (string)Session["ss_courseid"];
            HiddenField1.Value = (string)Session["ss_courseid"];

            //call stored procedure - creates new course meet date - inserts date, course id, & student roster (attendance default = 'absent')
            string cncn = ConfigurationManager.ConnectionStrings["hookup"].ConnectionString;
            using (SqlConnection dbhookup = new SqlConnection(cncn))
            {
                dbhookup.Open();
                using (SqlCommand cmd = new SqlCommand("new_meeting", dbhookup))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@courseId", courseid);
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}