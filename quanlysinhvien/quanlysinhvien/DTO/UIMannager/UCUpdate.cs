using quanlysinhvien.DTO.UIAnalytics;
using quanlysinhvien.DTO.UIAuth;
using quanlysinhvien.Models.DAO;
using quanlysinhvien.Models.EF;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace quanlysinhvien.DTO.UIMannager
{
    public partial class UCUpdate : UserControl
    {
        public UCUpdate(string masv)
        {
            InitializeComponent();
            loadData(masv);
        }

        public void loadData(string masv)
        {
            SinhVienDAO svDao = new SinhVienDAO();
            List<SinhVien> infor= svDao.getInfor(masv);
            foreach (var item in infor)
            {
                lblMaSv.Text = item.MaSV;
                txtDiaChi.Text = item.DiaChi;
                txtEmail.Text = item.EMail;
                txtHoTen.Text = item.HoTen;
                txtMaLop.Text = item.MaLop;
                txtQueQuan.Text = item.QueQuan;
                if (item.GioiTinh == true)
                {
                    rbtnNam.Checked = true;
                }
                else
                {
                    rbtnNu.Checked = true;
                }
                if (item.NgaySinh!=null)
                {
                    dtpNgaySinh.Value = (DateTime)item.NgaySinh;
                }
                pcAvatar.Image = ByteArrayToImage(item.Pic);

            }

        }
        
        byte[] ConvertImage(Image img)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                img.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                return ms.ToArray();
            }

        }
        public void updated()
        {
            SinhVienDAO svDao = new SinhVienDAO();
            string maSv = lblMaSv.Text.Trim();
            string hoTen = txtHoTen.Text.Trim();
            string queQuan = txtQueQuan.Text.Trim();
            string ngaySinh = dtpNgaySinh.Value.ToString().Trim();
            string gioiTinh = "";
            foreach (RadioButton item in pnlGioiTinh.Controls)
            {
                if (item.Checked == true)
                {
                    gioiTinh = item.Text;
                }
            }

            string diaChi = txtDiaChi.Text.Trim();
            string email = txtEmail.Text.Trim();
            string sdt = txtSDT.Text.Trim();
            string maLop = txtMaLop.Text.Trim();
            Image avatar =resize(pcAvatar.Image,30,30);
            if (ngaySinh.Equals(""))
            {
                ngaySinh = null;

            }
            if (diaChi.Equals(""))
            {
                diaChi = null;
            }
            if (email.Equals(""))
            {
                email = null;
            }

            if (sdt.Equals(""))
            {
                sdt = null;
            }
            if (queQuan.Equals(""))
            {
                queQuan = null;
            }

            if (gioiTinh.Equals(""))
            {
                gioiTinh = null;
            }

            if (hoTen.Equals("") || maLop.Equals(""))
            {

                if (hoTen.Equals(""))
                {
                    txtHoTen.Focus();
                }
                if (maLop.Equals(""))
                {
                    txtMaLop.Focus();
                }
            }
            else
            {
                frmMessageBox msb = new frmMessageBox();
                string[] data = { maSv, hoTen, queQuan, ngaySinh, gioiTinh, diaChi, email, sdt, maLop };
                string checkUpdate = svDao.updated(data,avatar);
                if (checkUpdate == "Sua Thanh Cong")
                {
                    msb.Show_(checkUpdate);
                    msb.ShowDialog();

                }
                else
                {
                    msb.Show_(checkUpdate);
                    msb.ShowDialog();
                }


            }
        }
       
        private void btnUpdate_Click(object sender, EventArgs e)
        {
            updated();
        }
        public Image ByteArrayToImage(byte[] byteArr)
        {
            if (byteArr != null)
            {
                using (MemoryStream ms = new MemoryStream(byteArr))
                {
                    Image img = Image.FromStream(ms);
                    return img;
                }
            }
            else
            {
                return null;
            }

        }
        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void pcAvatar_Click(object sender, EventArgs e)
        {
            try
            {
                ofdlAvatar.ShowDialog();
                string filePath = null;
                filePath = ofdlAvatar.FileName;
                pcAvatar.Image = Image.FromFile(filePath);

            }
            catch (Exception ex)
            {
                frmMessageBox smb = new frmMessageBox();
                smb.Show_("No Image selected");
                smb.ShowDialog();
            }
        }
        public Image resize(Image img, int w, int h)
        {
            Bitmap bpm = new Bitmap(w, h);
            Graphics g = Graphics.FromImage(bpm);
            g.DrawImage(img, 0, 0, w, h);
            g.Dispose();
            return bpm;
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }
    }
}
