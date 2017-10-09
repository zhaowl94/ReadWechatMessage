% 分析微信聊天记录
% 数据导入，cell格式的
Data = WeChatExtractTest3;
% 时间戳
Time = cell2mat(Data(:,4));
% 信息
Message = Data(:,5);
% 信息的发送者。如果缺失，则定义为99
MissOwnerId = find(~cellfun('isclass',Data(:,9),'double'));
Data(MissOwnerId,9) = {99};
Owner = cell2mat(Data(:,9));
% 信息的最小日期
MinDate = floor(Time(1,1)/86400);
% 信息的最大日期
MaxDate = ceil(Time(end,1)/86400);

% 开始处理信息
% 本脚本是比较双方每天的信息数据量之比
MessageCount = zeros(MaxDate-MinDate+1,2);
for irow = 1:size(Data,1)
    if isa(Message{irow,1},'double')
        TempMessage = num2str(Message{irow,1});
    else
        TempMessage = Message{irow,1}{1,1};
    end
    % 自己消息
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