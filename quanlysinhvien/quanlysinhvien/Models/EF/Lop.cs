//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Lop
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Lop()
        {
            this.SinhVien = new HashSet<SinhVien>();
        }
    
        public string MaLop { get; set; }
        public string TenLop { get; set; }
        public string MaGV { get; set; }
        public string MaCN { get; set; }
        public Nullable<int> NienKhoa { get; set; }
    
        public virtual ChuyenNganh ChuyenNganh { get; set; }
        public virtual GiangVien GiangVien { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SinhVien> SinhVien { get; set; }
    }
}
