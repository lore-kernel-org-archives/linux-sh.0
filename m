From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 13 Sep 2011 01:22:43 +0000
Subject: Re: [PATCH 2/5] PM / Runtime: Do not run callbacks under lock for
Message-Id: <CACVXFVN5E6pToFk_nn0xgNrUW-DQzVssmPFDpHckSaHSRwWjoQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201108310017.03103.rjw@sisk.pl>
	<201108310020.26104.rjw@sisk.pl>
	<CACVXFVPshpc-aVHGMYWkthffMRYLFh4BadnEAhf+eQ47CwWLZw@mail.gmail.com>
	<201109122344.02386.rjw@sisk.pl>
In-Reply-To: <201109122344.02386.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>, jean.pihet@newoldbits.com

Hi,

On Tue, Sep 13, 2011 at 5:44 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> On Monday, September 12, 2011, Ming Lei wrote:
>
>> Hi,
>
>>
>
>> On Wed, Aug 31, 2011 at 6:20 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
>> > From: Rafael J. Wysocki <rjw@sisk.pl>
>
>> >
>
>> > The rpm_suspend() and rpm_resume() routines execute subsystem or PM
>
>> > domain callbacks under power.lock if power.irq_safe is set for the
>
>> > given device. =A0This is inconsistent with that rpm_idle() does after
>
>> > commit 02b2677 (PM / Runtime: Allow _put_sync() from
>
>> > interrupts-disabled context) and is problematic for subsystems and PM
>
>> > domains wanting to use power.lock for synchronization in their
>
>> > runtime PM callbacks. =A0For this reason, make runtime PM core functio=
ns
>
>> > always release power.lock before invoking subsystem or PM domain
>
>>
>
>> If power.lock is released, the transition states(resuming or suspending)
>
>> may be observed in rpm_suspend or rpm_resume, then tasks schedule
>
>> will be produced in these two functions,
>
> I don't think so, because the interrupts are still off.

Yes, the interrupts are still off on local CPU, but the release of spin loc=
k may
cause another CPUs to run into rpm_suspend or rpm_resume and produce
task schedule inside the two functions.

>
>> so the functions below can't be
>
>>
>
>> pm_runtime_suspend()
>
>> pm_runtime_autosuspend()
>
>> pm_runtime_resume()
>
>> pm_runtime_put_sync_suspend()
>
>> pm_runtime_put_sync_autosuspend()
>
>>
>
>> called in irq-off contexts safely even though irq_safe flag is set.
>
> The patch doesn't cause rpm_suspend() and rpm_resume() to turn interrupts
>
> on if irq_safe is set, it only causes them to release the lock
> (temporarily).


thanks,
--=20
Ming Lei
