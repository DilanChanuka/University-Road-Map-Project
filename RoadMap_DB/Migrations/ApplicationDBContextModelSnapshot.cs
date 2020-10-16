
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using RoadMap_DB.Data;

namespace RoadMap_DB.Migrations
{
    [DbContext(typeof(ApplicationDBContext))]
    partial class ApplicationDBContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "3.1.8")
                .HasAnnotation("Relational:MaxIdentifierLength", 64);

            modelBuilder.Entity("RoadMap_DB.Models.Department_list", b =>
                {
                    b.Property<int>("dept_id")
                        .ValueGeneratedOnAdd()
                        .HasColumnName("id")
                        .HasColumnType("int");

                    b.Property<string>("name")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.HasKey("dept_id");

                    b.ToTable("department_Lists");
                });

            modelBuilder.Entity("RoadMap_DB.Models.Floor", b =>
                {
                    b.Property<int>("floor_id")
                        .ValueGeneratedOnAdd()
                        .HasColumnName("id")
                        .HasColumnType("int");

                    b.Property<int>("f_dept_id")
                        .HasColumnType("int");

                    b.Property<string>("floor_name")
                        .HasColumnName("name")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<double>("lat_value")
                        .HasColumnName("lat")
                        .HasColumnType("double");

                    b.Property<double>("lng_value")
                        .HasColumnName("lng")
                        .HasColumnType("double");

                    b.HasKey("floor_id");

                    b.ToTable("floors");
                });

            modelBuilder.Entity("RoadMap_DB.Models.User", b =>
                {
                    b.Property<int>("user_id")
                        .ValueGeneratedOnAdd()
                        .HasColumnName("id")
                        .HasColumnType("int");

                    b.Property<string>("email")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<string>("name")
                        .IsRequired()
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<string>("pwd")
                        .HasColumnType("varchar(30) CHARACTER SET utf8mb4")
                        .HasMaxLength(30);

                    b.Property<string>("type")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.HasKey("user_id");

                    b.ToTable("users");
                });

            modelBuilder.Entity("RoadMap_DB.Models.User_location", b =>
                {
                    b.Property<int>("u_user_id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<int>("d_dept_it")
                        .HasColumnType("int");

                    b.Property<int>("d_floor_id")
                        .HasColumnType("int");

                    b.Property<double>("lat_value")
                        .HasColumnName("lat")
                        .HasColumnType("double");

                    b.Property<double>("lng_value")
                        .HasColumnName("lng")
                        .HasColumnType("double");

                    b.Property<int>("place_id")
                        .HasColumnType("int");

                    b.HasKey("u_user_id");

                    b.ToTable("User_location");
                });

            modelBuilder.Entity("RoadMap_DB.Models.f_route", b =>
                {
                    b.Property<int>("id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<double>("lat")
                        .HasColumnType("double");

                    b.Property<double>("lng")
                        .HasColumnType("double");

                    b.HasKey("id");

                    b.ToTable("f_Routes");
                });

            modelBuilder.Entity("RoadMap_DB.Models.v_route", b =>
                {
                    b.Property<int>("id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<double>("lat")
                        .HasColumnType("double");

                    b.Property<double>("lng")
                        .HasColumnType("double");

                    b.HasKey("id");

                    b.ToTable("v_Routes");
                });
#pragma warning restore 612, 618
        }
    }
}
