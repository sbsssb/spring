package com.example.test1.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Member;

@Mapper
public interface MemberMapper {

	Member getMember(HashMap<String, Object> map);

	int insertMember(HashMap<String, Object> map);

	Member checkId(HashMap<String, Object> map);
	
	Member selectMember(HashMap<String, Object> map);

	void deleteMemberList(HashMap<String, Object> map);

}
