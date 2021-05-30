using System;
using System.Drawing;
using System.Windows.Forms;

namespace quanlysinhvien.DTO.UIAuth
{
    public partial class frmMessageBox : Form
    {
        public frmMessageBox()
        {
            InitializeComponent();
        }

        private void addLabel(string content)
        {
            Label lblNofication = new Label();
            lblNofication.Text = content;
            lblNofication.Font = new System.Drawing.Font("Segoe Print", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            lblNofication.Location = new System.Drawing.Point((this.Width - lblNofication.Width) / 2, (this.Height - lblNofication.Height) / 2);
            lblNofication.ForeColor = Color.White;
            lblNofication.Width = this.Width;
            lblNofication.AutoSize = false;
            this.Controls.Add(lblNofication);

        }
        public void Show_(string content)
        {
            addLabel(content);
        }
        private void frmMessageBox_Load(object sender, EventArgs e)
        {

        }

        private void btnSuccess_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnSuccess_MouseHover(object sender, EventArgs e)
        {
            btnSuccess.BackColor = Color.Black;
        }
    }
}
