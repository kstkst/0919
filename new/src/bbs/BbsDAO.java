package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
    // dao : �뜲�씠�꽣踰좎씠�뒪 �젒洹� 媛앹껜�쓽 �빟�옄濡쒖꽌
    // �떎吏덉쟻�쑝濡� db�뿉�꽌 �쉶�썝�젙蹂� 遺덈윭�삤嫄곕굹 db�뿉 �쉶�썝�젙蹂� �꽔�쓣�븣

    private Connection conn; // connection:db�뿉�젒洹쇳븯寃� �빐二쇰뒗 媛앹껜
    private ResultSet rs;

    // mysql�뿉 �젒�냽�빐 二쇰뒗 遺�遺�
    public BbsDAO() { // �깮�꽦�옄 �떎�뻾�맆�븣留덈떎 �옄�룞�쑝濡� db�뿰寃곗씠 �씠猷⑥뼱 吏� �닔 �엳�룄濡앺븿
       try {
          String dbURL = "jdbc:mysql://localhost:3306/BBS?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"; // localhost:3306 �룷�듃�뒗 而댄벂�꽣�꽕移섎맂 mysql二쇱냼
          String dbID = "snowwhite";
          String dbPassword = "1234";
          Class.forName("com.mysql.cj.jdbc.Driver");
          conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
       } catch (Exception e) {
          e.printStackTrace(); // �삤瑜섍� 臾댁뾿�씤吏� 異쒕젰
       }
    }
    
    public String getDate() {
    	String SQL = "SELECT NOW()";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			return rs.getString(1);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return ""; //db �삤瑜�
    }
    
    public int getNext() {
    	String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			return rs.getInt(1) + 1;
    		}
    		return 1; //泥ル쾲吏� 寃뚯떆臾쇱씤 寃쎌슦
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return -1; //db�삤瑜�
    }
    
    public int write(String bbsTitle, String userID, String bbsContent, String category, int groupId) {
    	String SQL = "INSERT INTO BBS VALUE (?, ?, ?, ?, ?, ?, ?, ?)";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		pstmt.setInt(1, getNext());
    		pstmt.setString(2, bbsTitle);
    		pstmt.setString(3, userID);
    		pstmt.setString(4, getDate());
    		pstmt.setString(5, bbsContent);
    		pstmt.setInt(6, 1);
    		pstmt.setString(7, category);
    		pstmt.setInt(8, groupId);
    		return pstmt.executeUpdate();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return -1; //db�삤瑜�
    }
    
    public ArrayList<Bbs> getList(int pageNumber){
    	String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
    	ArrayList<Bbs> list = new ArrayList<Bbs>();
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
    		rs = pstmt.executeQuery();
    		while (rs.next()) {
    			Bbs bbs =new Bbs();
    			bbs.setBbsID(rs.getInt(1));
    			bbs.setBbsTitle(rs.getString(2));
    			bbs.setUserID(rs.getString(3));
    			bbs.setBbsDate(rs.getString(4));
    			bbs.setBbsContent(rs.getString(5));
    			bbs.setBbsAvailable(rs.getInt(6));
    			bbs.setCategory(rs.getString(7));
    			bbs.setGroupId(rs.getInt(8));
    			list.add(bbs);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return list; //db�삤瑜�
    }
    
    public boolean nextPage(int pageNumber) {
    	String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			return true;
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return false; //db�삤瑜�
    }
    
    public Bbs getBbs(int bbsID) {
    	String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		pstmt.setInt(1, bbsID);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			Bbs bbs =new Bbs();
    			bbs.setBbsID(rs.getInt(1));
    			bbs.setBbsTitle(rs.getString(2));
    			bbs.setUserID(rs.getString(3));
    			bbs.setBbsDate(rs.getString(4));
    			bbs.setBbsContent(rs.getString(5));
    			bbs.setBbsAvailable(rs.getInt(6));
    			bbs.setCategory(rs.getString(7));
    			bbs.setGroupId(rs.getInt(8));
    			return bbs;
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return null; //db�삤瑜�
    }
    
    public int update(int bbsID, String bbsTitle, String bbsContent) {
    	String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		pstmt.setString(1, bbsTitle);
    		pstmt.setString(2, bbsContent);
    		pstmt.setInt(3, bbsID);
    		return pstmt.executeUpdate();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return -1; //db�삤瑜�
    }
    public int delete(int bbsID) {
    	String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		pstmt.setInt(1, bbsID);
    		return pstmt.executeUpdate();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return -1; //db�삤瑜�
    }
    public int getNewGroupId() {
    	
    	int newGroupId = 0;
    	
    	String SQL = "select distinct groupId from BBS where groupId = (select MAX(groupId) from BBS)";
    	
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);    
    		
    		//SQL臾� �떎�뻾
    		rs = pstmt.executeQuery();

    		
    		// 寃뚯떆�뙋 湲��씠 1嫄� �엳�뒗 寃쎌슦
    		if(rs.next()) {
    			                           
    			newGroupId = rs.getInt("groupId") + 1;
    			
    		} else {

    			newGroupId = 1;
    			
    		}
    		
    		System.out.println("groupId : " + newGroupId);
    		
    		rs.close();
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return newGroupId;
      }
}
