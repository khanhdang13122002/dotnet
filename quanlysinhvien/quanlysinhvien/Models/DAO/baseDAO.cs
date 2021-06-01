namespace quanlysinhvien.Models.DAO
{
    public class baseDAO
    {

        protected Models.EF.QuanLiSinhVienEntities5 db_;
        public baseDAO()
        {
            db_ = new EF.QuanLiSinhVienEntities5();
        }

    }
}
