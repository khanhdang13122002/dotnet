using quanlysinhvien.DTO.UIAuth;
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

namespace quanlysinhvien.DTO.UIMannager
{
    public partial class UCInfor : UserControl
    {
        public UCInfor(string masv)
        {
            InitializeComponent();
            loadData(masv);
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }
        public void loadData(string masv)
        {
            SinhVienDAO svDao = new SinhVienDAO();
            List<SinhVien> infor = svDao.getInfor(masv);
            foreach (var item in infor)
            {
                lblMaSv.Text = item.MaSV;
                lblDiaChi.Text = item.DiaChi;
                lblEmail.Text = item.EMail;
                lblHoTen.Text = item.HoTen;
                lblMaLop.Text = item.MaLop;
                lblQueQuan.Text = item.QueQuan;
                if (item.GioiTinh == true)
                {
                    rbtnNam.Checked = true;
                }
                else
                {
                    rbtnNu.Checked = true;
                }
                lblNgaySinh.Text = item.NgaySinh.ToString();
                if (item.Pic != null)
                {
                    pcAvatar.Image = (Bitmap)((new ImageConverter()).ConvertFrom(item.Pic));
                }

            }

        }

        private void btnChange_Click(object sender, EventArgs e)
        {

            string msv = lblMaSv.Text.Trim();
            if (msv != null)
            {
                UCUpdate ucUp = new UCUpdate(msv);
                frmManager frm = new frmManager(ucUp);
                frm.ShowDialog();
            }
            else
            {
                frmMessageBox msb = new frmMessageBox();
                msb.Show_("Sinh Vien Khong Ton tai");
                msb.ShowDialog();
            }
           

        }

        private void btnRemove_Click(object sender, EventArgs e)
        {
            SinhVienDAO svdao = new SinhVienDAO();
            if(MessageBox.Show("Ban That Su Muon Xoa?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) == DialogResult.Yes)
            {
                svdao.remove(lblMaSv.Text.Trim());
                
            }
        }
    }
}
