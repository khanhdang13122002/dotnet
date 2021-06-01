using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using quanlysinhvien.Models.DAO;
using quanlysinhvien.Models.EF;
using quanlysinhvien.DTO.UIAuth;

namespace quanlysinhvien.DTO.UIMannager
{
    public partial class UCAdd : UserControl
    {
        public UCAdd()
        {
            InitializeComponent();
        }

        private void guna2CirclePictureBox1_Click(object sender, EventArgs e)
        {
                
           
            try
            {
                ofdlAvatar.ShowDialog();
                string filePath = null;
                filePath = ofdlAvatar.FileName;
                pcAvatar.Image = Image.FromFile(filePath);

            }
            catch(Exception ex)
            {
                frmMessageBox smb = new frmMessageBox();
                smb.Show_("No Image selected");
                smb.ShowDialog();
            }

        }

       
        private void btnAddSv_Click(object sender, EventArgs e)
        {
            SinhVienDAO svDao = new SinhVienDAO();
            string maSv = txtMaSv.Text.Trim();
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
            string malop = txtMaLop.Text.Trim();
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
            
            if (maSv.Equals("") || hoTen.Equals("") || malop.Equals("")){

                txtMaSv.Focus();
                if (hoTen.Equals(""))
                {
                    txtHoTen.Focus();
                }
                if (malop.Equals(""))
                {
                    txtMaLop.Focus();
                }
            }
            else
            {
                SinhVienDAO svdao = new SinhVienDAO();
                string[] data = { maSv, hoTen, queQuan, ngaySinh, gioiTinh, diaChi, email, sdt, malop };
                
                string checkAdd = svDao.addStudent(data,avatar);
                frmMessageBox  msb = new frmMessageBox();
                if (checkAdd.Equals("Them Thanh Cong"))
                {
                    msb.Show_(checkAdd);
                    msb.ShowDialog();
                    clear();

                }
                else
                {
                    msb.Show_(checkAdd);
                    msb.ShowDialog();
                }
                
            }
            
        }
        public Image resize(Image img,int w,int h)
        {
            Bitmap bpm = new Bitmap(w, h);
            Graphics g = Graphics.FromImage(bpm);
            g.DrawImage(img,0,0 ,w, h);
            g.Dispose();
            return bpm;
        }
        public bool clear()
        {
            txtMaLop.Text = "";
            txtDiaChi.Text = "";
            txtHoTen.Text = "";
            txtQueQuan.Text = "";
            txtSDT.Text = "";
            txtMaSv.Text = "";
            txtEmail.Text = "";
            return true;
       }
       
        

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }
    }
}
