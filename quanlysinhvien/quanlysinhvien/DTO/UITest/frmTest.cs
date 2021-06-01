using quanlysinhvien.DTO.UILoad;
using quanlysinhvien.Models.DAO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace quanlysinhvien.DTO.UITest
{
    public partial class frmTest : Form
    {
        public frmTest()
        {
            InitializeComponent();
            SinhVienDAO svdao = new SinhVienDAO();
            var result = svdao.GetMaLop();
            int size = result.Count;
            string[] test = new string[size];

            for (int i = 0; i < result.Count; i++)
            {
                test[i] = result[i].MaLop.ToString();
            }
            guna2ComboBox1.DataSource = test;
        }

        public void addControl()
        {
            UCLoading ucLoading = new UCLoading();
            this.Controls.Add(ucLoading);
        }
        private void frmTest_Load(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
