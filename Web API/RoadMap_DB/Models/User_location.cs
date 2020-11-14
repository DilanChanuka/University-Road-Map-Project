using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Models
{
    [Table("User_location")]
    public class User_location
    {
        [Key,Column(Order =0)]
        public  int u_user_id { get; set; }

        [Column(Order =1)]
        public  int d_floor_id { get; set; }

        [Column("lat",Order =2)]
        public double lat_value { get; set; }

        [Column("lng",Order =3)]
        public double lng_value{ get; set; }

        [Column(Order = 4)]
        public int d_dept_it { get; set; }

        [Column(Order = 5)]
        public int place_id { get; set; }
    }
}
