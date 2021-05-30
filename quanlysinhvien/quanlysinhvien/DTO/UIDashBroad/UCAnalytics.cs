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


namespace quanlysinhvien.DTO.UIAnalytics
{
    public partial class UCAnalytics : UserControl
    {
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
        public void loadData()
        {

            SinhVienDAO daoSV = new SinhVienDAO();
            dgvListSinhVien.DataSource = daoSV.GetAll();

        }
        

        private void btnClose_Click(object sender, EventArgs e)
        {
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
            frmManager frmManager = new frmManager();
            UCAdd ucAdd = new UCAdd();
            frmManager.addControl(ucAdd);
            frmManager.ShowDialog();

        }
    }
}
