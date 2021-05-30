using quanlysinhvien.Models.DAO;
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
            dgvSinhVien.DataSource = sinhvien.GetAll();
        }
    }
}
