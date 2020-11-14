using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace RoadMap_DB.Migrations
{
    public partial class RoadMap : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Depaerment_Places",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    dept_id = table.Column<int>(nullable: false),
                    d_floor_id = table.Column<int>(nullable: false),
                    place_name = table.Column<string>(nullable: true),
                    lat = table.Column<double>(nullable: false),
                    lng = table.Column<double>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Depaerment_Places", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "department_Lists",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    name = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_department_Lists", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "entrances",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    dept_id = table.Column<int>(nullable: false),
                    floor_ID = table.Column<int>(nullable: false),
                    lat = table.Column<double>(nullable: false),
                    lng = table.Column<double>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_entrances", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "f_Routes",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    f_route_id = table.Column<int>(nullable: false),
                    lat = table.Column<double>(nullable: false),
                    lng = table.Column<double>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_f_Routes", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "floors",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    floor_id = table.Column<int>(nullable: false),
                    f_dept_id = table.Column<int>(nullable: false),
                    name = table.Column<string>(nullable: true),
                    lat = table.Column<double>(nullable: false),
                    lng = table.Column<double>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_floors", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "inner_Routes",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    in_r_id = table.Column<int>(nullable: false),
                    graph_No = table.Column<int>(nullable: false),
                    lat = table.Column<double>(nullable: false),
                    lng = table.Column<double>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_inner_Routes", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "User_location",
                columns: table => new
                {
                    u_user_id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    d_floor_id = table.Column<int>(nullable: false),
                    lat = table.Column<double>(nullable: false),
                    lng = table.Column<double>(nullable: false),
                    d_dept_it = table.Column<int>(nullable: false),
                    place_id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_User_location", x => x.u_user_id);
                });

            migrationBuilder.CreateTable(
                name: "users",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    name = table.Column<string>(nullable: false),
                    email = table.Column<string>(nullable: true),
                    type = table.Column<string>(nullable: true),
                    pwd = table.Column<string>(maxLength: 30, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_users", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "v_Routes",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    v_route_id = table.Column<int>(nullable: false),
                    lat = table.Column<double>(nullable: false),
                    lng = table.Column<double>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_v_Routes", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "vertext_Locations",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    graph_No = table.Column<int>(nullable: false),
                    vertex_No = table.Column<int>(nullable: false),
                    lat = table.Column<double>(nullable: false),
                    lng = table.Column<double>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_vertext_Locations", x => x.id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Depaerment_Places");

            migrationBuilder.DropTable(
                name: "department_Lists");

            migrationBuilder.DropTable(
                name: "entrances");

            migrationBuilder.DropTable(
                name: "f_Routes");

            migrationBuilder.DropTable(
                name: "floors");

            migrationBuilder.DropTable(
                name: "inner_Routes");

            migrationBuilder.DropTable(
                name: "User_location");

            migrationBuilder.DropTable(
                name: "users");

            migrationBuilder.DropTable(
                name: "v_Routes");

            migrationBuilder.DropTable(
                name: "vertext_Locations");
        }
    }
}
