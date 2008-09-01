From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Mon, 01 Sep 2008 01:24:16 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <aec7e5c30808311824y5936eaaet8a5ff770dcb813d@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 29, 2008 at 5:35 PM, Luca Santini
<luca.santini@spesonline.com> wrote:
> For some reason,
> i have trouble in switching from .26 to .27-rc4;
>
> it seems i have problems in irq masking (for the smc eth chip);
> now kernel/irq/manage.c outputs
>
> [    1.462932] No set_type function for IRQ 9 (SR.IMASK)
>
> and after initialization, when nfs boot starts
> ([    3.105886] Looking up port of RPC 100003/2 on 10.193.101.100)
> i get a seems-infinite loop of
>
> [    3.115338] irq 9, desc: 8c238aec, depth: 0, count: 0, unhandled: 0
> [    3.117228] ->handle_irq():  8c0361d8, handle_bad_irq+0x0/0x1ac
> [    3.123100] ->chip(): 8c236318, imask_irq_type+0x0/0x40
> [    3.128284] ->action(): 8f9307e0
> [    3.131482] ->action->handler(): 8c10dc98, smc_interrupt+0x0/0xbe4
> [    3.137620] unexpected IRQ trap at vector 09
>
> something has changed in .27 in irq management?

I don't think so. Are you sure about the value 9 for IRQ?

Since there is no external interrupt controller code I assume the SMC
chip is connected directly to the processor. I would guess using pin
IRQ4, IRQ5, IRQ6 or IRQ7. Try using interrupt numbers from 48 (IRQ4)
to 51 (IRQ7) and see if that helps!

/ magnus
