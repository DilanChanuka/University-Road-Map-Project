using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace RoadMap_DB.Migrations
{
    public partial class RoadMap : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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
                name: "f_Routes",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
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
                    lat = table.Column<double>(nullable: false),
                    lng = table.Column<double>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_v_Routes", x => x.id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "department_Lists");

            migrationBuilder.DropTable(
                name: "f_Routes");

            migrationBuilder.DropTable(
                name: "floors");

            migrationBuilder.DropTable(
                name: "User_location");

            migrationBuilder.DropTable(
                name: "users");

            migrationBuilder.DropTable(
                name: "v_Routes");
        }
    }
}
