package com.team.springtour.mapper.serviceCenter;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.team.springtour.domain.serviceCenter.QnADto;

public interface QnAMapper {

	List<QnADto> selectQnAList();

	int insertQnA(QnADto qna);

	List<QnADto> listQnaPage(@Param("from")int from, @Param("row")int row);

	int countQnaPage();

	List<QnADto> selectSearchQnaAll(@Param("type")String type, 
			                        @Param("keyword")String searchKeyword, 
			                        @Param("from")int from, 
			                        @Param("row")int rowPerPage);

	int countSearchQnaPage(@Param("type")String type, @Param("keyword")String searchKeyword);

	QnADto selectQnaPostByIndexId(int indexId);

	void insertQnaFile(@Param("noticeIndexId")int noticeIndexId, @Param("fileName")String Filename);

	List<String> selectFileNameByQnaList(int noticeIndexId);

	void deleteFileByQnaIdAndFileName(@Param("indexId")int indexId, @Param("fileName")String fileName);

	int updateQnaPost(QnADto qnaPost);

	int deleteQnaPost(int indexId);

	void deleteFileByQnaId(int indexId);

	

}
