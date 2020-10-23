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
using System.Security.Cryptography;
using System.Text;

namespace RoadMap_DB.DataAccess
{
    
    public static class MySqlDataAccess
    {
        const int NUM_ROW = 1000;
       
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
                
                if(T is User_location)
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
                else if (T is Floor)
                {
                    List<Floor> floor = new List<Floor>();
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        while(reader.Read())
                        {
                            floor.Add(new Floor()
                            {
                               
                                floor_name = reader.GetString("name"),
                                lat_value = reader.GetDouble("lat"),
                                lng_value = reader.GetDouble("lng")
                            });
                        }
                       
                       
                        reader.Close();
                    }

                    return new JsonResult(floor);
                }
                else if (T is Deparment_Places)
                {
                    List<Deparment_Places> place = new List<Deparment_Places>();
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        reader.Read();
                        place.Add(new Deparment_Places()
                        {
                            place_name=reader.GetString("place_name"),
                            lat=reader.GetDouble("lat"),
                            lng=reader.GetDouble("lng")
                        });
                        reader.Close();
                    }

                    return new JsonResult(place);
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

        private static string Encryption(string password)
        {
            MD5CryptoServiceProvider md5Hasher = new MD5CryptoServiceProvider();
            UTF8Encoding encoder = new UTF8Encoding();
            byte[] encrypt;
            //encrypt the given password string into Encrypted data  
            encrypt = md5Hasher.ComputeHash(encoder.GetBytes(password));
            StringBuilder encryptdata = new StringBuilder();
            //Create a new string by using the encrypted data  
            for (int i = 0; i < encrypt.Length; i++)
            {
                encryptdata.Append(encrypt[i].ToString());
            }
            return encryptdata.ToString();

        }
        public static string[] GetUser(string sql)
        {

            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {
                string[] data = new string[4];
                
                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                try
                {
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        reader.Read();
                        data[0] = reader.GetString("name");
                        data[1] = reader.GetString("email");
                        data[2] = reader.GetString("type");
                        data[3] = reader.GetString("pwd");
                    }
                }
                catch
                {

                }
                con.Close();
                return data;

            }
        }

        public static double[,] VRoutes(string sql)
        {

            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {

                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                MySqlDataReader reader = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(reader);
                //reader.Read();
                int numRows = dt.Rows.Count;
                double[,] data = new double[numRows, 2];

                for (int i = 0; i < numRows; i++)
                {
                    data[i, 0] = double.Parse(dt.Rows[i]["lat"].ToString());
                    data[i, 1] = double.Parse(dt.Rows[i]["lng"].ToString());

                }

                con.Close();
                return data;

            }
        }

        public static double[] GetVertex(string sql)
        {
            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                MySqlDataReader reader = cmd.ExecuteReader();
                double[] data = new double[2];
                data[0] = reader.GetDouble("lat");
                data[1] = reader.GetDouble("lng");

                return data;
            }
        }

        public static double[,] FRoute(string sql)
        {

            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {

                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                MySqlDataReader reader = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(reader);
                //reader.Read();
                int numRows = dt.Rows.Count;
                double[,] data = new double[numRows, 2];

                for (int i = 0; i < numRows; i++)
                {
                    data[i, 0] = double.Parse(dt.Rows[i]["lat"].ToString());
                    data[i, 1] = double.Parse(dt.Rows[i]["lng"].ToString());
                }

                con.Close();
                return data;

            }
        }

        public static double[,] GetFloor(string sql)
        {

            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {
                
                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);            
                MySqlDataReader reader = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(reader);
                //reader.Read();
                int numRows = dt.Rows.Count;
                double[,] data = new double[numRows, 2];
               
                for (int i = 0; i < numRows; i++)
                {
                    data[i, 0] = double.Parse(dt.Rows[i]["lat"].ToString());
                    data[i, 1] = double.Parse(dt.Rows[i]["lng"].ToString());
                }
                   
                con.Close();
                return data;

            }
        }

        public static Dictionary<string, double[]> GetFloorplaces(string sql)
        {
            using (MySqlConnection con=new MySqlConnection(ConnectionString))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                MySqlDataReader reader = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(reader);
                int numRow = dt.Rows.Count;
                Dictionary<String, double[]> places = new Dictionary<string, double[]>();
                string name = dt.Rows[0]["name"].ToString();

                for (int i = 0; i < numRow; i++)
                {                  
                    double lat=double.Parse(dt.Rows[i]["lat"].ToString());
                    double lng = double.Parse(dt.Rows[i]["lng"].ToString());
                    places.Add(name,new double[] { lat,lng});
                }

                con.Clone();
                return places;
            }
        }

        public static double[] GetOnePlace(string sql)
        {
            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                MySqlDataReader reader = cmd.ExecuteReader();
                double[] data = new double[2];
                reader.Read();
                data[0] = reader.GetDouble("lat");
                data[1] = reader.GetDouble("lng");

                return data;
            }
        }

        public static int[] DeptAndFloorID(string sql)
        {
            using (MySqlConnection con=new MySqlConnection(ConnectionString))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                MySqlDataReader reader = cmd.ExecuteReader();             
                int[] data = new int[2];

                reader.Read();
                data[0] = reader.GetInt32("dept_id");
                data[1] = reader.GetInt32("d_floor_id");
                con.Close();
                return data;
            }
        }

        public static double[,] InnerRoute(string sql)
        {

            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {

                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                MySqlDataReader reader = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(reader);
                //reader.Read();
                int numRows = dt.Rows.Count;
                double[,] data = new double[numRows, 2];

                for (int i = 0; i < numRows; i++)
                {
                    data[i, 0] = double.Parse(dt.Rows[i]["lat"].ToString());
                    data[i, 1] = double.Parse(dt.Rows[i]["lng"].ToString());
                    //data[i, 0] = reader.GetDouble("lat");
                    //data[i, 1] = reader.GetDouble("lng");
                }

                con.Close();
                return data;

            }
        }

        public static string[] GetIdentity(string sql)
        {
            using (MySqlConnection con=new MySqlConnection(ConnectionString))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                MySqlDataReader reader = cmd.ExecuteReader();
                string[] data = new string[2];
                DataTable dt = new DataTable();
                dt.Load(reader);

                if(dt.Rows.Count>0)
                {

                    data[0] = dt.Rows[0]["name"].ToString();
                    data[1] = dt.Rows[0]["pwd"].ToString();                       
                }
               
                con.Close();
                return data;

            }
        }

        public static double[] Dept_place(string sql)
        {

            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {
                double[] data = new double[2];
                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                try
                {
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            data[0] = reader.GetDouble("lat");
                            data[1] = reader.GetDouble("lng");
                        }
                    }
                }
                catch
                {

                }
                con.Close();
                return data;
            }
        }

        public static double[,] GetEntryLocation(string sql)
        {
            using (MySqlConnection con=new MySqlConnection(ConnectionString))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                MySqlDataReader reader = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(reader);
                int numRows = dt.Rows.Count;
                double[,] data = new double[numRows, 2];
                for (int i = 0; i < numRows; i++)
                {
                    data[i,0]=double.Parse(dt.Rows[i]["lat"].ToString());
                    data[i, 1] = double.Parse(dt.Rows[i]["lng"].ToString());
                }
                con.Close();
                return data;
            }
        }

        public static Dictionary<string ,double[]> GetplaceAndName(string sql)
        {
            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                MySqlDataReader reader = cmd.ExecuteReader();
                Dictionary<String, double[]> data = new Dictionary<string, double[]>();
                reader.Read();

                string name = reader.GetString("place_name");
                double lat = double.Parse(reader.GetDouble("lat").ToString());
                double lng = double.Parse(reader.GetDouble("lng").ToString());
                data.Add(name, new double[] { lat, lng });
                con.Clone();
                return data;
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
