package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	// dao : 데이터베이스 접근 객체의 약자로서

	// 실질적으로 db에서 회원정보 불러오거나 db에 회원정보 넣을때

    private Connection conn; // connection:db에 접근하게 해주는 객체
    private ResultSet rs;

    /**
	 *
	 * @fn 		BbsDAO()
	 * 
	 * @brief 	DAO
	 *
	 * @author 	최지은
	 * @date 	2019-11-13
	 *
	 *
	 * @remark	DB 연결	[2019-11-13; 최지은] \n
	 *
	 */

    // mysql에 접속해 주는 부분
    public BbsDAO() { // 생성자 실행될때마다 자동으로 db연결이 이루어 질 수 있도록함
       try {
          String dbURL = "jdbc:mysql://localhost:3306/winedb?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"; // localhost:3306 �룷�듃�뒗 而댄벂�꽣�꽕移섎맂 mysql二쇱냼
          String dbID = "wine";
          String dbPassword = "1234";
          Class.forName("com.mysql.cj.jdbc.Driver");
          conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
       } catch (Exception e) {
          e.printStackTrace(); // 오류가 무엇인지 출력
       }
    }
    /**
	 *
	 * @fn 		getDate()
	 * 
	 * @brief 	DAO
	 *
	 * @author 	최지은
	 * @date 	2019-11-13
	 *
	 *
	 * @remark	현재 날짜 입력	[2019-11-13; 최지은] \n
	 *
	 */

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
    	return ""; // DB 오류
    }
    /**
	 *
	 * @fn 		getNext()
	 * 
	 * @brief 	DAO
	 *
	 * @author 	최지은
	 * @date 	2019-11-13
	 *
	 *
	 * @remark	bbsID 값 자동 +1	[2019-11-13; 최지은] \n
	 *
	 */
    public int getBoardNumber() {
    	String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			return rs.getInt(1) + 1;
    		}
    		return 1; 
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return -1; // DB 오류
    }
    /**
	 *
	 * @fn 		write()
	 * 
	 * @brief 	DAO
	 *
	 * @author 	최지은
	 * @date 	2019-11-13
	 *
	 *
	 * @remark	글작성	[2019-11-13; 최지은] \n
	 *
	 */
    public int boardWrite(String bbsTitle, String userID, String bbsContent, String category, int groupId, int hit) {
    	String SQL = "INSERT INTO BBS VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		pstmt.setInt(1, getBoardNumber());
    		pstmt.setString(2, bbsTitle);
    		pstmt.setString(3, userID);
    		pstmt.setString(4, getDate());
    		pstmt.setString(5, bbsContent);
    		pstmt.setInt(6, 1);
    		pstmt.setString(7, category);
    		pstmt.setInt(8, groupId);
    		pstmt.setInt(9, 0);
    		return pstmt.executeUpdate();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return -1; // DB 오류
    }
    
    /**
	 *
	 * @fn 		getList()
	 * 
	 * @brief 	DAO
	 *
	 * @author 	최지은
	 * @date 	2019-11-13
	 *
	 *
	 * @remark	글 정보 호출	[2019-11-13; 최지은] \n
	 *
	 */
    public ArrayList<Bbs> getboardList(int pageNumber){
    	String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY groupId DESC, bbsID ASC LIMIT 10";
    	ArrayList<Bbs> list = new ArrayList<Bbs>();
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		pstmt.setInt(1,  getBoardNumber() - (pageNumber - 1) * 10);
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
    			bbs.setHit(rs.getInt(9));
    			list.add(bbs);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return list; // DB 오류
    }
    /**
	 *
	 * @fn 		nextPage()
	 * 
	 * @brief 	DAO
	 *
	 * @author 	최지은
	 * @date 	2019-11-13
	 *
	 *
	 * @remark	글10개 이상 다음 페이지로 이동	[2019-11-13; 최지은] \n
	 *
	 */
    public boolean nextBoardPage(int pageNumber) {
    	String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		pstmt.setInt(1,  getBoardNumber() - (pageNumber - 1) * 10);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			return true;
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return false; // DB 오류
    }
    /**
	 *
	 * @fn 		getBbs()
	 * 
	 * @brief 	DAO
	 *
	 * @author 	최지은
	 * @date 	2019-11-13
	 *
	 *
	 * @remark	글 1건 호출	[2019-11-13; 최지은] \n
	 *
	 */
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
    			bbs.setHit(rs.getInt(9));
    			return bbs;   			
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return null; // DB 오류
    }
    /**
	 *
	 * @fn 		update()
	 * 
	 * @brief 	DAO
	 *
	 * @author 	최지은
	 * @date 	2019-11-13
	 *
	 *
	 * @remark	글 1건 수정	[2019-11-13; 최지은] \n
	 *
	 */
    public int boardUpdate(int bbsID, String bbsTitle, String bbsContent) {
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
    	return -1; // DB 오류
    }
    /**
	 *
	 * @fn 		delete()
	 * 
	 * @brief 	DAO
	 *
	 * @author 	최지은
	 * @date 	2019-11-13
	 *
	 *
	 * @remark	글 1건 삭제	[2019-11-13; 최지은] \n
	 *
	 */
    public int boardDelete(int bbsID) {
    	String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		pstmt.setInt(1, bbsID);
    		return pstmt.executeUpdate();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return -1; // DB 오류
    }
    /**
	 *
	 * @fn 		getNewGroupId()
	 * 
	 * @brief 	DAO
	 *
	 * @author 	최지은
	 * @date 	2019-11-13
	 *
	 *
	 * @remark	새로운 GroupId 생성	[2019-11-13; 최지은] \n
	 *
	 */
    public int getNewGroupId() {
    	
    	int newGroupId = 0;
    	
    	String SQL = "select distinct groupId from BBS where groupId = (select MAX(groupId) from BBS)";
    	
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);    
    		
    		rs = pstmt.executeQuery();

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
   
    public int hitUpdate(int bbsID) {
    	String SQL = "UPDATE BBS SET hit = hit + 1 WHERE bbsID = ?";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		pstmt.setInt(1, bbsID);
    		return pstmt.executeUpdate();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return -1; // DB 오류
    }
}
