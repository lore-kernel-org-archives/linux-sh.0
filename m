From: Luca Santini <luca.santini@spesonline.com>
Date: Fri, 29 Aug 2008 08:35:43 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <48B7B4DF.5040707@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

For some reason,
i have trouble in switching from .26 to .27-rc4;

it seems i have problems in irq masking (for the smc eth chip);
now kernel/irq/manage.c outputs

[    1.462932] No set_type function for IRQ 9 (SR.IMASK)

and after initialization, when nfs boot starts
([    3.105886] Looking up port of RPC 100003/2 on 10.193.101.100)
i get a seems-infinite loop of

[    3.115338] irq 9, desc: 8c238aec, depth: 0, count: 0, unhandled: 0
[    3.117228] ->handle_irq():  8c0361d8, handle_bad_irq+0x0/0x1ac
[    3.123100] ->chip(): 8c236318, imask_irq_type+0x0/0x40
[    3.128284] ->action(): 8f9307e0
[    3.131482] ->action->handler(): 8c10dc98, smc_interrupt+0x0/0xbe4
[    3.137620] unexpected IRQ trap at vector 09

something has changed in .27 in irq management?

Luca Santini


Magnus Damm wrote:
> On Thu, Aug 28, 2008 at 12:00 PM, Paul Mundt <lethal@linux-sh.org> wrote:
>> On Wed, Aug 27, 2008 at 06:32:02PM +0200, Luca Santini wrote:
>>>>>> +static struct smc91x_platdata smc91x_info = {
>>>>>> +  .flags = SMC91X_USE_16BIT,
>>>>>> +};
>>>>>> +
>>>> For some reason your flags here and your later smc91x patch for edosk7760
>>>> have absolutely nothing in common. This leads me to believe that you
>>>> either couldn't get the dynamic configuration working, in which case this
>>>> bit of code is useless, or that it works fine and there's no need for the
>>>> changes to smc91x.h. If you need both, you are doing something very
>>>> wrong.
>>>>
>>> you're right; what i really need is
>>>
>>> #define SMC_IO_SHIFT 1
>>>
>>> but using the platdata flag
>>>
>>> SMC91X_IO_SHIFT_1
>>>
>>> doesn't work.
>>>
>> Ok, so that's a real bug then. Magnus, can you take a look at this?
> 
> The io shift platform data configuration should be generic, but it
> looks like it has been fully hooked in by some ARM platforms only at
> this point. Someone forgot to fix the generic case. Try the attached
> patch, that should get you going. Let me know if it solves your issue.
> 
> / magnus
