#include "pwm4.h"
//PB3 TIM2CH2
//PB0 TIM3CH3
//PB9 TIM4CH4
void My_TIM4_Init(u16 arr,u16 psc)
{
	GPIO_InitTypeDef GPIO_InitStruct;//GPIO
	TIM_TimeBaseInitTypeDef TIM_TimeBaseInitStruct;//��ʱ��
	TIM_OCInitTypeDef TIM_OCInitStruct;//ͨ��
	
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB,ENABLE);//GPIOʱ�ӿ���
	RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM4,ENABLE);//��ʱ��3��ʱ��
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO,ENABLE);//���ù��ܣ�����AFIOʱ��
	
	GPIO_InitStruct.GPIO_Mode=GPIO_Mode_AF_PP;//��������
	GPIO_InitStruct.GPIO_Pin=GPIO_Pin_9;
	GPIO_InitStruct.GPIO_Speed=GPIO_Speed_50MHz;
	GPIO_Init(GPIOB, &GPIO_InitStruct);
	
	TIM_TimeBaseInitStruct.TIM_ClockDivision=TIM_CKD_DIV1;//��Ƶ����
	TIM_TimeBaseInitStruct.TIM_CounterMode=TIM_CounterMode_Up;//���ϼ���
	TIM_TimeBaseInitStruct.TIM_Period=arr;//�Զ���װ��ֵ
	TIM_TimeBaseInitStruct.TIM_Prescaler=psc;//Ԥ��Ƶϵ��
	TIM_TimeBaseInit(TIM4, &TIM_TimeBaseInitStruct);
	
	TIM_OCInitStruct.TIM_OCMode=TIM_OCMode_PWM1;
	TIM_OCInitStruct.TIM_OCNPolarity=TIM_OCPolarity_High;
	TIM_OCInitStruct.TIM_OutputState=TIM_OutputState_Enable;
	
	
	TIM_OC4Init(TIM4,&TIM_OCInitStruct);//ͨ��3
	
	TIM_OC4PreloadConfig(TIM4,TIM_OCPreload_Enable);        //ʹ��Ԥװ�ؼĴ���
	
  TIM_Cmd(TIM4,ENABLE);        //ʹ��TIM2
	
	//	TIM_SetCompare2(TIM2,1500);//���ñȽ�ֵ
	//	TIM_SetCompare3(TIM2,2000);//���ñȽ�ֵ
	
}
