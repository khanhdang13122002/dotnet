using System;
using System.Windows.Forms;
using quanlysinhvien.authen;
using quanlysinhvien.DTO.UIAuth;
using quanlysinhvien.Models.DAO;
using quanlysinhvien.Models.EF;


namespace quanlysinhvien
{
    public partial class frmResigter : Form
    {
        public frmResigter()
        {
            InitializeComponent();

        }


        private void resigter_Load(object sender, EventArgs e)
        {

        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void lblCreated_Click(object sender, EventArgs e)
        {
            frmLogin login = new frmLogin();
            login.Show();
            this.Close();

        }

        private void btnRegsiter_Click(object sender, EventArgs e)
        {

            Authen Au = new Authen();
            frmLogin login = new frmLogin();
            string user_ = txtUsername.Text.Trim();
            string pass_ = txtPassword.Text.Trim();
            string comf_pass = txtComfirmPassword.Text.Trim();
            if (user_ == "" || pass_ == "" || comf_pass == "")
            {
                txtUsername.Focus();
                if (pass_ == "")
                {
                    txtPassword.Focus();
                }
                if (comf_pass == "")
                {
                    txtComfirmPassword.Focus();
                }
            }
            else
            {
                frmMessageBox msb = new frmMessageBox();
                bool checkRes = Au.checkRes(user_, pass_, comf_pass);
                if (checkRes)
                {
                    msb.Show_("SignIn Success");
                    msb.ShowDialog();
                    frmLogin Login = new frmLogin();
                    this.Close();
                    login.Show();
                    login.txtUsername.Text = user_;
                    login.txtPassword.Text = pass_;
                    login.Activate();
                    

                }
                else
                {
                    msb.Show_("SignIn Failed");
                    msb.ShowDialog();


                }
            }
        }

        private void ttCheckUser_Popup(object sender, PopupEventArgs e)
        {

        }

        private void txtUsername_TextChanged(object sender, EventArgs e)
        {
           
        }

        private void ttCheckUser_Draw(object sender, DrawToolTipEventArgs e)
        {

        }
    }
}
