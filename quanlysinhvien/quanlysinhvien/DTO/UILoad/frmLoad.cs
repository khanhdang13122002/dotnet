using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace quanlysinhvien.DTO.UILoad
{
    public partial class frmLoad : Form
    {
        public frmLoad()
        {
            InitializeComponent();
            this.Opacity = 50;
            cpbLoading.Value = 0;
            cpbLoading.Location = new Point((this.Width - cpbLoading.Width) / 2, (this.Height - cpbLoading.Height) / 2);
           
        }

        private void frmLogin_Load(object sender, EventArgs e)
        {
           
        }
      

        private void tmerLoading_Tick(object sender, EventArgs e)
        {
            cpbLoading.Value += 1;
            cpbLoading.Text = cpbLoading.Value.ToString() + "%";
            if (cpbLoading.Value == 100)
            {
                tmerLoading.Enabled = false;
                this.Close();

            }
        }
    }
}
