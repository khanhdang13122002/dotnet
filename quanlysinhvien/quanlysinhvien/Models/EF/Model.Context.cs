﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace quanlysinhvien.Models.EF
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class QuanLiSinhVienEntities4 : DbContext
    {
        public QuanLiSinhVienEntities4()
            : base("name=QuanLiSinhVienEntities4")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<BoMon> BoMon { get; set; }
        public virtual DbSet<ChuyenNganh> ChuyenNganh { get; set; }
        public virtual DbSet<Diem> Diem { get; set; }
        public virtual DbSet<GiangVien> GiangVien { get; set; }
        public virtual DbSet<HanhKiem> HanhKiem { get; set; }
        public virtual DbSet<HocKi> HocKi { get; set; }
        public virtual DbSet<Khoa> Khoa { get; set; }
        public virtual DbSet<KhoaHoc> KhoaHoc { get; set; }
        public virtual DbSet<LichSu> LichSu { get; set; }
        public virtual DbSet<Lop> Lop { get; set; }
        public virtual DbSet<MonHoc> MonHoc { get; set; }
        public virtual DbSet<PhanHoiSinhVien> PhanHoiSinhVien { get; set; }
        public virtual DbSet<SinhVien> SinhVien { get; set; }
        public virtual DbSet<sysdiagrams> sysdiagrams { get; set; }
        public virtual DbSet<User> User { get; set; }
    }
}