#include "pwm.h"
//PA2,PA3 TIM2CH34
void My_TIM2_Init(u16 arr,u16 psc)
{
	GPIO_InitTypeDef GPIO_InitStruct;//GPIO
	TIM_TimeBaseInitTypeDef TIM_TimeBaseInitStruct;//��ʱ��
	TIM_OCInitTypeDef TIM_OCInitStruct;//ͨ��
	
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA,ENABLE);//GPIOʱ�ӿ���
	RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM2,ENABLE);//��ʱ��2��ʱ��
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO,ENABLE);//���ù��ܣ�����AFIOʱ��
	
	GPIO_InitStruct.GPIO_Mode=GPIO_Mode_AF_PP;//��������
	GPIO_InitStruct.GPIO_Pin=GPIO_Pin_2|GPIO_Pin_3;
	GPIO_InitStruct.GPIO_Speed=GPIO_Speed_50MHz;
	
	TIM_TimeBaseInitStruct.TIM_ClockDivision=TIM_CKD_DIV1;//��Ƶ����
	TIM_TimeBaseInitStruct.TIM_CounterMode=TIM_CounterMode_Up;//���ϼ���
	TIM_TimeBaseInitStruct.TIM_Period=arr;//�Զ���װ��ֵ
	TIM_TimeBaseInitStruct.TIM_Prescaler=psc;//Ԥ��Ƶϵ��
	TIM_TimeBaseInit(TIM2, &TIM_TimeBaseInitStruct);
	
	TIM_OCInitStruct.TIM_OCMode=TIM_OCMode_PWM1;
	TIM_OCInitStruct.TIM_OCNPolarity=TIM_OCPolarity_High;
	TIM_OCInitStruct.TIM_OutputState=TIM_OutputState_Enable;
	
	
	GPIO_Init(GPIOA, &GPIO_InitStruct);
	TIM_OC3Init(TIM2,&TIM_OCInitStruct);//ͨ��3
	TIM_OC4Init(TIM2,&TIM_OCInitStruct);//ͨ��4
	
	TIM_OC3PreloadConfig(TIM2,TIM_OCPreload_Enable);        //ʹ��Ԥװ�ؼĴ���
	TIM_OC4PreloadConfig(TIM2,TIM_OCPreload_Enable);
  TIM_Cmd(TIM2,ENABLE);        //ʹ��TIM2
	
	//	TIM_SetCompare2(TIM2,1500);//���ñȽ�ֵ
	//	TIM_SetCompare3(TIM2,2000);//���ñȽ�ֵ
	
}
