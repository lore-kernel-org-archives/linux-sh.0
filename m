From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Sun, 17 Feb 2008 20:12:06 +0000
Subject: Re: HP6xx : weird hwclock behavior, bug?
Message-Id: <20080217211206.1e8199df.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080207002825.96bfbf6b.Kristoffer.ericson@gmail.com>
In-Reply-To: <20080207002825.96bfbf6b.Kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 13 Feb 2008 10:18:51 -0300
Rafael Ignacio Zurita <rizurita@yahoo.com> wrote:

> 
> On Sat, Feb 09, 2008 at 06:07:10PM +0900, Paul Mundt wrote:
> > On Fri, Feb 08, 2008 at 05:29:23PM -0300, Rafael Ignacio Zurita wrote:
> > > --- Paul Mundt <lethal@linux-sh.org> wrote:
> > > > It works fine on all of the SH-4 systems, but I don't know if anyone
> > > > has done any SH-3 testing with rtc-sh.
> > > 
> > > I have been testing rtc-sh today (on sh3) and it seems
> > > that "hwclock --systohc" does not freeze the system but it keeps
> > > looping calling this function:  
> > > static irqreturn_t sh_rtc_alarm(int irq, void *dev_id)
> > >...
> > >         if (tmp & RCR1_AF) {
> > >... 
> > > Perhaps it should not execute the code inside such if in this case, but 
> > > the system keeps looping calling to sh_rtc_alarm and it looks like a
> > > frozen system.
> > > 
> > > Some idea about how to debug a bit more?
> > 
> > The alarm code was written and tested on SH-4, it is possible that the
> > SH-3 has a different format or simply doesn't support the alarm at all.
> 
> SH-3 supports alarm (from the manual).
> 
> 
> > The first thing to do is to look at the RCR1 definition and see how the
> > alarm bits are set there. If RCR1_AF isn't asserted, then either the IRQ
> > is spurious, or we're simply checking the wrong condition for the SH-3
> > case (in which case the ack'ing case won't be right either.
> 
> The RCR1 definition and the manner that the alarm bits are set is ok (from
> the manual too). But RCR1_AF is not asserted and the condition check for
> SH-3 is well. I have checked the manual and the definition and i have
> not found problems there. In fact, i have also checked the sh4 manual
> and both (rtc) looks quite similar (the only difference is for the year
> register).
> 
>  
> > You may want to just
> > comment out the alarm bits for now and ensure that the rest of the code
> > is functional first, and then see about what's causing the problem on the
> > alarm side. I expect it's just a matter of bit or register definitions
> > being different.
> 
> Yep, after some re checks it seems that the problem is the sh7709
> rtc_resources definition (sh770x) which we use. It says 
> (arch/sh/kernel/cpu/sh3/setup-sh770x.c):
> 
> static struct resource rtc_resources[] = {
>         [0] =   {
>                 .start  = 0xfffffec0,
>                 .end    = 0xfffffec0 + 0x1e,
>                 .flags  = IORESOURCE_IO,
>         },
>         [1] =   {
>                 .start  = 20,
>                 .flags  = IORESOURCE_IRQ,
>         },
>         [2] =   {
>                 .start  = 21,
>                 .flags  = IORESOURCE_IRQ,
>         },
>         [3] =   {
>                 .start  = 22,
>                 .flags  = IORESOURCE_IRQ,
>         },
> };
> 
> From the manual the rtc order for the interrupt sources are:
> ATI: Alarm interrupt
> PRI: Periodic interrupt
> CUI: Carry-up interrupt
> 
> When i saw the setup for arch/sh/kernel/cpu/sh4/setup-sh7750.c it has
> commets for that resource struct:
> static struct resource rtc_resources[] = {
>         [0] = {
>                 .start  = 0xffc80000,
>                 .end    = 0xffc80000 + 0x58 - 1,
>                 .flags  = IORESOURCE_IO,
>         },
>         [1] = {
>                 /* Period IRQ */
>                 .start  = 21,
>                 .flags  = IORESOURCE_IRQ,
>         },
>         [2] = {
>                 /* Carry IRQ */
>                 .start  = 22,
>                 .flags  = IORESOURCE_IRQ,
>         },
>         [3] = {
>                 /* Alarm IRQ */
>                 .start  = 20,
>                 .flags  = IORESOURCE_IRQ,
>         },
> };
> 
> So i modified arch/sh/kernel/cpu/sh3/setup-sh770x.c to reflect the order
> and after that rtc works well. This patch reflects the changes:
> 
> --- /mnt/local/opt/sh3/kernel/linux/jlime-stable.bkp2/arch/sh/kernel/cpu/sh3/setup-sh770x.c     2008-02-06 17:25:47.000000000 -0300
> +++ setup-sh770x.c      2008-02-12 20:49:46.000000000 -0300
> @@ -130,15 +130,15 @@ static struct resource rtc_resources[] >                 .flags  = IORESOURCE_IO,
>         },
>         [1] =   {
> -               .start  = 20,
> +               .start  = 21,
>                 .flags  = IORESOURCE_IRQ,
>         },
>         [2] =   {
> -               .start  = 21,
> +               .start  = 22,
>                 .flags  = IORESOURCE_IRQ,
>         },
>         [3] =   {
> -               .start  = 22,
> +               .start  = 20,
>                 .flags  = IORESOURCE_IRQ,
>         },
>  };
> 
> Because I don't know well the rtc code I would appreciate if someone could
> say me if it would be the problem. Moreover, I don't know how to test the alarm
> code. Does somebody know?
Rafael,

It sounds like a good catch to me. Perhaps paul has some opinions about it but it would explain the bug while also proving the rtc code correct. Please send patch against paul's tree (inserted not attached) with proper subject title. Include log and Signed-off-by: tag.
If there's any issues then Im sure paul will give you feedback. Nice to know that rtc works.

> 
> Regards.
> 
> Rafael
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
