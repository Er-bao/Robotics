#include "myus.h"

void My_US_Init(void)
{
	GPIO_InitTypeDef GPIO_InitStrue;//GPIO
	USART_InitTypeDef USART_InitStrue;//USART
	NVIC_InitTypeDef NVIC_InitStrue;//�ж�
	//���������ṹ��
	
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA,ENABLE);//ʹ��GPIO,��PA9��PA10
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_USART1,ENABLE);//ʹ�ܴ��ڣ����ڣ�GPIO��ʱ��ʹ��
	
	//��ʼ��GPIO
	//PA9-TX,PA10-RX
	GPIO_InitStrue.GPIO_Mode=GPIO_Mode_AF_PP;//��������
	GPIO_InitStrue.GPIO_Pin=GPIO_Pin_9;
	GPIO_InitStrue.GPIO_Speed=GPIO_Speed_10MHz;
	GPIO_Init(GPIOA,&GPIO_InitStrue);
	
	GPIO_InitStrue.GPIO_Mode=GPIO_Mode_IN_FLOATING;//����
	GPIO_InitStrue.GPIO_Pin=GPIO_Pin_10;
	GPIO_InitStrue.GPIO_Speed=GPIO_Speed_10MHz;
	GPIO_Init(GPIOA,&GPIO_InitStrue);
	
	//��ʼ������
	USART_InitStrue.USART_BaudRate=9600;//9600,115200,38400,���Ը�
	USART_InitStrue.USART_HardwareFlowControl=USART_HardwareFlowControl_None;//��ʹ��Ӳ����
	USART_InitStrue.USART_Mode=USART_Mode_Rx |USART_Mode_Tx ;//RXTX��Ҫ
	USART_InitStrue.USART_Parity=USART_Parity_No;//������żУ��
	USART_InitStrue.USART_StopBits=USART_StopBits_1;//ֹͣλΪ1
	USART_InitStrue.USART_WordLength=USART_WordLength_8b;//û����żУ�飬8λ������żУ�飬9λ
	USART_Init(USART1,&USART_InitStrue);
	
	USART_Cmd(USART1,ENABLE);//ʹ�ܴ���
	
	//�����ж� 
	USART_ITConfig(USART1,USART_IT_RXNE,ENABLE);//ITConfig������ʲô����¿����ж� ���ջ������ǿ�
	
	//��ʼ���ж�
	NVIC_InitStrue.NVIC_IRQChannel=USART1_IRQn;//����1���жϣ����Ը�
	NVIC_InitStrue.NVIC_IRQChannelCmd=ENABLE;
	NVIC_InitStrue.NVIC_IRQChannelPreemptionPriority=1;//��ռ���ȼ�
	NVIC_InitStrue.NVIC_IRQChannelSubPriority=1;
	NVIC_Init(&NVIC_InitStrue);//�жϳ�ʼ��


}

void USART1_IRQHandler(void)
{
	uint16_t res;
	if(USART_GetITStatus(USART1,USART_IT_RXNE)!= RESET)
	{
		res=USART_ReceiveData(USART1);
//		USART_SendData(USART1,res);
		
		if(res<=85&&res>0)
		{
				res=res-0;
				TIM_SetCompare2(TIM2,((1000*res-68000)/153+1500));//500/20000=0.5/20
				USART_SendData(USART1,((1000*res-68000)/153+1500));	
		}
		else if(res>85&&res<=170)
		{
				res=res-85;
				TIM_SetCompare3(TIM3,((1000*res-68000)/153+1500));//500/20000=0.5/20
				USART_SendData(USART1,((1000*res-68000)/153+1500));			
		}
		else if(res>170&&res<=255)
		{
				res=res-170;
				TIM_SetCompare4(TIM4,((1000*res-68000)/153+1500));//500/20000=0.5/20
				USART_SendData(USART1,((1000*res-68000)/153+1500));			
		}
		else
		{				
				TIM_SetCompare2(TIM2,1500);
				TIM_SetCompare3(TIM3,1500);
				TIM_SetCompare4(TIM4,1500);
				USART_SendData(USART1,res);			
		}
//		if(res<=0x32)//50)
//		{
//				res=res-0;
//				TIM_SetCompare2(TIM2,((res*2-20)*1000/90+1500));//500/20000=0.5/20
//				USART_SendData(USART1,((res*2-20)*1000/90+1500));	
//		}
//		else if(res>=0x64&&res<=0x96)
//		{
//				res=res-0x64;
//				TIM_SetCompare3(TIM3,((res*2-20)*1000/90+1500));//500/20000=0.5/20
//				USART_SendData(USART1,((res*2-20)*1000/90+1500));			
//		}
//		else if(res>=0xC8&&res<=0xFA)
//		{
//				res=res-0xC8;
//				TIM_SetCompare4(TIM4,((res*2-20)*1000/90+1500));//500/20000=0.5/20
//				USART_SendData(USART1,((res*2-20)*1000/90+1500));			
//		}
//		else
//		{				
//				TIM_SetCompare2(TIM2,1500);
//				TIM_SetCompare3(TIM3,1500);
//				TIM_SetCompare4(TIM4,1500);
//				USART_SendData(USART1,res);			
//		}

		USART_ClearITPendingBit(USART1,USART_IT_RXNE);

	}
}
//		switch(res)
//		{
//			case 0x01:
//				TIM_SetCompare2(TIM2,500*res);//500/20000=0.5/20
//				USART_SendData(USART1,res);
//				break;
//			case 0x02:
//				TIM_SetCompare2(TIM2,500*res);//500/20000=0.5/20
//				USART_SendData(USART1,res);
//				break;
//			case 0x03:
//				TIM_SetCompare2(TIM2,500*res);//500/20000=0.5/20
//				USART_SendData(USART1,res);
//				break;
//			case 0x04:
//				TIM_SetCompare2(TIM2,500*res);//500/20000=0.5/20
//				USART_SendData(USART1,res);
//				break;
//			default:
//			TIM_SetCompare2(TIM2,1500);//500/20000=0.5/20
//				USART_SendData(USART1,res);
//				break;
//		}	
