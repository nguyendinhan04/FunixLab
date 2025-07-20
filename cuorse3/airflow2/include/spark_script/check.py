import socket

host = "spark-master"
port = 7077

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
result = sock.connect_ex((host, port))
if result == 0:
    print("Kết nối thành công đến Spark Master!")
else:
    print("Không thể kết nối đến Spark Master.")
sock.close()
