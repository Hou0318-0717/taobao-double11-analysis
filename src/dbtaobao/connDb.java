package dbtaobao;
import java.sql.*;
import java.util.ArrayList;

public class connDb {
    private static Connection con = null;
    private static Statement stmt = null;
    private static ResultSet rs = null;

    public static void startConn(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            try{
                con = DriverManager.getConnection("jdbc:MySQL://localhost:3306/dbtaobao","spark","123456789");
            }catch(SQLException e){
                e.printStackTrace();
            }
        }catch(ClassNotFoundException e){
            e.printStackTrace();
        }
    }

    public static void endConn() throws SQLException{
        if(con != null){ con.close(); con = null; }
        if(rs != null){ rs.close(); rs = null; }
        if(stmt != null){ stmt.close(); stmt = null; }
    }

    // 所有买家各消费行为对比 (action: 0=点击,1=加购物车,2=购买,3=收藏)
    public static ArrayList index() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("select action,count(*) num from user_log group by action order by action");
        while(rs.next()){
            String[] temp={rs.getString("action"),rs.getString("num")};
            list.add(temp);
        }
        endConn();
        return list;
    }

    // 男女买家交易对比
    public static ArrayList index_1() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("select gender,count(*) num from user_log group by gender order by gender");
        while(rs.next()){
            String[] temp={rs.getString("gender"),rs.getString("num")};
            list.add(temp);
        }
        endConn();
        return list;
    }

    // 男女买家各个年龄段交易对比
    public static ArrayList index_2() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("select gender,age_range,count(*) num from user_log group by gender,age_range order by gender,age_range");
        while(rs.next()){
            String[] temp={rs.getString("gender"),rs.getString("age_range"),rs.getString("num")};
            list.add(temp);
        }
        endConn();
        return list;
    }

    // 商品类别交易额对比 (TOP5)
    public static ArrayList index_3() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("select cat_id,count(*) num from user_log group by cat_id order by count(*) desc limit 5");
        while(rs.next()){
            String[] temp={rs.getString("cat_id"),rs.getString("num")};
            list.add(temp);
        }
        endConn();
        return list;
    }

    // 各个省份的总成交量对比
    public static ArrayList index_4() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("select province,count(*) num from user_log group by province order by count(*) desc");
        while(rs.next()){
            String[] temp={rs.getString("province"),rs.getString("num")};
            list.add(temp);
        }
        endConn();
        return list;
    }

    // 回头客购买力对比 (按年龄段性别的购买次数)
    public static ArrayList index_6() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("select age_range,gender,count(*) num from user_log where action=2 group by age_range,gender order by age_range,gender");
        while(rs.next()){
            String[] temp={rs.getString("age_range"),rs.getString("gender"),rs.getString("num")};
            list.add(temp);
        }
        endConn();
        return list;
    }

    // 品牌销量排行TOP10
    public static ArrayList index_8() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("select brand_id,count(*) num from user_log group by brand_id order by count(*) desc limit 10");
        while(rs.next()){
            String[] temp={rs.getString("brand_id"),rs.getString("num")};
            list.add(temp);
        }
        endConn();
        return list;
    }

    // 商家销量排行TOP10
    public static ArrayList index_9() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("select merchant_id,count(*) num from user_log group by merchant_id order by count(*) desc limit 10");
        while(rs.next()){
            String[] temp={rs.getString("merchant_id"),rs.getString("num")};
            list.add(temp);
        }
        endConn();
        return list;
    }

    // 省份行为分布
    public static ArrayList index_10() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("select province,action,count(*) num from user_log group by province,action order by province,action");
        while(rs.next()){
            String[] temp={rs.getString("province"),rs.getString("action"),rs.getString("num")};
            list.add(temp);
        }
        endConn();
        return list;
    }

    // 年龄段行为偏好
    public static ArrayList index_12() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("select age_range,action,count(*) num from user_log group by age_range,action order by age_range,action");
        while(rs.next()){
            String[] temp={rs.getString("age_range"),rs.getString("action"),rs.getString("num")};
            list.add(temp);
        }
        endConn();
        return list;
    }

    // 回头客预测评分 (从rebuy表读取SVM预测结果)
    public static ArrayList index_rebuy() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("select score,label from rebuy limit 1000");
        while(rs.next()){
            String[] temp={rs.getString("score"),rs.getString("label")};
            list.add(temp);
        }
        endConn();
        return list;
    }
}
