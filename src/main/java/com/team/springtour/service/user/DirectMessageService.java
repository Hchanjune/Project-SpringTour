package com.team.springtour.service.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.springtour.domain.user.DirectMessageDto;
import com.team.springtour.mapper.user.DirectMessageMapper;

@Service
public class DirectMessageService {
	
	@Autowired
	DirectMessageMapper messageMapper;

	public List<DirectMessageDto> getDmListBySender(String userId) {
		return messageMapper.selectDirectMessageBySender(userId);
	}

	public List<DirectMessageDto> getDmListByReceiver(String userId) {
		return messageMapper.selectDirectMessageByReceiver(userId);
	}

	public boolean sendMessage(DirectMessageDto message) {
		return messageMapper.insertDirectMessage(message) == 1;
	}

	public int countMessageByUserId(String userId) {
		return messageMapper.countMessageByUserId(userId);
	}

	public DirectMessageDto getMessageByIndexId(int messageId) {
		
		return messageMapper.selectMessageByIndexId(messageId);
	}
	
	public void setMessageReadInfoReadByIndexId(int messageId) {
		messageMapper.updateMessageReadInfoByIndexId(messageId);
	}
	
}
