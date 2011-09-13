From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 13 Sep 2011 16:06:38 +0000
Subject: Re: [PATCH 2/5] PM / Runtime: Do not run callbacks under lock for power.irq_safe set
Message-Id: <201109131806.39050.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201108310017.03103.rjw@sisk.pl> <201109122344.02386.rjw@sisk.pl> <CACVXFVN5E6pToFk_nn0xgNrUW-DQzVssmPFDpHckSaHSRwWjoQ@mail.gmail.com>
In-Reply-To: <CACVXFVN5E6pToFk_nn0xgNrUW-DQzVssmPFDpHckSaHSRwWjoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ming Lei <tom.leiming@gmail.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>, jean.pihet@newoldbits.com

On Tuesday, September 13, 2011, Ming Lei wrote:
> Hi,
> 
> On Tue, Sep 13, 2011 at 5:44 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Hi,
> >
> > On Monday, September 12, 2011, Ming Lei wrote:
> >
> >> Hi,
> >
> >>
> >
> >> On Wed, Aug 31, 2011 at 6:20 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >
> >> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> >> >
> >
> >> > The rpm_suspend() and rpm_resume() routines execute subsystem or PM
> >
> >> > domain callbacks under power.lock if power.irq_safe is set for the
> >
> >> > given device.  This is inconsistent with that rpm_idle() does after
> >
> >> > commit 02b2677 (PM / Runtime: Allow _put_sync() from
> >
> >> > interrupts-disabled context) and is problematic for subsystems and PM
> >
> >> > domains wanting to use power.lock for synchronization in their
> >
> >> > runtime PM callbacks.  For this reason, make runtime PM core functions
> >
> >> > always release power.lock before invoking subsystem or PM domain
> >
> >>
> >
> >> If power.lock is released, the transition states(resuming or suspending)
> >
> >> may be observed in rpm_suspend or rpm_resume, then tasks schedule
> >
> >> will be produced in these two functions,
> >
> > I don't think so, because the interrupts are still off.
> 
> Yes, the interrupts are still off on local CPU, but the release of spin lock may
> cause another CPUs to run into rpm_suspend or rpm_resume and produce
> task schedule inside the two functions.

Not for the same device, though.

Also, I'm not quite sure what scenario exactly are you referring to.
Could you please give an example?

Thanks,
Rafael
