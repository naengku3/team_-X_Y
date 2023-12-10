void setup() {
  Serial.begin(9600);
  pinMode(13, OUTPUT);
}

int b = 0;

void loop() {
  if (Serial.available() > 0) {
    double a = atof(Serial.readStringUntil('\n').c_str());
      if (a >= 50 && b == 0) {
        Serial.println(a);
        tone(4, 523, 500);
        delay(500);
        b = 1;
      }
    }
  }

