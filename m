From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Thu, 11 Jun 2009 15:51:42 +0000
Subject: Re: [PATCH] clocksource: SuperH TMU Timer driver
Message-Id: <4A31280E.3020601@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20090501065100.8800.99808.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090501065100.8800.99808.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Shin-ichiro KAWASAKI wrote:
> Paul Mundt wrote:
>> On Mon, Jun 01, 2009 at 07:50:40PM +0900, Magnus Damm wrote:
>>> 2009/5/30 Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>:
>>>> I made some investigation, and found that the warnings are printed
>>>> after zero value is set to TCOR. ?I checked SH7785 hardware manual,
>>>> but could not find any description what happens when zero value set
>>>> to TCOR.
>>> Thanks for investigating. I read a few SH manuals before converting
>>> the old driver, but I couldn't find any description of zero value.
>>> Same as you.
>>>
>>> The idea with zero value TCOR comes from the old driver. It may be
>>> there for some historical reason, or it may just be plain wrong. I've
>>> sometimes seen interrupt bursts with the old tmu driver which may be
>>> related.
>>>
>> It was mostly there just because it worked and seemed like a reasonable
>> thing to do, and because no one had any better ideas on what to do in
>> that situation. But yes, technically the behaviour is undefined, and so
>> finding something slightly more precise is a good idea.
> 
> Thank you for your explanations, Magnus, Paul!
> It has got clearer for me.
> 
> I guess there are two solutions.
> 
> i)  Add one-shot timer feature to qemu-sh's TMU emulation.
>     (Even though this feature is not documented.)
> ii) Modify sh-linux TMU driver not to set zero value to TCOR.
>     (A status will be added to sh_tmu_priv.)
> 
> I'll consider on both of them, but that will take a week or so.
> Any help from others will be appreciated.

Here's the patch which suggests TMU driver modification.

It does,
- Sets maximum value 0xffffffff to TCOR instead of zero.
  Then after one shot interrupt, next count down runs
  for a while (around seconds?)
- Stops the timer in the one shot interrupt handler.
  Then next count down does not reach to zero.

This patch assumes that while TMU counting down from 0xffffffff,
the interrupt handler finishes the task to stop the timer.

I confirmed that the timer warnings from qemu-sh disappear
with this patch.  No test is done with real hardware.

I'm not familiar with linux clock framework.
Any comments are welcome.

Regards,
Shin-ichiro KAWASAKI


diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index d6ea439..7bb0bd3 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -158,7 +158,7 @@ static void sh_tmu_set_next(struct sh_tmu_priv *p, unsigned long delta,
	if (periodic)
		sh_tmu_write(p, TCOR, delta);
	else
-		sh_tmu_write(p, TCOR, 0);
+		sh_tmu_write(p, TCOR, 0xffffffff);

	sh_tmu_write(p, TCNT, delta);

@@ -171,9 +171,10 @@ static irqreturn_t sh_tmu_interrupt(int irq, void *dev_id)
	struct sh_tmu_priv *p = dev_id;

	/* disable or acknowledge interrupt */
-	if (p->ced.mode = CLOCK_EVT_MODE_ONESHOT)
+	if (p->ced.mode = CLOCK_EVT_MODE_ONESHOT) {
+		sh_tmu_start_stop_ch(p, 0);
		sh_tmu_write(p, TCR, 0x0000);
-	else
+	} else
		sh_tmu_write(p, TCR, 0x0020);

	/* notify clockevent layer */



