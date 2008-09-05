From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 05 Sep 2008 08:30:28 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <aec7e5c30809050130r5ea7227arf0f823edfc61e2f0@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Luca,

On Fri, Sep 5, 2008 at 5:14 PM, Luca Santini
<luca.santini@spesonline.com> wrote:
> Hi Magnus,
> sorry for my late...

No worries!

> Yes, i think the patch works in 2.6.27-rcX kernel (addresses are fine and
> the chip detected) but i have the irq masking problem that i'm unable to
> resolve(my ignorance... i can't imagine what else to use than
>  make_imask_irq() - i tried your suggestion masking ALSO irqs from 48 to 52
> but with no result; i repeat, in .26 masking irq 9 works and in
> kernel/irq/manage.c compat_irq_chip_set_default_handler() is called;
> otherwise in .27 the function called is __irq_set_trigger(), but with
> chip->set_type = NULL), so my .27 kernel won't work in NFS and i can't say
> i'm 100% sure it works completely.

Good that the smc91x-patch seems to work. Regarding the irq masking
stuff, sorry for not being more clear. I'm sure you could spend some
time and fix up the imask handler, but I wonder if you really want to
do that.

We should already support your processor out-of-the box (i think, i'm
still not sure how the interrupts are connected to your board) and
that without the need for any special imask handling code. I suspect
the imask handling code is just based on older kernels where we didn't
have the interrupt configuration that the intc controller and tables
provide today.

So, please begin with remove all calls to make_imask_irq(). Then, try
IRQ4 to IRQ7. If that doesn't work, enable "individual interrupt mode"
for IRL0 to IRL3. That makes them behave like individual interrupt
pins which is a good thing.

The folliwing sh7760-specific table shows which interrupt numbers you
should pass to request_irq() or use with IORESOURCE_IRQ.

IRL0  2
IRL1  5
IRL2  8
IRL3  11
IRQ4  48
IRQ5  49
IRQ6  50
IRQ7  51

Hope this helps!

> p.s.: a little question git-related... (i'm moving my first steps with
> git..) :
>
> if i pull from
>
>        master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git
>
> it asks for a password.... ???
>
> currently, i pull from
>
>        git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git
>
> is it the same?

I'm not sure. I always use the git:// myself.

/ magnus
