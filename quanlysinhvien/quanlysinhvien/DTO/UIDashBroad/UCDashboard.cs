using System;
using System.Windows.Forms;
using quanlysinhvien.Models.DAO;
using quanlysinhvien.Models.EF;

namespace quanlysinhvien.DTO.UIDashBroad
{
    public partial class UCDashboard : UserControl
    {
        public int counterSv = 0;
        public int counterCourses = 0;

        public UCDashboard()
        {
            InitializeComponent();
            cpgStudentPercent.Value = 0;
            loadData();

        }
        public void loadData()
        {

            DAODash daoDash = new DAODash();
            lblStudentTotals.Text = daoDash.getCountSv().ToString();
            lblCourseTotal.Text = daoDash.getCountCourses().ToString();
            
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Do you want Exit? ", "Nofication", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) == DialogResult.Yes)
            {
                Application.Exit();
            }
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
               
        }

        private void textBox1_MouseDown(object sender, MouseEventArgs e)
        {
            textBox1.Text = "";
        }

        private void textBox1_Leave(object sender, EventArgs e)
        {
            textBox1.Text = "  Search for something";
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            cpgStudentPercent.Value += 1;
            cpgStudentPercent.Text = cpgStudentPercent.Value.ToString() + "%";
            if (cpgStudentPercent.Value == 68)
            {
                tmerStudentPercent.Enabled = false;
               
            }
        }

        private void plnContent_Paint(object sender, PaintEventArgs e)
        {

        }

        private void tmerCount_Tick(object sender, EventArgs e)
        {
            this.counterSv += 1;
            DAODash daoDash = new DAODash();
            lblStudentTotals.Text = counterSv.ToString();
            if (counterSv == daoDash.getCountSv())
            {
                tmerCount.Enabled = false;
            }

        }

        private void tmerCountCourses_Tick(object sender, EventArgs e)
        {
            this.counterCourses += 1;
            DAODash daoDash = new DAODash();
            lblCourseTotal.Text = counterCourses.ToString();
            tmerCountCourses.Interval = 300;
            if (counterCourses == daoDash.getCountCourses())
            {
                tmerCountCourses.Enabled = false;
            }
            if (daoDash.getCountCourses() > 100)
            {
                tmerCountCourses.Interval = 50;
            }
        }
    }
}
