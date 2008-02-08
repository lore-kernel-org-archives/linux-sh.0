From: Rafael Ignacio Zurita <rizurita@yahoo.com>
Date: Fri, 08 Feb 2008 20:29:23 +0000
Subject: Re: HP6xx : weird hwclock behavior, bug?
Message-Id: <20080208202922.GA19246@rafazurita.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20080207002825.96bfbf6b.Kristoffer.ericson@gmail.com>
In-Reply-To: <20080207002825.96bfbf6b.Kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

--- Paul Mundt <lethal@linux-sh.org> wrote:

> On Thu, Feb 07, 2008 at 12:28:25AM +0100, Kristoffer
> Ericson wrote:
> > hwclock --show = works
> > hwclock --systohc = freezes system
> > 
> > Its hard to say wether it ever worked since we
> haven't used the rtc much.
> > 
> It works fine on all of the SH-4 systems, but I
> don't know if anyone has
> done any SH-3 testing with rtc-sh.

I have been testing rtc-sh today (on sh3) and it seems
that "hwclock --systohc" does not freeze the system but it keeps
looping calling this function:  
static irqreturn_t sh_rtc_alarm(int irq, void *dev_id)

I've added printks and these show me that in sh_rtc_alarm() the
code into the next "if" never is executed:

        /*
         * If AF is set then the alarm has triggered. If we clear AF while
         * the alarm time still matches the RTC time then AF will
         * immediately be set again, and if AIE is enabled then the alarm
         * interrupt will immediately be retrigger. So we clear AIE here
         * and use rtc->rearm_aie so that the carry interrupt will keep
         * trying to clear AF and once it stays cleared it'll re-enable
         * AIE.
         */
        if (tmp & RCR1_AF) {
                events |= RTC_AF | RTC_IRQF;

                tmp &= ~(RCR1_AF|RCR1_AIE);

                writeb(tmp, rtc->regbase + RCR1);

                rtc->rearm_aie = 1;

                rtc_update_irq(rtc->rtc_dev, 1, events);
        }

Perhaps it should not execute the code inside such if in this case, but 
the system keeps looping calling to sh_rtc_alarm and it looks like a
frozen system.

Some idea about how to debug a bit more?
Regards.

Rafael 
