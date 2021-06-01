using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using quanlysinhvien.DTO.UILoad;
using quanlysinhvien.Models.DAO;
using quanlysinhvien.Models.EF;
using quanlysinhvien.DTO.UIMannager;
using quanlysinhvien.DTO.UIAuth;
using quanlysinhvien.DTO.UIAccount;

namespace quanlysinhvien.DTO.UIAnalytics
{
    public partial class UCAnalytics : UserControl
    {
        public SinhVienDAO svdao = new SinhVienDAO();
        UCAdd ucAdd = new UCAdd();
        frmMessageBox msb = new frmMessageBox();

        public UCAnalytics()
        {
            InitializeComponent();
            TheardLoad();

        }
        void loading()
        {
            frmLoad load = new frmLoad();
            load.tmerLoading.Interval = 4;
            load.cpbLoading.AnimationSpeed = 10;
            load.ShowDialog();

        }
        void TheardLoad()
        {   
            Thread thr = new Thread(loading);
            thr.IsBackground = true;
            thr.Start();
            //loading animate display
            loadData();
            //load data
            thr.Abort();
            //loading animate of


        }
        public void loadData()//load data fuc
        {

         SinhVienDAO svdao = new SinhVienDAO();
        dgvListSinhVien.DataSource = this.svdao.getAll();

        }


        private void btnClose_Click(object sender, EventArgs e)
        {//exit app
            Application.Exit();
        }

        private void sinhVienBindingSource_CurrentChanged(object sender, EventArgs e)
        {

        }

        private void txtSearch_MouseClick(object sender, MouseEventArgs e)
        {
            txtSearch.Text = "";
        }

        private void txtSearch_Leave(object sender, EventArgs e)
        {
            txtSearch.Text = "  Search for something...";
        }

        private void UCAnalytics_Load(object sender, EventArgs e)
        {

        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            frmManager frmManager = new frmManager(ucAdd);
            frmManager.ShowDialog();

        }

        private void dgvListSinhVien_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void sinhVienBindingSource_CurrentChanged_1(object sender, EventArgs e)
        {

        }

        private void dgvListSinhVien_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {
            string masv = dgvListSinhVien.Rows[e.RowIndex].Cells[0].Value.ToString();
            
            MessageBox.Show(masv);
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            string masv = dgvListSinhVien.CurrentRow.Cells[0].Value.ToString();
            UCUpdate ucUpdate = new UCUpdate(masv);
            frmManager frm = new frmManager(ucUpdate);
            frm.ShowDialog();
        }

        private void dgvListSinhVien_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            string masv = dgvListSinhVien.CurrentRow.Cells[0].Value.ToString();
            UCUpdate ucUpdate = new UCUpdate(masv);
            frmManager frm = new frmManager(ucUpdate);
            frm.ShowDialog();
           
        }

        private void dgvListSinhVien_DataMemberChanged(object sender, EventArgs e)
        {
            dgvListSinhVien.Update();
            dgvListSinhVien.Refresh();
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            SinhVienDAO svdao = new SinhVienDAO();
            dgvListSinhVien.DataSource = svdao.getAll();
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Ban that su muon xoa?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) == DialogResult.Yes) {
                string masv = dgvListSinhVien.CurrentRow.Cells[0].Value.ToString();
                bool remove_ = svdao.remove(masv);
                if (remove_)
                {
                    msb.Show_("Xoa Thanh Cong");
                    msb.ShowDialog();
                }
            }
        }

        private void btnInfor_Click(object sender, EventArgs e)
        {
            string masv = dgvListSinhVien.CurrentRow.Cells[0].Value.ToString();

            UCInfor ucIn = new UCInfor(masv);
            frmManager frm = new frmManager(ucIn);
            frm.ShowDialog();
        }

        private void dgvListSinhVien_CellContentClick_2(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void txtSearch_TextChanged(object sender, EventArgs e)
        {
            SinhVienDAO svDao = new SinhVienDAO();
            string key = txtSearch.Text.Trim();
            if(!key.Contains("Search for something..."))
            {
                dgvListSinhVien.DataSource = svDao.searchByKey(key);

            }


        }
    }
}
