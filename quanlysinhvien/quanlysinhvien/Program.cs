using System;
using System.Windows.Forms;
using quanlysinhvien.DTO.UITest;
using quanlysinhvien.DTO.UILoad;
using quanlysinhvien.DTO.UILoad;
using quanlysinhvien.DTO.UILoad;
using System.Collections.Generic;

namespace quanlysinhvien
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new frmLogin());

        }
       

    }

}
