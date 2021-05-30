using quanlysinhvien.Models.EF;
using System.Collections.Generic;
using System.Linq;

namespace quanlysinhvien.Models.DAO
{
    public class SinhVienDAO : baseDAO
    {

        public List<SinhVien> GetAll()
        {
            return db_.SinhVien.ToList();
        }

    }
}
