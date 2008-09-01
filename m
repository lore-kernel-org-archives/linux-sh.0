From: Luca Santini <luca.santini@spesonline.com>
Date: Mon, 01 Sep 2008 08:11:33 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <48BBA3B5.5020108@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

thanks for reply Magnus,
in 2.6.26 everything works fine with irq 9;
trying to debug a little kernel/irq/manage.c i found that
in 2.6.26 in function setup_irq()
	
	compat_irq_chip_set_default_handler(desc);

is called;

otherwise in 2.6.27-rc4 :

	__irq_set_trigger()

is called with
	chip->set_type = NULL


i tried (for debug) to force in smc91x.h
	#define SMC_IRQ_FLAGS           0
to force using 	compat_irq_chip_set_default_handler(desc);
but what i get is a loop of

"Unable to handle kernel NULL pointer dereference..."



i'll try your suggestion!


Magnus Damm wrote:
> On Fri, Aug 29, 2008 at 5:35 PM, Luca Santini
> <luca.santini@spesonline.com> wrote:
>> For some reason,
>> i have trouble in switching from .26 to .27-rc4;
>>
>> it seems i have problems in irq masking (for the smc eth chip);
>> now kernel/irq/manage.c outputs
>>
>> [    1.462932] No set_type function for IRQ 9 (SR.IMASK)
>>
>> and after initialization, when nfs boot starts
>> ([    3.105886] Looking up port of RPC 100003/2 on 10.193.101.100)
>> i get a seems-infinite loop of
>>
>> [    3.115338] irq 9, desc: 8c238aec, depth: 0, count: 0, unhandled: 0
>> [    3.117228] ->handle_irq():  8c0361d8, handle_bad_irq+0x0/0x1ac
>> [    3.123100] ->chip(): 8c236318, imask_irq_type+0x0/0x40
>> [    3.128284] ->action(): 8f9307e0
>> [    3.131482] ->action->handler(): 8c10dc98, smc_interrupt+0x0/0xbe4
>> [    3.137620] unexpected IRQ trap at vector 09
>>
>> something has changed in .27 in irq management?
> 
> I don't think so. Are you sure about the value 9 for IRQ?
> 
> Since there is no external interrupt controller code I assume the SMC
> chip is connected directly to the processor. I would guess using pin
> IRQ4, IRQ5, IRQ6 or IRQ7. Try using interrupt numbers from 48 (IRQ4)
> to 51 (IRQ7) and see if that helps!
> 
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
