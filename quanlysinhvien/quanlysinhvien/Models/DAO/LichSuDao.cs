using quanlysinhvien.Models.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace quanlysinhvien.Models.DAO
{
    public class LichSuDao:baseDAO
    {

        public List<LichSu> getAll()
        {
            return db_.LichSu.ToList();
        } 
        
    }
}
