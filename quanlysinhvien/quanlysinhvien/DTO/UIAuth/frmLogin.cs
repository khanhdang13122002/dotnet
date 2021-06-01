using quanlysinhvien.authen;
using quanlysinhvien.DTO.UIAccount;
using quanlysinhvien.DTO.UIAuth;
using quanlysinhvien.DTO.UILoad;
using quanlysinhvien.DTO.UITest;
using System;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace quanlysinhvien
{
    public partial class frmLogin : Form
    {
        public frmLogin()
        {
            InitializeComponent();
        }

        private void lblCreated_Click(object sender, EventArgs e)
        {
            frmResigter res = new frmResigter();
            res.Show();
        }


        private void btnExit_Click_1(object sender, EventArgs e)
        {
            Application.Exit();
        }

        public string getUser()
        {
            return this.txtUsername.Text.Trim();
        }

        public void showLoading()
        {
            frmLoad loading = new frmLoad();
            loading.tmerLoading.Interval =2;
            loading.ShowDialog();
        }

       
        public void Login()
        {
           
            string user_ = txtUsername.Text.Trim();
            string pass_ = txtPassword.Text.Trim();
            if (user_ == "" || pass_ == "")
            {
                this.txtUsername.Focus();
                if (pass_ == "")
                {
                    this.txtPassword.Focus();

                }
            }
            else
            {
                Thread thr = new Thread(showLoading);
                thr.Start();
                Authen Auth = new Authen();
                bool Au = Auth.checkLogin(user_, pass_);
                if (Au)
                {
                    thr.Abort();
                    frmDashBroad dashbroad = new frmDashBroad(txtUsername.Text);
                    this.Hide();
                    dashbroad.Activate();
                    dashbroad.ShowDialog();
                }
                else
                {
                    thr.Abort();
                    frmMessageBox msbLogin = new frmMessageBox();
                    msbLogin.Show_("Login failed");
                    msbLogin.ShowDialog();
                    this.txtPassword.Clear();
                    this.txtUsername.Clear();
                    this.txtUsername.Focus();
                }

            }

        }
        public void btnLogin_Click_1(object sender, EventArgs e)
        {

            Login();

        }

    /*    private async Task ImportAsync()
        {
            UCLoading loading = new UCLoading();
            this.Controls.Add(loading);
            await Task.Run(() =>
            {
                Login();
            });
            this.Controls.Remove(loading);
        }
*/
        private void frmLogin_Shown(object sender, EventArgs e)
        {
            this.txtUsername.Focus();

        }

        private void frmLogin_Load(object sender, EventArgs e)
        {

        }
    }
}
