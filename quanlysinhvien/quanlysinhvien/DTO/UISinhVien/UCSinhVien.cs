﻿using quanlysinhvien.Models.DAO;
using System.Windows.Forms;

namespace quanlysinhvien.DTO.UISinhVien
{
    public partial class UCSinhVien : UserControl
    {
        public UCSinhVien()
        {
            InitializeComponent();
            loadData();
        }
        public void loadData()
        {
            SinhVienDAO sinhvien = new SinhVienDAO();
           
        }

        private void dgvSinhVien_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
