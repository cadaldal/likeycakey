package com.dal.likeycakey.admin.model.dao;

import java.util.ArrayList;


import org.apache.ibatis.session.RowBounds;
import com.dal.likeycakey.admin.model.dao.AdminDao;
import com.dal.likeycakey.admin.model.vo.Member;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("adminDao")
public class AdminDaoImpl implements AdminDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int getListCount() {
		System.out.println("adminDao.getListCount 도착");
		return sqlSession.selectOne("AdminMapper.getListCount");
		
	}

	@Override
	public ArrayList<Member> selectList(int currentPage, int limit) {
		System.out.println("adminDao.selectList 도착");
		int offset = (currentPage - 1) * limit;
		RowBounds rows = new RowBounds(offset, limit);
		return new ArrayList<Member>(sqlSession.selectList("AdminMapper.selectList", null, rows));
	}
/*
	@Override
	public ArrayList<Board> selectTopList() {
		RowBounds rows = new RowBounds(0, 5);
		return new ArrayList<Board>(sqlSession.selectList("Board.selectTop5", null, rows));
	}

	@Override
	public Board selectBoard(int boardNum) {
		return sqlSession.selectOne("Board.selectOne", boardNum);
	}

	@Override
	public int insertBoard(Board b) {
		return sqlSession.insert("Board.insertBoard", b);
	}

	@Override
	public int insertReply(Board replyBoard) {
		return sqlSession.insert("Board.insertReplyLevel", replyBoard);
	}

	@Override
	public int addReadCount(int boardNum) {
		return sqlSession.update("Board.addReadCount", boardNum);
	}

	@Override
	public int updateBoard(Board b) {
		return sqlSession.update("Board.updateBoard", b);
	}

	@Override
	public int updateReplySeq(Board replyBoard) {
		return sqlSession.update("Board.updateReplySeq", replyBoard);
	}

	@Override
	public int updateBoardReply(Board b) {
		return sqlSession.update("Board.updateBoardReply", b);
	}

	@Override
	public int deleteBoard(int boardNum) {
		return sqlSession.delete("Board.deleteBoard", boardNum);
	}
*/
}
