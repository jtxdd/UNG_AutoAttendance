using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace UNG_AutoAttendance.Login
{
    public partial class User_Login : System.Web.UI.Page
    {
        string userType, id, person_name;
        int userId;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login_button_Click(object sender, EventArgs e)
        {

            //db access: execute get_user procedure; return userType, userId;
            SqlConnection dbhookup = new SqlConnection(ConfigurationManager.ConnectionStrings["hookup"].ConnectionString);
            dbhookup.Open();

            //execute stored procedure: "get_user"
            SqlCommand cmd = new SqlCommand("get_user", dbhookup);
            cmd.CommandType = CommandType.StoredProcedure;
            //parameters to pass: username input & password input
            cmd.Parameters.AddWithValue("@uname", uname_textbox.Text);
            cmd.Parameters.AddWithValue("@pword", pword_textbox.Text);
            //run it
            SqlDataReader reader = cmd.ExecuteReader();

            //rows = user found 
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    //assign db results
                    userId = reader.GetInt32(0);
                    userType = reader.GetString(1);
                    id = reader.GetString(2);
                    person_name = reader.GetString(3);
                }
                reader.Close();
            }
            //no rows = user not found
            else if (!reader.HasRows)
            {
                error_label.Visible = true;
                error_label.Text = "User Not Found";
            }
            
            //assign session variables
            Session["ss_userId"] = userId;
            Session["ss_id"] = id;
            Session["ss_person_name"] = person_name;
            
            //returned user type determines redirection: "s" = student; "i" = instructor;
            if (userType == "i")
            {
                Response.Redirect("~/Instructor/Instructor_User.aspx");
            }
            else if (userType == "s")
            {
                Response.Redirect("~/Student/Student_User.aspx");
            }
        }



    }
}