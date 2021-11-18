//A0  1
//A1  0
//A2  0
//A3  0
#include <pic.h>
int x = 0;
int a = 0;
int b = 0;
int c = 0;
int d = 0;

#INT_TIMER2
void  TIMER2_isr(void) 
{
x= x+1;


/*
      if(input(PIN_A0))
      d = 1;
      if(input(PIN_A1))
      c = 1;
      if(input(PIN_A2))
      b = 1;
      if(input(PIN_A3))
      a = 1;
      if(input(!PIN_A0))
      d = 0;
      if(input(!PIN_A1))
      c = 0;
      if(input(!PIN_A2))
      b = 0;
      if(input(!PIN_A3))
      a = 0;
 */    
if(x == 10) {//80ms
output_toggle(pin_A5);
x=0;
}
}

void main()
{

   enable_interrupts(INT_TIMER2);
   enable_interrupts(GLOBAL);
   setup_timer_2(T2_DIV_BY_16,249,10);      //800 us overflow, 8,0 ms interrupt
   //setup_adc_ports(ALL_ANALOG);
   //set_adc_channel(0);
   output_high(pin_b0);
   output_high(pin_b1);
   output_high(pin_b2);
   output_high(pin_b3);
   output_high(pin_b4);
   output_high(pin_b5);
   output_high(pin_b6);
   output_high(pin_b7);
   
   output_low(pin_c0);
   output_low(pin_c1);
   output_low(pin_c2);
   output_low(pin_c3);
   output_low(pin_c4);
   output_low(pin_c5);
   output_low(pin_c6);
   output_low(pin_c7);
   while(TRUE)
   {
   d = input(PIN_A0);
   c = input(PIN_A1); 
   b = input(PIN_A2);
   a = input(PIN_A3); 
      if(a==0 && b==0 && c==0 && d==0){
      output_high(pin_b0);
      output_high(pin_b1);
      output_high(pin_b2);
      output_high(pin_b3);
      output_high(pin_b4);
      output_high(pin_b5);
      output_high(pin_b6);
      output_high(pin_b7);
      output_low(pin_c0);
      output_low(pin_c1);
      output_low(pin_c2);
      output_low(pin_c3);
      output_low(pin_c4);
      output_low(pin_c5);
      output_low(pin_c6);
      output_low(pin_c7);
      }
      if(a==0 && b==0 && c==0 && d==1){
      output_high(pin_b0);
      output_low(pin_b1);
      output_high(pin_b2);
      output_high(pin_b3);
      output_high(pin_b4);
      output_high(pin_b5);
      output_high(pin_b6);
      output_high(pin_b7);
      output_low(pin_c0);
      output_low(pin_c1);
      output_low(pin_c2);
      output_low(pin_c3);
      output_low(pin_c4);
      output_low(pin_c5);
      output_low(pin_c6);
      output_low(pin_c7);
      }
      if(a==0 && b==0 && c==1 && d==0){
      output_high(pin_b0);
      output_high(pin_b1);
      output_low(pin_b2);
      output_high(pin_b3);
      output_high(pin_b4);
      output_high(pin_b5);
      output_high(pin_b6);
      output_high(pin_b7);
      output_low(pin_c0);
      output_low(pin_c1);
      output_low(pin_c2);
      output_low(pin_c3);
      output_low(pin_c4);
      output_low(pin_c5);
      output_low(pin_c6);
      output_low(pin_c7);  
      }
      if(a==0 && b==0 && c==1 && d==1){
      output_high(pin_b0);
      output_high(pin_b1);
      output_high(pin_b2);
      output_low(pin_b3);
      output_high(pin_b4);
      output_high(pin_b5);
      output_high(pin_b6);
      output_high(pin_b7);
      output_low(pin_c0);
      output_low(pin_c1);
      output_low(pin_c2);
      output_low(pin_c3);
      output_low(pin_c4);
      output_low(pin_c5);
      output_low(pin_c6);
      output_low(pin_c7);
      }
      if(a==0 && b==1 && c==0 && d==0){
      output_high(pin_b0);
      output_high(pin_b1);
      output_high(pin_b2);
      output_high(pin_b3);
      output_low(pin_b4);
      output_high(pin_b5);
      output_high(pin_b6);
      output_high(pin_b7);
      output_low(pin_c0);
      output_low(pin_c1);
      output_low(pin_c2);
      output_low(pin_c3);
      output_low(pin_c4);
      output_low(pin_c5);
      output_low(pin_c6);
      output_low(pin_c7);
      }
      if(a==0 && b==1 && c==0 && d==1){
      output_high(pin_b0);
      output_high(pin_b1);
      output_high(pin_b2);
      output_high(pin_b3);
      output_high(pin_b4);
      output_low(pin_b5);
      output_high(pin_b6);
      output_high(pin_b7);
      output_low(pin_c0);
      output_low(pin_c1);
      output_low(pin_c2);
      output_low(pin_c3);
      output_low(pin_c4);
      output_low(pin_c5);
      output_low(pin_c6);
      output_low(pin_c7);
      }
      if(a==0 && b==1 && c==1 && d==0){
      output_high(pin_b0);
      output_high(pin_b1);
      output_high(pin_b2);
      output_high(pin_b3);
      output_high(pin_b4);
      output_high(pin_b5);
      output_low(pin_b6);
      output_high(pin_b7);
      output_low(pin_c0);
      output_low(pin_c1);
      output_low(pin_c2);
      output_low(pin_c3);
      output_low(pin_c4);
      output_low(pin_c5);
      output_low(pin_c6);
      output_low(pin_c7);
      }
      if(a==0 && b==1 && c==1 && d==1){
      output_high(pin_b0);
      output_high(pin_b1);
      output_high(pin_b2);
      output_high(pin_b3);
      output_high(pin_b4);
      output_high(pin_b5);
      output_high(pin_b6);
      output_low(pin_b7);
      output_low(pin_c0);
      output_low(pin_c1);
      output_low(pin_c2);
      output_low(pin_c3);
      output_low(pin_c4);
      output_low(pin_c5);
      output_low(pin_c6);
      output_low(pin_c7);
      }
      if(a==1 && b==0 && c==0 && d==0){
      output_high(pin_b0);
      output_high(pin_b1);
      output_high(pin_b2);
      output_high(pin_b3);
      output_high(pin_b4);
      output_high(pin_b5);
      output_high(pin_b6);
      output_high(pin_b7);
      output_high(pin_c0);
      output_low(pin_c1);
      output_low(pin_c2);
      output_low(pin_c3);
      output_low(pin_c4);
      output_low(pin_c5);
      output_low(pin_c6);
      output_low(pin_c7);   
      }
      if(a==1 && b==0 && c==0 && d==1){
      output_high(pin_b0);
      output_high(pin_b1);
      output_high(pin_b2);
      output_high(pin_b3);
      output_high(pin_b4);
      output_high(pin_b5);
      output_high(pin_b6);
      output_high(pin_b7);
      output_low(pin_c0);
      output_high(pin_c1);
      output_low(pin_c2);
      output_low(pin_c3);
      output_low(pin_c4);
      output_low(pin_c5);
      output_low(pin_c6);
      output_low(pin_c7);
      }
      if(a==1 && b==0 && c==1 && d==0){
      output_high(pin_b0);
      output_high(pin_b1);
      output_high(pin_b2);
      output_high(pin_b3);
      output_high(pin_b4);
      output_high(pin_b5);
      output_high(pin_b6);
      output_high(pin_b7);
      output_low(pin_c0);
      output_low(pin_c1);
      output_high(pin_c2);
      output_low(pin_c3);
      output_low(pin_c4);
      output_low(pin_c5);
      output_low(pin_c6);
      output_low(pin_c7);
      }
      if(a==1 && b==0 && c==1 && d==1){
      output_high(pin_b0);
      output_high(pin_b1);
      output_high(pin_b2);
      output_high(pin_b3);
      output_high(pin_b4);
      output_high(pin_b5);
      output_high(pin_b6);
      output_high(pin_b7);
      output_low(pin_c0);
      output_low(pin_c1);
      output_low(pin_c2);
      output_high(pin_c3);
      output_low(pin_c4);
      output_low(pin_c5);
      output_low(pin_c6);
      output_low(pin_c7);
      }
      if(a==1 && b==1 && c==0 && d==0){
      output_high(pin_b0);
      output_high(pin_b1);
      output_high(pin_b2);
      output_high(pin_b3);
      output_high(pin_b4);
      output_high(pin_b5);
      output_high(pin_b6);
      output_high(pin_b7);
      output_low(pin_c0);
      output_low(pin_c1);
      output_low(pin_c2);
      output_low(pin_c3);
      output_high(pin_c4);
      output_low(pin_c5);
      output_low(pin_c6);
      output_low(pin_c7);
      }
      if(a==1 && b==1 && c==0 && d==1){
      output_high(pin_b0);
      output_high(pin_b1);
      output_high(pin_b2);
      output_high(pin_b3);
      output_high(pin_b4);
      output_high(pin_b5);
      output_high(pin_b6);
      output_high(pin_b7);
      output_low(pin_c0);
      output_low(pin_c1);
      output_low(pin_c2);
      output_low(pin_c3);
      output_low(pin_c4);
      output_high(pin_c5);
      output_low(pin_c6);
      output_low(pin_c7);
      }
      if(a==1 && b==1 && c==1 && d==0){
      output_high(pin_b0);
      output_high(pin_b1);
      output_high(pin_b2);
      output_high(pin_b3);
      output_high(pin_b4);
      output_high(pin_b5);
      output_high(pin_b6);
      output_high(pin_b7);
      output_low(pin_c0);
      output_low(pin_c1);
      output_low(pin_c2);
      output_low(pin_c3);
      output_low(pin_c4);
      output_low(pin_c5);
      output_high(pin_c6);
      output_low(pin_c7);
      }
      if(a==1 && b==1 && c==1 && d==1){
      output_high(pin_b0);
      output_high(pin_b1);
      output_high(pin_b2);
      output_high(pin_b3);
      output_high(pin_b4);
      output_high(pin_b5);
      output_high(pin_b6);
      output_high(pin_b7);
      output_low(pin_c0);
      output_low(pin_c1);
      output_low(pin_c2);
      output_low(pin_c3);
      output_low(pin_c4);
      output_low(pin_c5);
      output_low(pin_c6);
      output_high(pin_c7);
      }
   }

}
