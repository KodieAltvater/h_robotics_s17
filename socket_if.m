%% Send data to python server

conn = open_tcp_socket('127.0.0.1',50000);

imgData = reshape(img_data,1,numel(img_data));
send_data2python(conn,imgData); 
 
%% Read data from the python server
 % open socket 
 conn = open_tcp_socket('127.0.0.1',50064);
 old_data = [];
 i = 0;

 % burn through until data is there
 while conn.BytesAvailable == 0 end
 len = fread(conn, [1,3]);
 
 length2read = 2^16*len(1) + 2^8*len(2) + 2^0*len(3);
 
 while i < length2read
    while(conn.BytesAvailable == 0) end 
    i = i + conn.BytesAvailable;
    new_data = fread(conn, [1, conn.BytesAvailable]);
    old_data = [old_data,new_data];
 end
 
 
 img_data = uint8(reshape(old_data,480,640,3));
 imshow(img_data); 
 

%% Close socket
fclose(t); 
instrreset

%%
conn = open_tcp_socket('127.0.0.1',50035);