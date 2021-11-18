/* 06/03/2017 IFPB Controle do mux via matlab
 *  
 *  digital 7 - 4
 *  0 0 0 0 - conv3 conv2 conv1 conv0    
 *      
 */
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <EEPROM.h>
LiquidCrystal_I2C lcd(0x27,2,1,0,4,5,6,7,3, POSITIVE);
 
#include "TimerOne.h"
#define conv3 7 //laranja
#define conv2 6 //verde
#define conv1 5 //amarelo
#define conv0 4 //azul
#define sensorUmidade 8
#define sensorUmidade2 10
#define buzzer 11
#define rele 9
int a=0;
int x;
int y;
int leituraSensor = 1000;
String str = "";         
boolean flag1 = false;
boolean flag2 = false;
boolean flag3 = false;  
boolean estado=0;
String t,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12;
void setup() {
  lcd.begin (16,2);
  Serial.begin(9600);
  str.reserve(25);
  pinMode(rele,OUTPUT);
  digitalWrite(rele,HIGH);
  pinMode(conv0, OUTPUT);
  pinMode(conv1, OUTPUT);
  pinMode(conv2, OUTPUT);
  pinMode(conv3, OUTPUT);
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(sensorUmidade, OUTPUT);
  pinMode(sensorUmidade2, OUTPUT);
  pinMode(buzzer, OUTPUT);
  digitalWrite(sensorUmidade, HIGH);
  digitalWrite(sensorUmidade2, LOW);
  digitalWrite(2, LOW);
  digitalWrite(3, HIGH);
  Timer1.initialize(500000);
  Timer1.attachInterrupt(leitura);
  r1 = EEPROM.read(1);
  r2 = EEPROM.read(2);
  r3 = EEPROM.read(3);
  r4 = EEPROM.read(4);
  r5 = EEPROM.read(5);
  r6 = EEPROM.read(6);
  r7 = EEPROM.read(7);
  r8 = EEPROM.read(8);
  r9 = EEPROM.read(9);
  r10 = EEPROM.read(10);
  r11 = EEPROM.read(11);
  r12 = EEPROM.read(12);
  t=EEPROM.read(13); 
}

void loop() {
  //sensor de umidade
  if (flag2){
    
    leituraSensor = analogRead(A0);
    //Serial.println(leituraSensor);
    if (leituraSensor > 800)
      digitalWrite(rele,LOW);
    else
      digitalWrite(rele,HIGH);  
    flag2 = 0;
    a++;
    flcd();
  }
  
  if (flag1) 
  {
    //pegar os valores das médias de cada reator e cada na variavel r1,r2,r3 ..
    if(str[0] == 'r'){
    x=0;  
      
      if(str[1] == '1'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r1 = str;
        EEPROM.put(1, r1);  
      }
      if(str[1] == '2'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r2 = str;
        EEPROM.put(2, r2);  
      }
      if(str[1] == '3'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r3 = str;
        EEPROM.put(3, r3);  
      }
      if(str[1] == '4'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r4 = str; 
        EEPROM.put(4, r4); 
      }
      if(str[1] == '5'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r5 = str;  
        EEPROM.put(5, r5);
      }
      if(str[1] == '6'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r6 = str;  
        EEPROM.put(6, r6);
      }
      if(str[1] == '7'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r7 = str;  
        EEPROM.put(7, r7);
      }
      if(str[1] == '8'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r8 = str;  
        EEPROM.put(8, r8);
      }
      if(str[1] == '9'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r9 = str;  
        EEPROM.put(9, r9);
      }
    }
    else if(str[0]=='s'){
      x=0;
      if(str[1] == '1'){
        str.remove(0, 3);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r10 = str;  
        EEPROM.put(10, r10);
      }
    }
    else if(str[0]=='t'){
      x=0;
      if(str[1] == '1'){
        str.remove(0, 3);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r11 = str;  
        EEPROM.put(11, r11);
      }
    }
    else if(str[0]=='u'){
      x=0;
      if(str[1] == '1'){
        str.remove(0, 3);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r12 = str;  
        EEPROM.put(12, r12);
      }
    }
    
    if(str != "umidade\n")
    Serial.println(str);    

    // Aciona a valvula de cada reator de acordo com o dado enviado pelo matlab 
    if(str == "v1\n"){
      mux(0,0,0,1);
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("Reator 1");
      x=0;
    }
    else if(str == "v2\n"){
      mux(0,0,1,0);
      buzz();
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("Reator 2");
      x=0;
    }
    else if(str == "v3\n"){
      mux(0,0,1,1);
      buzz();      
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("Reator 3");
      x=0;
    }
    else if(str == "v4\n"){
      mux(0,1,0,0);
      buzz();
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("Reator 4");
      x=0;
    }
    else if(str == "v5\n"){
      mux(0,1,0,1);
      buzz();
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("Reator 5");
      x=0;
    }
    else if(str == "v6\n"){
      mux(0,1,1,0);
      buzz();
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("Reator 6");
      x=0;
    }
    else if(str == "v7\n"){
      mux(0,1,1,1);
      buzz();
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("Reator 7");
      x=0;
    }
    else if(str == "v8\n"){
      mux(1,0,0,0);
      buzz();
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("Reator 8");
      x=0;
    }
    else if(str == "v9\n"){
      mux(1,0,0,1);
      buzz();
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("Reator 9");
      x=0;
    }
    else if(str == "v10\n"){
      mux(1,0,1,0);
      buzz();
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("Reator 10");
      x=0;
    }
    else if(str == "v11\n"){
      mux(1,0,1,1);
      buzz();
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("Reator 11");
      x=0;
    }
    else if(str == "v12\n"){
      mux(1,1,0,0);
      buzz();
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("Reator 12");
      x=0;
    }
    else if(str == "b1\n"){
      mux(1,1,0,1);
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("Umidificando");
      x=0;
    }
    else if(str == "b2\n"){
      mux(1,1,1,0);
      x=0;
    }
    else if(str == "b3\n"){
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("Flush...");
      mux(1,1,1,1);
      x=0;
    }
    else if(str == "umidade\n"){
    Serial.println(leituraSensor);
    x=0;
    }
    else if(str == "fim\n"){
    flag3=1;
    flag1=0;
    buzz();
    buzz();
    buzz();
    buzz();
    buzz();    
    Timer1.initialize(500000);
    mux(0,0,0,0);
    x=0;
    }
    //Tratamento da hora
    else if(str.length() == 21){
    str.remove(6, 5);
    y = str.lastIndexOf('\n');
    str.remove(y, 1);
    t=str;
    EEPROM.put(13, t);
    }
    else{
    /*
    if(str != "v1" || str != "v2" || str != "v3" || str != "v4" || 
    str != "v5" || str != "v6" || str != "v7" || str != "v8" || 
    str != "v9" || str != "v10" || str != "v11" || str != "v12" || 
    str != "b1" || str != "b2" || str != "b3" || str != "fim"){
    x++ ;
    }
    */
    x++;
    lcd.setCursor(0,1);
    lcd.print("PPM: ");
    lcd.print(x);
    lcd.print(" -> ");
    y = str.lastIndexOf('\n');
    str.remove(y, 1);
    lcd.print(str);
        }
  str = "";  
  flag1 = false;      
  }
  //lcd.scrollDisplayLeft();
  //lcd.leftToRight();
  //lcd.autoscroll();

}
//interrupção da serial
void serialEvent() {
  Timer1.stop();
  while (Serial.available()) {
    char c = (char)Serial.read();
    //if (c != '\n')
    str += c;
    if (c == '\n') {
      flag1 = true;
      flag3 = false;
        
    }
  }
}

