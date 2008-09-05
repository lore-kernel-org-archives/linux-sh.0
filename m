From: Luca Santini <luca.santini@spesonline.com>
Date: Fri, 05 Sep 2008 10:16:24 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <48C106F8.6070101@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org



Magnus Damm wrote:
> Hi again Luca!
> 
> On Fri, Sep 5, 2008 at 6:50 PM, Luca Santini
> <luca.santini@spesonline.com> wrote:
>> I think i'm misunderstanding something.....
>> if i try to setup eth on irq 2 (or 5 or 8 or 11...)
>> and set the platform like this
>>
>> static void __init sh_edosk7760_init_irq(void)
>> {
>> }
>>
>> static int __init init_edosk7760_devices(void)
>> {
>>        plat_irq_setup_pins(IRQ_MODE_IRQ);
>>
>>        return platform_add_devices(edosk7760_devices,
>> ARRAY_SIZE(edosk7760_devices));
>> }
>> __initcall(init_edosk7760_devices);
> 
> Ok, looking good!
> 
>> i have the well known
>>
>> ...
>> [    1.474095] eth0: SMC91C94 (rev 9) at a2000300 IRQ 2 [nowait]
>> ... (label:)
>> [    3.112795] irq 9, desc: 8c228978, depth: 1, count: 0, unhandled: 0
>> [    3.116471] ->handle_irq():  8c0361d8, handle_bad_irq+0x0/0x1ac
>> [    3.122343] ->chip(): 8c228740, no_irq_chip+0x0/0x40
>> [    3.127267] ->action(): 00000000
>> [    3.130464]   IRQ_DISABLED set
>> ... (goto label)
> 
> It still says "irq 9", is that a coding or copy-paste mistake?
> 

No, it's a fresh grab ! Very strange.....

Trying the IORESOURCE_IRQ_HIGHLEVEL flag and irq 2 the chip isn't 
detected (-19) so of course i have no nfs transfer and no irq problems;
i tried also IORESOURCE_IRQ_LOWLEVEL instead and i get the same

	[    6.893332] unexpected IRQ trap at vector 09
	[    6.897576] irq 9, desc: 8c228978, depth: 1, count: 0, unhandled: 0

etc..


> / magnus
> 
> 
