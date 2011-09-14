From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 14 Sep 2011 01:12:35 +0000
Subject: Re: [PATCH 2/5] PM / Runtime: Do not run callbacks under lock for
Message-Id: <CACVXFVMFZJioG_vgJ_tx9rA8_=H0HcKZLCyLcTu8oSSSmUoNJg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201108310017.03103.rjw@sisk.pl>
	<201109122344.02386.rjw@sisk.pl>
	<CACVXFVN5E6pToFk_nn0xgNrUW-DQzVssmPFDpHckSaHSRwWjoQ@mail.gmail.com>
	<201109131806.39050.rjw@sisk.pl>
In-Reply-To: <201109131806.39050.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>, jean.pihet@newoldbits.com

Hi,

On Wed, Sep 14, 2011 at 12:06 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

>> >> If power.lock is released, the transition states(resuming or suspending)
>> >
>> >> may be observed in rpm_suspend or rpm_resume, then tasks schedule
>> >
>> >> will be produced in these two functions,
>> >
>> > I don't think so, because the interrupts are still off.
>>
>> Yes, the interrupts are still off on local CPU, but the release of spin lock may
>> cause another CPUs to run into rpm_suspend or rpm_resume and produce
>> task schedule inside the two functions.
>
> Not for the same device, though.

I think it is probable to happen on the same device in theory, see below:

- suppose irq_safe is set before calling two pm_runtime_suspend below
- suppose this patch has been applied

CPU0						CPU1
pm_runtime_suspend
	acquired power lock
	rpm_suspend
						pm_runtime_suspend
							spining power lock
	...
	release power lock
							acquired power lock
	run .runtime_suspend
							found the dev suspending
							wait for power state and schedule

>
> Also, I'm not quite sure what scenario exactly are you referring to.
> Could you please give an example?

I have no actual examples about it, just a theory analysis.

Also, maybe the patch below can avoid the race above.

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index a6750fc..87c9a37 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -150,6 +150,9 @@ static int rpm_check_suspend_allowed(struct device *dev)
 		retval = -EAGAIN;
 	else if (dev->power.runtime_status = RPM_SUSPENDED)
 		retval = 1;
+	else if (dev->power.runtime_status != RPM_ACTIVE &&
+			dev->power.irq_safe)
+		retval = -EAGAIN;

 	return retval;
 }


thanks,
-- 
Ming Lei
