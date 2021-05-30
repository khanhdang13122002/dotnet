using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace quanlysinhvien.Models.DAO
{
    public class DAODash : baseDAO
    {


        public int getCountSv()
        {
            return db_.SinhVien.Count();
        }
        public int getCountCourses()
        {
            return db_.KhoaHoc.Count();
        }


    }
}
