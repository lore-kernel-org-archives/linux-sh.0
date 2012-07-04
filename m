From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Wed, 04 Jul 2012 11:40:31 +0000
Subject: Re: [RFC][PATCH] ARM: shmobile: kzm9g: add r8a66597_udc support
Message-Id: <4FF42BAF.70200@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2921A.2080803@kmckk.co.jp>
In-Reply-To: <4FF2921A.2080803@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san, thank you for comment.

(2012/07/04 11:54), Kuninori Morimoto wrote:

>> Add r8a66597_udc support for CN6 connector on KZM-A9-GT board.
>> r8a66597 USB controller can not use host mode and peripheral mode
>> at the same time. At default r8a66597_udc is disabled.
>> To use r8a66597_udc define USE_R8A66597_UDC.
>>
>> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
>> ---
>> Hello,
>>
>> This is an experimental patch to test if r8a66597_udc works or not.
>> I think that using r8a66597_udc is very rare because usually r8a66597_hcd is used
>> and they can not use at the same time. So this patch is really for test and
>> I add this patch code is all inside #ifdef USE_R8A66597_UDC.
>>
>> My question, this kind of test code should not merge to mainline?
>> Or, the define USE_R8A66597_UDC should be change to CONFIG_R8A66597_UDC or so,
>> and it to Kconfig?
>
> I'm not sure the maintainer's opinion,
> but if this patch is only for the "test", then #ifdef xx_TEST_xx is better name.
>
> OTOH, if you add "choice" in Kconfig to select UDC/HCD (not for test),
> it is better for users.
>
Now in my mind, I will choose the latter. KZM-A9-GT is an *evaluation* 
board, so someone want to evaluate R8A66597_UDC.


>> +#ifdef USE_R8A66597_UDC
>> +	/*
>> +	 * Do not enable usb_host_device because r8a66597_udc and r8a66597_hcd
>> +	 * can not use at the same time.
>> +	 * Also, do not enable usbhs_device for simplify.
>> +	 */
>> +	&usb1_gadget_device,
>> +#else
>>   	&usb_host_device,
>>   	&usbhs_device,
>> +#endif
>
> Why is usbhs_device disabled for simplify ?
> what's happen if it was enabled ?
>

If the board has only one USB gadget, it is simple and almost
board has only one USB gadget.
But I don't understand yet how it works if the board has 2 or more
USB devices. Is it possible one for mass storage and the other for
ethernet over USB, or so?





