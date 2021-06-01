using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using quanlysinhvien.Models.DAO;
using quanlysinhvien.Models.EF;


namespace quanlysinhvien.DTO.UITest
{
    public partial class UCTest : UserControl
    {
        public UCTest()
        {
            InitializeComponent();
            loadData();
        }
        

        private void dgvTest_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            SinhVienDAO svDao = new SinhVienDAO();
            foreach(var item in svDao.GetMaLop())
            {
                comboBox1.Items[0] = item.MaLop;
            }
        }
        public void loadData()
        {
            
        }
    }
}
