void setup() {
  Serial.begin(9600);
  pinMode(13, OUTPUT);
}

int b = 0;

void loop() {
  if (Serial.available() > 0) {
    String a = Serial.readString();
    a.trim();
     // trim을 사용하기 전에 문자열 값을 정리합니다.
    if (a.length() > 0 && b == 0) {
      double value = a.toDouble();
      if (value >= 50) {
        Serial.println(value);
        tone(4, 523, 500);
        delay(500);
        b = 1;
      }
    }
  }
}
