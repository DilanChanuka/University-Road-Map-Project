using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Models
{
    public class Entrance
    {
        [Key,Column(Order =0)]
        public int id { get; set; }

        [Column(Order =1)]
        public int dept_id { get; set; }

        public int floor_ID { get; set; }

        [Column(Order = 3)]
        public double lat { get; set; }

        [Column(Order = 4)]
        public double lng { get; set; }
    }
}
