From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 09 Feb 2008 09:07:10 +0000
Subject: Re: HP6xx : weird hwclock behavior, bug?
Message-Id: <20080209090710.GA5916@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080207002825.96bfbf6b.Kristoffer.ericson@gmail.com>
In-Reply-To: <20080207002825.96bfbf6b.Kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 08, 2008 at 05:29:23PM -0300, Rafael Ignacio Zurita wrote:
> --- Paul Mundt <lethal@linux-sh.org> wrote:
> > It works fine on all of the SH-4 systems, but I don't know if anyone
> > has done any SH-3 testing with rtc-sh.
> 
> I have been testing rtc-sh today (on sh3) and it seems
> that "hwclock --systohc" does not freeze the system but it keeps
> looping calling this function:  
> static irqreturn_t sh_rtc_alarm(int irq, void *dev_id)
> 
> I've added printks and these show me that in sh_rtc_alarm() the
> code into the next "if" never is executed:
> 
>         /*
>          * If AF is set then the alarm has triggered. If we clear AF while
>          * the alarm time still matches the RTC time then AF will
>          * immediately be set again, and if AIE is enabled then the alarm
>          * interrupt will immediately be retrigger. So we clear AIE here
>          * and use rtc->rearm_aie so that the carry interrupt will keep
>          * trying to clear AF and once it stays cleared it'll re-enable
>          * AIE.
>          */
>         if (tmp & RCR1_AF) {
>                 events |= RTC_AF | RTC_IRQF;
> 
>                 tmp &= ~(RCR1_AF|RCR1_AIE);
> 
>                 writeb(tmp, rtc->regbase + RCR1);
> 
>                 rtc->rearm_aie = 1;
> 
>                 rtc_update_irq(rtc->rtc_dev, 1, events);
>         }
> 
> Perhaps it should not execute the code inside such if in this case, but 
> the system keeps looping calling to sh_rtc_alarm and it looks like a
> frozen system.
> 
> Some idea about how to debug a bit more?

The alarm code was written and tested on SH-4, it is possible that the
SH-3 has a different format or simply doesn't support the alarm at all.
The first thing to do is to look at the RCR1 definition and see how the
alarm bits are set there. If RCR1_AF isn't asserted, then either the IRQ
is spurious, or we're simply checking the wrong condition for the SH-3
case (in which case the ack'ing case won't be right either.

It's fairly trivial to conditionalize the alarm support, but up until now
the SH-3 folks have been pretty silent on the issue (especially with
regards to what works and what doesn't work). You may want to just
comment out the alarm bits for now and ensure that the rest of the code
is functional first, and then see about what's causing the problem on the
alarm side. I expect it's just a matter of bit or register definitions
being different.
