package com.team.springtour.mapper.user;

import java.util.List;

import com.team.springtour.domain.user.DirectMessageDto;

public interface DirectMessageMapper {

	List<DirectMessageDto> selectDirectMessageBySender(String userId);

	List<DirectMessageDto> selectDirectMessageByReceiver(String userId);

	int insertDirectMessage(DirectMessageDto message);

}
