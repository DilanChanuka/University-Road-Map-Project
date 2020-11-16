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
        public int u_location_id { get; set; }


    }
}
