using quanlysinhvien.Models.EF;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace quanlysinhvien.Models.DAO
{
    public class SinhVienDAO : baseDAO
    {
        public List<SinhVien> getAll()
        {
            return db_.SinhVien.ToList();
        }
        public string addStudent(string [] data,Image avt)
        {
            try
            {
              

                string malop = data[8];
                var getMaLop = db_.Lop.Where(lop => lop.MaLop.CompareTo(malop) == 0).ToList();
                string maSv = data[0];
                var getMaSv = db_.SinhVien.Where(sv => sv.MaSV.CompareTo(maSv) == 0).ToList();
                if (getMaLop.Any())
                {
                    if (getMaSv.Count() == 0)
                    {
                        bool gender;
                        if (data[4] == "nam")
                        {
                            gender = true;
                        }
                        else
                        {
                            gender = false;
                        }
                        SinhVien sv = new SinhVien
                        {
                            MaSV = data[0],
                            HoTen = data[1],
                            QueQuan = data[2],
                            NgaySinh = DateTime.Parse("2020-09-02"),
                            GioiTinh = gender,
                            DiaChi = data[5],
                            EMail = data[6],
                            SDT = data[7],
                            MaLop = data[8],
                            Pic = ConvertImage(avt)
                        };
                        db_.SinhVien.Add(sv);
                        db_.SaveChanges();
                        return "Them Thanh Cong";
                    }
                    else
                    {
                        return "Ma Sinh Vien Da Ton Tai";
                    }
                    
                }
                else
                {
                    return "Ma lop khong ton tai!";
                }
                
                
            }catch(Exception ex)
            {
                return ex.Message;
            }
            
        }
        public Image ByteArrayToImage(byte[] byteArr)
        {
            if (byteArr != null)
            {
                using (MemoryStream ms = new MemoryStream(byteArr))
                {
                    Image img = Image.FromStream(ms);
                    return img;
                }
            }
            else
            {
                return null;
            }
            
        }
        byte[] ConvertImage(Image img)
        {
            if (img != null)
            {
                using (MemoryStream ms = new MemoryStream())
                {

                    img.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                    return ms.ToArray();
                }
            }
            return null;
        }
        public List<Lop> GetMaLop()
        {
            return db_.Lop.ToList();
        }
        public List<SinhVien> searchByKey(string key)
        {
            return db_.SinhVien.Where(sv => sv.HoTen.Contains(key) || sv.MaSV.Contains(key)|| sv.MaLop.Contains(key)).ToList();
        }
        public List<SinhVien> getInfor(string maSv)
        {
            return db_.SinhVien.Where(sv => sv.MaSV.CompareTo(maSv) == 0).ToList();

        }
        public string updated(string[] data,Image avt)
        {
            try
            {
                string malop = data[8];
                var getMaLop = db_.Lop.Where(lop => lop.MaLop.CompareTo(malop) == 0).ToList();
                string maSv = data[0];
                var getMaSv = db_.SinhVien.Where(sv => sv.MaSV.CompareTo(maSv) == 0).ToList();
                if (getMaLop.Any())
                {
                    if (getMaSv.Count() == 1)
                    {
                        
                        bool gender;
                        if (data[4] == "nam")
                        {
                            gender = true;
                        }
                        else
                        {
                            gender = false;
                        }

                        foreach(var item in getMaSv)
                        {
                          
                            item.HoTen = data[1];
                            item.QueQuan = data[2];
                            item.NgaySinh = DateTime.Parse("2020-09-02");
                            item.GioiTinh = gender;
                            item.DiaChi = data[5];
                            item.EMail = data[6];
                            item.SDT = data[7];
                            item.MaLop = data[8];
                            if (avt != null)
                            {
                                if (ConvertImage(avt) != item.Pic)
                                {
                                    item.Pic = ConvertImage(avt);

                                }
                            }
                            else
                            {
                                item.Pic = null;

                            }
                        }
                        db_.SaveChanges();
                        return "Sua Thanh Cong";
                    }
                    else
                    {
                        return "Ma Sinh Vien Da Ton Tai";
                    }

                }
                else
                {
                    return "Ma lop khong ton tai!";
                }


            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        public bool remove(string masv)
        {
            try
            {
                var infor =db_.SinhVien.Where(sv=>sv.MaSV.CompareTo(masv)==0).FirstOrDefault();
                if (infor!=null)
                {
                    db_.SinhVien.Remove(infor);
                    db_.SaveChanges();
                    return true;
                }
                return false;
            }catch(Exception ex)
            {
                return false;
            }
            
        }
    }
}
