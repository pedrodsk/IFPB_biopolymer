/* 06/03/2017 IFPB Controle do mux via matlab
 *  
 *  digital 7 - 4
 *  0 0 0 0 - conv3 conv2 conv1 conv0    
 *      
 */
#include "TimerOne.h"
#define conv3 7 //laranja
#define conv2 6 //verde
#define conv1 5 //amarelo
#define conv0 4 //azul
#define buzzer 11
#define rele 9
#define led 13
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
  Serial.begin(9600);
  str.reserve(25);
  pinMode(rele,OUTPUT);
  digitalWrite(rele,HIGH);
  pinMode(conv0, OUTPUT);
  pinMode(conv1, OUTPUT);
  pinMode(conv2, OUTPUT);
  pinMode(conv3, OUTPUT);
  pinMode(led, OUTPUT);
  pinMode(buzzer, OUTPUT);
  //Timer1.initialize(500000);
  Timer1.attachInterrupt(leitura);
   
}

void loop() {
  digitalWrite(led,HIGH);
  delay(100);
  digitalWrite(led,LOW);
  
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
      }
      if(str[1] == '2'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r2 = str;
      }
      if(str[1] == '3'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r3 = str;
      }
      if(str[1] == '4'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r4 = str; 
      }
      if(str[1] == '5'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r5 = str;  
      }
      if(str[1] == '6'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r6 = str;  
      }
      if(str[1] == '7'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r7 = str;  
      }
      if(str[1] == '8'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r8 = str;  
      }
      if(str[1] == '9'){
        str.remove(0, 2);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r9 = str;  
      }
    }
    else if(str[0]=='s'){
      x=0;
      if(str[1] == '1'){
        str.remove(0, 3);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r10 = str;  
      }
    }
    else if(str[0]=='t'){
      x=0;
      if(str[1] == '1'){
        str.remove(0, 3);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r11 = str;  
      }
    }
    else if(str[0]=='u'){
      x=0;
      if(str[1] == '1'){
        str.remove(0, 3);
        y = str.lastIndexOf('\n');
        str.remove(y, 1);
        r12 = str;  
      }
    }
    
    if(str != "umidade\n")
    Serial.println(str);    

    // Aciona a valvula de cada reator de acordo com o dado enviado pelo matlab 
    if(str == "v1\n"){
      mux(0,0,0,1);
      x=0;
    }
    else if(str == "v2\n"){
      mux(0,0,1,0);
      buzz();
      x=0;
    }
    else if(str == "v3\n"){
      mux(0,0,1,1);
      buzz();      
      x=0;
    }
    else if(str == "v4\n"){
      mux(0,1,0,0);
      buzz();
      x=0;
    }
    else if(str == "v5\n"){
      mux(0,1,0,1);
      buzz();
      x=0;
    }
    else if(str == "v6\n"){
      mux(0,1,1,0);
      buzz();
      x=0;
    }
    else if(str == "v7\n"){
      mux(0,1,1,1);
      buzz();
      x=0;
    }
    else if(str == "v8\n"){
      mux(1,0,0,0);
      buzz();
      x=0;
    }
    else if(str == "v9\n"){
      mux(1,0,0,1);
      buzz();
      x=0;
    }
    else if(str == "v10\n"){
      mux(1,0,1,0);
      buzz();
      x=0;
    }
    else if(str == "v11\n"){
      mux(1,0,1,1);
      buzz();
      x=0;
    }
    else if(str == "v12\n"){
      mux(1,1,0,0);
      buzz();
      x=0;
    }
    else if(str == "b1\n"){
      mux(1,1,0,1);
      x=0;
    }
    else if(str == "b2\n"){
      mux(1,1,1,0);
      x=0;
    }
    else if(str == "b3\n"){
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
    
    y = str.lastIndexOf('\n');
    str.remove(y, 1);
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

