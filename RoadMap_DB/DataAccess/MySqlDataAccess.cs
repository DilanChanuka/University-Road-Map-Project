using Microsoft.VisualBasic.CompilerServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Configuration;
using Microsoft.CodeAnalysis.CSharp;
using System.Data;
using MySql.Data.MySqlClient;
using Microsoft.AspNetCore.Mvc;
using RoadMap_DB.Models;

namespace RoadMap_DB.DataAccess
{
    public static class MySqlDataAccess
    {
        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        }

        //public static T LoadData<T>(string sql)
        //{
        //    using (MySqlConnection con = new MySqlConnection(GetConnectionString("DefaultConnection")))
        //    {
        //        con.Open();
        //    }
        //}


        public static JsonResult AccesData(string sql,object T)
        {
            using (MySqlConnection con =new MySqlConnection(ConnectionString))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                if (T is User)
                {
                    List<User> user = new List<User>();
                    
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        reader.Read();
                        user.Add(new User()
                        {
                            name = reader.GetString("name"),
                            email = reader.GetString("email"),
                            type = reader.GetString("type"),
                            pwd = reader.GetString("pwd")
                        });

                        reader.Close();
                    }
               
                    return new JsonResult(user);
                }
                else if(T is User_location)
                {
                    List<User_location> _Locations = new List<User_location>();
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        reader.Read();
                        _Locations.Add(new User_location()
                        {
                            u_user_id=reader.GetInt32("u_user_id"),
                            d_floor_id=reader.GetInt32("d_floor_id"),
                            lat_value=reader.GetDouble("lat"),
                            lng_value=reader.GetDouble("lng"),
                            d_dept_it=reader.GetInt32("d_dept_it"),
                            place_id=reader.GetInt32("place_id")
                        });
                        reader.Close();                      
                    }

                    return new JsonResult(_Locations);
                }
                else if (T is f_route)
                {
                    List<f_route> f_Routes  = new List<f_route>();
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        reader.Read();
                        f_Routes.Add(new f_route()
                        {
                            id=reader.GetInt32("id"),
                            lat=reader.GetDouble("lat"),
                            lng=reader.GetDouble("lng")
                        });
                        reader.Close();
                    }

                    return new JsonResult(f_Routes);
                }
                else if (T is v_route)
                {
                    List<v_route> v_Routes = new List<v_route>();
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        reader.Read();
                        v_Routes.Add(new v_route()
                        {
                            id=reader.GetInt32("id"),
                            lat=reader.GetDouble("lat"),
                            lng = reader.GetDouble("lng")
                        });
                        reader.Close();
                    }

                    return new JsonResult(v_Routes);
                }
                else if (T is Floor)
                {
                    List<Floor> floor = new List<Floor>();
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        reader.Read();
                        floor.Add(new Floor()
                        {
                            floor_id=reader.GetInt32("id"),
                            floor_name=reader.GetString("name"),
                            f_dept_id=reader.GetInt32("f_dept_id"),
                            lat_value=reader.GetDouble("lat"),
                            lng_value=reader.GetDouble("lng")
                        });
                        reader.Close();
                    }

                    return new JsonResult(floor);
                }
                else
                {
                    List<Department_list> deptlist = new List<Department_list>();
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        reader.Read();
                        deptlist.Add(new Department_list()
                        {
                            dept_id=reader.GetInt32("id"),
                            name=reader.GetString("name")
                        });
                        reader.Close();
                    }

                    return new JsonResult(deptlist);
                }

                //con.Close();
                
            }
                      
        }


        public static string ConnectionString //connect to server
        {
            get
            {
                return string.Format("SERVER ={0};USER ID={1};PASSWORD={2};" +
                        "DATABASE={3};", "localhost", "root", "0923", "roadmap_db");

            }
        }
    }

}
