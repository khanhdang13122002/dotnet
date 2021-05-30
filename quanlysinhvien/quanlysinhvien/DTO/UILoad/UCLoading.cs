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
    public partial class UCLoading : UserControl
    {
        public UCLoading()
        {
            InitializeComponent();
            cpgLoading.Value = 0;
           
        }

        private void timer1_Tick(object sender, EventArgs e)
        {

            cpgLoading.Value += 1;
            cpgLoading.Text = cpgLoading.Value.ToString() + "%";
            if (cpgLoading.Value == 100)
            {
                tmerLoading.Enabled = false;
                cpgLoading.Hide();
               
            }

        }

       
    }
}
