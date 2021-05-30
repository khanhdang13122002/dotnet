using quanlysinhvien.DTO.UIAuth;
using quanlysinhvien.Models.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace quanlysinhvien.Models.DAO
{
   public class DAOAuth:baseDAO
    {
        public bool CheckLogin(string user_name,string password)
        {
            var result= db_.User.Where(Ac => Ac.Tai_Khoan.CompareTo(user_name) == 0 && Ac.Mat_Khau.CompareTo(password) == 0).ToList();
            if (result.Any())
            {
                return true;

            }else
            {
                return false;
            }
         }
        public bool CheckRes(string user_,string pass_)
        {
            bool isAlive = checkAlive(user_);
            if (!isAlive)
            {
                var ID = db_.User.OrderByDescending(ur => ur.ID).FirstOrDefault();
                int ID_ = int.Parse(ID.ID.ToString());
                try
                {
                    User ur = new User
                    {
                        ID = ID_ + 1,
                        Tai_Khoan = user_,
                        Mat_Khau = pass_

                    };
                    db_.User.Add(ur);
                    db_.SaveChanges();
                    return true;
                }
                catch (Exception e)
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
           
        }

        public bool checkAlive(string user_)
        {
            var isAlive = db_.User.Where(ur => ur.Tai_Khoan.CompareTo(user_) == 0).ToList();
            if (isAlive.Any()) {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
       
}
