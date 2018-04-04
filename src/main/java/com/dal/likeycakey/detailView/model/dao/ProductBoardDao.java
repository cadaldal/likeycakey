package com.dal.likeycakey.detailView.model.dao;

import java.util.ArrayList;

import com.dal.likeycakey.biz.model.vo.BizMember;
import com.dal.likeycakey.detailView.model.vo.ProductBoard;

public interface ProductBoardDao {

	public ArrayList<ProductBoard> selectTopList();

	public ProductBoard selectTodaysCake();

	public BizMember selectBizMember(String id);
	
	

}
