using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace RoadMap_DB.Migrations
{
    public partial class RoadMap : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "department",
                columns: table => new
                {
                    dept_id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    dept_name = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_department", x => x.dept_id);
                });

            migrationBuilder.CreateTable(
                name: "location",
                columns: table => new
                {
                    location_id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    location_name = table.Column<string>(nullable: true),
                    lat_value = table.Column<double>(nullable: false),
                    lng_value = table.Column<double>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_location", x => x.location_id);
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
                name: "entrances",
                columns: table => new
                {
                    entrance_id = table.Column<int>(nullable: false),
                    e_location_id = table.Column<int>(nullable: false),
                    e_dept_id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_entrances", x => new { x.entrance_id, x.e_location_id });
                    table.ForeignKey(
                        name: "FK_entrances_department_e_dept_id",
                        column: x => x.e_dept_id,
                        principalTable: "department",
                        principalColumn: "dept_id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_entrances_location_e_location_id",
                        column: x => x.e_location_id,
                        principalTable: "location",
                        principalColumn: "location_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "floors",
                columns: table => new
                {
                    floor_id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    f_location_id = table.Column<int>(nullable: false),
                    f_dept_id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_floors", x => new { x.floor_id, x.f_location_id });
                    table.ForeignKey(
                        name: "FK_floors_department_f_dept_id",
                        column: x => x.f_dept_id,
                        principalTable: "department",
                        principalColumn: "dept_id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_floors_location_f_location_id",
                        column: x => x.f_location_id,
                        principalTable: "location",
                        principalColumn: "location_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "foot_Routes",
                columns: table => new
                {
                    f_route_id = table.Column<int>(nullable: false),
                    f_location_id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_foot_Routes", x => new { x.f_route_id, x.f_location_id });
                    table.ForeignKey(
                        name: "FK_foot_Routes_location_f_location_id",
                        column: x => x.f_location_id,
                        principalTable: "location",
                        principalColumn: "location_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "inner_Routes",
                columns: table => new
                {
                    in_route_id = table.Column<int>(nullable: false),
                    i_location_id = table.Column<int>(nullable: false),
                    i_dept_id = table.Column<int>(nullable: false),
                    i_floor_id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_inner_Routes", x => new { x.in_route_id, x.i_location_id });
                    table.ForeignKey(
                        name: "FK_inner_Routes_department_i_dept_id",
                        column: x => x.i_dept_id,
                        principalTable: "department",
                        principalColumn: "dept_id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_inner_Routes_location_i_location_id",
                        column: x => x.i_location_id,
                        principalTable: "location",
                        principalColumn: "location_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Place",
                columns: table => new
                {
                    place_id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    p_location_id = table.Column<int>(nullable: false),
                    p_dept_id = table.Column<int>(nullable: false),
                    p_floor_id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Place", x => x.place_id);
                    table.ForeignKey(
                        name: "FK_Place_department_p_dept_id",
                        column: x => x.p_dept_id,
                        principalTable: "department",
                        principalColumn: "dept_id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Place_location_p_location_id",
                        column: x => x.p_location_id,
                        principalTable: "location",
                        principalColumn: "location_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "User_location",
                columns: table => new
                {
                    u_user_id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    u_location_id = table.Column<int>(nullable: false),
                    location_id = table.Column<int>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_User_location", x => x.u_user_id);
                    table.ForeignKey(
                        name: "FK_User_location_location_location_id",
                        column: x => x.location_id,
                        principalTable: "location",
                        principalColumn: "location_id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "vehicle_Routes",
                columns: table => new
                {
                    v_route_id = table.Column<int>(nullable: false),
                    v_location_id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_vehicle_Routes", x => new { x.v_route_id, x.v_location_id });
                    table.ForeignKey(
                        name: "FK_vehicle_Routes_location_v_location_id",
                        column: x => x.v_location_id,
                        principalTable: "location",
                        principalColumn: "location_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "vertext_Locations",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    graph_No = table.Column<int>(nullable: false),
                    vertex_No = table.Column<int>(nullable: false),
                    location_id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_vertext_Locations", x => x.id);
                    table.ForeignKey(
                        name: "FK_vertext_Locations_location_location_id",
                        column: x => x.location_id,
                        principalTable: "location",
                        principalColumn: "location_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_entrances_e_dept_id",
                table: "entrances",
                column: "e_dept_id");

            migrationBuilder.CreateIndex(
                name: "IX_entrances_e_location_id",
                table: "entrances",
                column: "e_location_id");

            migrationBuilder.CreateIndex(
                name: "IX_floors_f_dept_id",
                table: "floors",
                column: "f_dept_id");

            migrationBuilder.CreateIndex(
                name: "IX_floors_f_location_id",
                table: "floors",
                column: "f_location_id");

            migrationBuilder.CreateIndex(
                name: "IX_foot_Routes_f_location_id",
                table: "foot_Routes",
                column: "f_location_id");

            migrationBuilder.CreateIndex(
                name: "IX_inner_Routes_i_dept_id",
                table: "inner_Routes",
                column: "i_dept_id");

            migrationBuilder.CreateIndex(
                name: "IX_inner_Routes_i_location_id",
                table: "inner_Routes",
                column: "i_location_id");

            migrationBuilder.CreateIndex(
                name: "IX_Place_p_dept_id",
                table: "Place",
                column: "p_dept_id");

            migrationBuilder.CreateIndex(
                name: "IX_Place_p_location_id",
                table: "Place",
                column: "p_location_id");

            migrationBuilder.CreateIndex(
                name: "IX_User_location_location_id",
                table: "User_location",
                column: "location_id");

            migrationBuilder.CreateIndex(
                name: "IX_vehicle_Routes_v_location_id",
                table: "vehicle_Routes",
                column: "v_location_id");

            migrationBuilder.CreateIndex(
                name: "IX_vertext_Locations_location_id",
                table: "vertext_Locations",
                column: "location_id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "entrances");

            migrationBuilder.DropTable(
                name: "floors");

            migrationBuilder.DropTable(
                name: "foot_Routes");

            migrationBuilder.DropTable(
                name: "inner_Routes");

            migrationBuilder.DropTable(
                name: "Place");

            migrationBuilder.DropTable(
                name: "User_location");

            migrationBuilder.DropTable(
                name: "users");

            migrationBuilder.DropTable(
                name: "vehicle_Routes");

            migrationBuilder.DropTable(
                name: "vertext_Locations");

            migrationBuilder.DropTable(
                name: "department");

            migrationBuilder.DropTable(
                name: "location");
        }
    }
}
