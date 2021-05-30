using quanlysinhvien.Models.DAO;
using quanlysinhvien.Models.EF;
namespace quanlysinhvien.authen
{
    class Authen
    {
        private string name_;
        public string Name { get { return name_; } set { name_ = value; } }
        
        public bool checkLogin(string userName, string password)  
        {
            DAOAuth Auth = new DAOAuth();
           
            bool checkLogin = Auth.CheckLogin(userName, password);
            if (checkLogin)
            {
               
                return true;
            }
            else
            {
                return false;
            }

        }
        public bool checkRes(string user_,string pass_,string comf_pass)
        {
            if (pass_ == comf_pass)
            {
                DAOAuth Au = new DAOAuth();
                bool checkRes = Au.CheckRes(user_, pass_);
                if (checkRes)
                {
                    return true;
                }
                return false;
            }
             
            return false;
          
        }    
    }
}
