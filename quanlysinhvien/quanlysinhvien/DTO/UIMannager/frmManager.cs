using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace quanlysinhvien.DTO.UIMannager
{
    public partial class frmManager : Form
    {
        public frmManager(Control contr)
        {
            InitializeComponent();
            addControl(contr);
        }
        
        public void addControl(Control control)
        {
            pnlMannagerContent.Controls.Clear();
;           pnlMannagerContent.Controls.Add(control);
        }
         
        private void frmManager_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void frmManager_Enter(object sender, EventArgs e)
        {
            this.Focus();
        }

        private void btnClose_Click(object sender, EventArgs e)
        {

        }

        private void guna2Button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
