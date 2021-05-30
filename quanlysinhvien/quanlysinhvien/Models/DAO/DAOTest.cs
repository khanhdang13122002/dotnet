using quanlysinhvien.Models.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace quanlysinhvien.Models.DAO
{
    public class DAOTest : baseDAO
    {

       public List<User> getAll()
        {
            return db_.User.ToList();
        }

    }
}
