using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Models
{
    public class Floor
    {
        [Key,Column(Order =0)]
        public int id { get; set; }
        public int floor_id { get; set; }

        [Column(Order =2)]
        public int f_dept_id { get; set; }

        [Column("name",Order =3)]
        public string floor_name { get; set; }

        [Column("lat",Order =4)]
        public double lat_value { get; set; }

        [Column("lng", Order = 5)]
        public double lng_value { get; set; }
    }
}
