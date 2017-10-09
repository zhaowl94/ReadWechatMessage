% ����΢�������¼
% ���ݵ��룬cell��ʽ��
Data = WeChatExtractTest3;
% ʱ���
Time = cell2mat(Data(:,4));
% ��Ϣ
Message = Data(:,5);
% ��Ϣ�ķ����ߡ����ȱʧ������Ϊ99
MissOwnerId = find(~cellfun('isclass',Data(:,9),'double'));
Data(MissOwnerId,9) = {99};
Owner = cell2mat(Data(:,9));
% ��Ϣ����С����
MinDate = floor(Time(1,1)/86400);
% ��Ϣ���������
MaxDate = ceil(Time(end,1)/86400);

% ��ʼ������Ϣ
% ���ű��ǱȽ�˫��ÿ�����Ϣ������֮��
MessageCount = zeros(MaxDate-MinDate+1,2);
for irow = 1:size(Data,1)
    if isa(Message{irow,1},'double')
        TempMessage = num2str(Message{irow,1});
    else
        TempMessage = Message{irow,1}{1,1};
    end
    % �Լ���Ϣ
    if Owner(irow,1) == 0
        MessageCount(floor(Time(irow,1)/86400) - MinDate + 1,1) = ...
            MessageCount(floor(Time(irow,1)/86400) - MinDate + 1,1) + length(TempMessage);
    elseif Owner(irow,1) == 1
        MessageCount(floor(Time(irow,1)/86400) - MinDate + 1,2) = ...
            MessageCount(floor(Time(irow,1)/86400) - MinDate + 1,2) + length(TempMessage);
    end
end
MessageRatio = MessageCount(:,2)./MessageCount(:,1);
MessageRatio1 = sum(MessageCount(:,2))/sum(MessageCount(:,1));