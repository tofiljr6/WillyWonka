// jdbc:mariadb://localhost:3306/WillyWonka


import java.sql.*;
import java.util.Properties;

public class Main {
    public static void main(String[] args) {
        Connection dbConnection = null;

        try {
            String url = "jdbc:mariadb://localhost:3306";
            Properties info = new Properties();
            info.put("user", "root");
            info.put("password", "mattof123.");

            dbConnection = DriverManager.getConnection(url, info);

            if (dbConnection != null) {
                System.out.println("Successfully connected to MySQL database test");
            }

        } catch (SQLException ex) {
            System.out.println("An error occurred while connecting MySQL database");
        }
    }

//    public static void main(String[] args) {
//        Connection conDB = null;
//        Statement statement = null;
//        ResultSet query = null;
//
//        try {
//            conDB = DriverManager.getConnection("jdbc:mariadb://localhost:3306", "root","mattof123.");
//
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//        } finally {
//            try {
//                query.close();
//            } catch (Exception e) {
//                // do nothing
//            }
//
//            try {
//                query.close();
//            } catch (Exception e) {
//                // do nothing
//            }
//
//            try {
//                conDB.close();
//            } catch (Exception e) {
//                // do nothing
//            }
//        }
//    }
}
