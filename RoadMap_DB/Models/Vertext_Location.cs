using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Models
{
    public class Vertext_Location
    {
        [Key,Column(Order =0)]
        public int id { get; set; }
        public int graph_No { get; set; }
        public int vertex_No { get; set; }
        public double lat { get; set; }
        public double lng { get; set; }
    }
}
