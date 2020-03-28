int sensorValue;
int inputPin = A0;

int enviar;

void setup(){ 
 Serial.begin(9600);
}

void loop() {       
sensorValue = analogRead(inputPin);

//Serial.println(sensorValue/4,DEC); para arduido revisar si esta bien

//Serial.println(sensorValue,DEC);

//Serial.write(sensorValue/4);

//enviar = sensorValue;

//Serial.write(enviar);

Serial.write(sensorValue);

delay(100);
}
