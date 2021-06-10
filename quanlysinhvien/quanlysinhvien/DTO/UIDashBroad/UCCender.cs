using quanlysinhvien.Models.DAO;
using quanlysinhvien.Models.EF;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace quanlysinhvien.DTO.UIDashBroad
{
    public partial class UCCender : UserControl
    {
        public UCCender()
        {
            InitializeComponent();
            LoadData();
        }
        public void LoadData()
        {
            LichSuDao ls = new LichSuDao();
            dgvLichSu.DataSource = ls.getAll();
        }
        private void dgvLichSu_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
