import processing.serial.*;   //Serial 추가
import processing.net.*; //net 추가
Serial p; //Serial 변수 p지정
Server s; //Server 변수 s지정
Client c; //Client 변수 c지정

void setup() {
  p = new Serial(this, "COM11", 9600); //Serial 객체 생성
  s = new Server(this, 123); //Server 객체 생성
}

String msg="hi"; //초기문자열 "hi"
void draw() {
  c = s.available(); // Server가 사용할 수 있는 상태인지를 c에 저장
  if (c!=null) { // Server가 작동하면
    
    String m = c.readString(); // Client의 데이터를 m에 저장 
    if (m.indexOf("GET /")==0) { // GET으로 요청
      c.write("HTTP/1.1 200 OK\r\n\r\n"); // Client로 HTTP프로토콜을 통해 요청을 수락 보내기
      c.write(msg); // 본문에 Client 메세지를 보내기
    }
    c.stop(); //요청을 무한대로 받아 오류가 생기지 않기 위해 닫았다 열어주기
    if (m.indexOf("PUT /")==0) { //PUT으로 요청 
      int n = m.indexOf("\r\n\r\n")+4;
      // indexOf를 통해 "\r\n\r\n"구분자의 위치를 찾아주고 거기에 \r\n\r\n 만큼의 4바이트를 추가해주어서 HTTP 메시지 본문의 시작부분을 n에 저장 

      m = m.substring(n); // n부터시작해서 메시지 본문의 데이터(문자열)을 m에 저장
      m += '\n';           // 문자열 m에 띄어쓰기 추가
      p.write(m); // 시리얼 포트로 문자열 보내기
      print(m); // 문자열 processing에 출력
      delay(200);
    }
  }
  if (p.available()>0) { // Serial 사용가능한지 확인
    String m = p.readStringUntil('\n'); // Serial을 통해 읽은 데이터를 m에 저장
    if (m!=null)  msg = m; // msg 값을 Serial을 통해 읽은 데이터로 저장
    print(msg); // 위의 값을 출력
  }
}
