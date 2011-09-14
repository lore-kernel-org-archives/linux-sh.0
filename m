From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 14 Sep 2011 20:45:14 +0000
Subject: Re: [PATCH 2/5] PM / Runtime: Do not run callbacks under lock for power.irq_safe set
Message-Id: <201109142245.14808.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201108310017.03103.rjw@sisk.pl> <201109131806.39050.rjw@sisk.pl> <CACVXFVMFZJioG_vgJ_tx9rA8_=H0HcKZLCyLcTu8oSSSmUoNJg@mail.gmail.com>
In-Reply-To: <CACVXFVMFZJioG_vgJ_tx9rA8_=H0HcKZLCyLcTu8oSSSmUoNJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ming Lei <tom.leiming@gmail.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>, jean.pihet@newoldbits.com

On Wednesday, September 14, 2011, Ming Lei wrote:
> Hi,
> 
> On Wed, Sep 14, 2011 at 12:06 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> >> >> If power.lock is released, the transition states(resuming or suspending)
> >> >
> >> >> may be observed in rpm_suspend or rpm_resume, then tasks schedule
> >> >
> >> >> will be produced in these two functions,
> >> >
> >> > I don't think so, because the interrupts are still off.
> >>
> >> Yes, the interrupts are still off on local CPU, but the release of spin lock may
> >> cause another CPUs to run into rpm_suspend or rpm_resume and produce
> >> task schedule inside the two functions.
> >
> > Not for the same device, though.
> 
> I think it is probable to happen on the same device in theory, see below:
> 
> - suppose irq_safe is set before calling two pm_runtime_suspend below
> - suppose this patch has been applied
> 
> CPU0						CPU1
> pm_runtime_suspend
> 	acquired power lock
> 	rpm_suspend
> 						pm_runtime_suspend
> 							spining power lock
> 	...
> 	release power lock
> 							acquired power lock
> 	run .runtime_suspend
> 							found the dev suspending
> 							wait for power state and schedule

OK, I see what the problem is.  The second CPU can see the status
being RPM_SUSPENDING in the irq_safe case, which isn't possible
without the patch.

Good catch!

I think in that case rpm_suspend() should just release the lock,
run cpu_relax(), reacquire the lock and go to the "repeat" label.

Thanks,
Rafael
