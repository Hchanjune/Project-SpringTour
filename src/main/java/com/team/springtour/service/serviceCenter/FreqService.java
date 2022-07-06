package com.team.springtour.service.serviceCenter;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team.springtour.domain.serviceCenter.FreqDto;
import com.team.springtour.domain.serviceCenter.QnADto;
import com.team.springtour.mapper.serviceCenter.FreqMapper;

@Service
public class FreqService {

	@Autowired
	private FreqMapper mapper;
	
	public FreqDto getFreqPost() {
		FreqDto freq = mapper.selectFreqPost();
		return freq;
	}


	public List<FreqDto> listFreqPage(int page, int rowPerPage) {
		
		int from = (page-1) * rowPerPage;
		
		return mapper.listFreqPage(from, rowPerPage);
	}


	public List<FreqDto> freqSearchPost(String type, String keyword, int page, int rowPerPage) {
		String Keyword = "%" + keyword + "%";
			
		int from = (page-1) * rowPerPage;
			
		return mapper.selectFreqSearchAll(type, Keyword, from, rowPerPage);
	}


	public int countFreqPostPage() {
		return mapper.countFreqPostPage();
	}



	public boolean insertFreq(FreqDto freq) {
		
		int cnt = mapper.insertFreqList(freq);
		//int cnt = mapper.insertBoard(freq);
		
		return cnt == 1;
	}


	public int countSearchedFreqPage(String type, String keyword) {
		String Keyword = "%" + keyword + "%";
		
		return mapper.countSearchedFreqPage(type, Keyword);
	}


	public FreqDto getFreqPostByIndexId(int freqIndexId) {
		FreqDto freqList = mapper.selectFreqPostByIndexId(freqIndexId);

		return freqList;
	}

	@Transactional
	public boolean updateFreqPost(FreqDto freqPost) {
		int cnt = mapper.updateFreqPost(freqPost);
		return cnt == 1;
	}

	@Transactional
	public boolean deleteFreqPost(int freqIndexId) {
		return mapper.deleteFreqPost(freqIndexId) == 1;
	}
	

}


