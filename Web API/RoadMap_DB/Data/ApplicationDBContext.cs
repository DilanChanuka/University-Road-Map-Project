using Microsoft.EntityFrameworkCore;
using RoadMap_DB.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Data
{
    public class ApplicationDBContext:DbContext
    {

        public ApplicationDBContext(DbContextOptions<ApplicationDBContext> options):base(options)
        {

        }


        public DbSet<f_route> f_Routes { get; set; }
        public DbSet<v_route> v_Routes { get; set; }
        public DbSet<Inner_route> inner_Routes { get; set; }
        public DbSet<Vertext_Location> vertext_Locations { get; set; }
        //protected override void OnModelCreating(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Ignore<f_route>();
        //    modelBuilder.Entity<f_route>().HasNoKey();
        //}
         
        public DbSet<Deparment_Places> Depaerment_Places { get; set; }
        public DbSet<Entrance> entrances { get; set; }
        public DbSet<User> users { get; set; }
        public DbSet<Floor> floors { get; set; }      
        public DbSet<User_location> user_Locations { get; set; }
        public DbSet<Department_list> department_Lists { get; set; }

    }
}
