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
        public frmManager()
        {
            InitializeComponent();
        }

        public string create(string controlName)
        {
          return "UC" + controlName + " " + "uc" + controlName+" = "+"new"+" "+"UC"+controlName+"()"+";";
        }
        public void addControl(Control control)
        {
            pnlMannagerContent.Controls.Add(control);
        }
        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void frmManager_Load(object sender, EventArgs e)
        {

        }
    }
}
