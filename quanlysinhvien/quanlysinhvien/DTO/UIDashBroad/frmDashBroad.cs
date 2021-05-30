using quanlysinhvien.authen;
using quanlysinhvien.DTO.UIAnalytics;
using quanlysinhvien.DTO.UIDashBroad;
using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Windows.Forms;


namespace quanlysinhvien.DTO.UIAccount
{
    public partial class frmDashBroad : Form
    {
        [DllImport("Gdi32.dll", EntryPoint = "CreateRoundRectRgn")]

        private static extern IntPtr CreateRoundRectRgn
        (
              int nLeftRect,
              int nTopRect,
              int nRightRect,
              int nBottomRect,
              int nWidthEllipse,
              int nHeightEllipse

        );
        public frmDashBroad(string qs)
        {
            InitializeComponent();
            Region = System.Drawing.Region.FromHrgn(CreateRoundRectRgn(0, 0, Width, Height, 25, 25));
            UCDashboard ucDashBoard = new UCDashboard();
            this.pnlContents.Controls.Clear();
            this.pnlContents.Controls.Add(ucDashBoard);
            plnNav.Height = btnDashBoard.Height;
            plnNav.Top = btnDashBoard.Top;
            plnNav.Left = btnDashBoard.Left;
            plnNav.BackColor = Color.White;
            AddControl(qs);

        }
       
        public void AddControl(string qs)
        {
            Label lblUser = new Label();
            lblUser.AutoSize = false;
            lblUser.Font = new Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            lblUser.ForeColor = Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(156)))), ((int)(((byte)(149)))));
            lblUser.Location = new Point((pnlAccount.Width-lblUser.Width)/2, 106);
            lblUser.Name = "lblUserName";
            lblUser.TabIndex = 1;
            lblUser.Text =qs;
            lblUser.TextAlign = ContentAlignment.MiddleCenter;
            pnlAccount.Controls.Add(lblUser);
            Label lblDes = new Label();
            lblDes.AutoSize = false;
            lblDes.Font = new Font("Microsoft Sans Serif", 6.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            lblDes.ForeColor = Color.FromArgb(((int)(((byte)(158)))), ((int)(((byte)(161)))), ((int)(((byte)(178)))));
            lblDes.Top = 136;
            lblDes.Left = (pnlAccount.Width - lblDes.Width) / 2;
            lblDes.Name = "lblDes";
            lblDes.TabIndex = 2;
            lblDes.Text = "Admin";
            lblDes.TextAlign = ContentAlignment.MiddleCenter;
            pnlAccount.Controls.Add(lblDes);
        }
        private void frmAccount_Load(object sender, EventArgs e)
        {

            

        }

        private void btnDashBoard_Click(object sender, EventArgs e)
        {
            UCDashboard ucDashBoard = new UCDashboard();
            this.pnlContents.Controls.Clear();
            this.pnlContents.Controls.Add(ucDashBoard);
            plnNav.Height = btnDashBoard.Height;
            plnNav.Top = btnDashBoard.Top;
            plnNav.Left = btnDashBoard.Left;
            plnNav.BackColor = Color.White;

        }

        private void btnContactUs_Click(object sender, EventArgs e)
        {
            plnNav.Height = btnContactUs.Height;
            plnNav.Top = btnContactUs.Top;
            plnNav.Left = btnContactUs.Left;
            plnNav.BackColor = Color.White;
        }

        private void btnCalender_Click(object sender, EventArgs e)
        {
            plnNav.Height = btnCalender.Height;
            plnNav.Top = btnCalender.Top;
            plnNav.Left = btnCalender.Left;
            plnNav.BackColor = Color.White;
        }

        private void btnAnalyics_Click(object sender, EventArgs e)
        {
            UCAnalytics ucAnaly = new UCAnalytics();
            pnlContents.Controls.Clear();
            pnlContents.Controls.Add(ucAnaly);
            plnNav.Height = btnAnalyics.Height;
            plnNav.Top = btnAnalyics.Top;
            plnNav.Left = btnAnalyics.Left;
            plnNav.BackColor = Color.White;
        }

        private void btnSettings_Click(object sender, EventArgs e)
        {
            plnNav.Height = btnSettings.Height/2;
            plnNav.Top = btnSettings.Top;
            plnNav.Left = btnSettings.Left;
            plnNav.BackColor = Color.White;
        }
    }

}