void mux(boolean x,boolean y,boolean z,boolean t) {
  digitalWrite(conv3, x);
  digitalWrite(conv2, y);
  digitalWrite(conv1, z);
  digitalWrite(conv0, t);
}

void leitura() {
  flag2=1;
}
void buzz(){
      analogWrite(buzzer, 200);
      delay(50);
      analogWrite(buzzer, 0);
      delay(50);
}
void flcd(){
  if(a==1){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Reator 1");
  lcd.setCursor(0,1);
  lcd.print("PPM: ");
  lcd.print(r1);
  delay(1000);
  }
  if(a==2){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Reator 2");
  lcd.setCursor(0,1);
  lcd.print("PPM: ");
  lcd.print(r2);
  delay(1000);
 }
  if(a==3){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Reator 3");
  lcd.setCursor(0,1);
  lcd.print("PPM: ");
  lcd.print(r3);
  delay(1000);
}
if(a==4){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Reator 4");
  lcd.setCursor(0,1);
  lcd.print("PPM: ");
  lcd.print(r4);
  delay(1000);
}
if(a==5){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Reator 5");
  lcd.setCursor(0,1);
  lcd.print("PPM: ");
  lcd.print(r5);
  delay(1000);
}
if(a==6){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Reator 6");
  lcd.setCursor(0,1);
  lcd.print("PPM: ");
  lcd.print(r6);
  delay(1000);
}
if(a==7){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Reator 7");
  lcd.setCursor(0,1);
  lcd.print("PPM: ");
  lcd.print(r7);
  delay(1000);
}
if(a==8){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Reator 8");
  lcd.setCursor(0,1);
  lcd.print("PPM: ");
  lcd.print(r8);
  delay(1000);
}
if(a==9){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Reator 9");
  lcd.setCursor(0,1);
  lcd.print("PPM: ");
  lcd.print(r9);
  delay(1000);
}
if(a==10){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Reator 10");
  lcd.setCursor(0,1);
  lcd.print("PPM: ");
  lcd.print(r10);
  delay(1000);
}
if(a==11){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Reator 11");
  lcd.setCursor(0,1);
  lcd.print("PPM: ");
  lcd.print(r11);
  delay(1000);
  }
if(a==12){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Reator 12");
  lcd.setCursor(0,1);
  lcd.print("PPM: ");
  lcd.print(r12);
  delay(1000);
}
if(a==13){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Ultimo Ensaio");
  lcd.setCursor(0,1);
  //lcd.print("PPM: ");
  lcd.print(t);
  delay(1000);
}
if(a==14){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Ultimo Ensaio");
  lcd.setCursor(0,1);
  //lcd.print("PPM: ");
  lcd.print(t);
  delay(1000);
}
if(a==15){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Ultimo Ensaio");
  lcd.setCursor(0,1);
  //lcd.print("PPM: ");
  lcd.print(t);
  delay(1000);
}
if(a==16){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Ultimo Ensaio");
  lcd.setCursor(0,1);
  //lcd.print("PPM: ");
  lcd.print(t);
  delay(1000);
}
if(a==16){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Ultimo Ensaio");
  lcd.setCursor(0,1);
  //lcd.print("PPM: ");
  lcd.print(t);
  delay(1000);
  a=0;
}  
  }


