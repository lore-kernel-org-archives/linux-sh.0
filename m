From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 15 Sep 2011 10:55:37 +0000
Subject: Re: [PATCH 2/5] PM / Runtime: Do not run callbacks under lock for
Message-Id: <CACVXFVN4G==wbyVPsuDJHC_+tWX6Jdn=+3Mp+9Ji_oMxE0MNsQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201108310017.03103.rjw@sisk.pl>
	<201109131806.39050.rjw@sisk.pl>
	<CACVXFVMFZJioG_vgJ_tx9rA8_=H0HcKZLCyLcTu8oSSSmUoNJg@mail.gmail.com>
	<201109142245.14808.rjw@sisk.pl>
In-Reply-To: <201109142245.14808.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>, jean.pihet@newoldbits.com

On Thu, Sep 15, 2011 at 4:45 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, September 14, 2011, Ming Lei wrote:
>> Hi,
>>
>> On Wed, Sep 14, 2011 at 12:06 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>
>> >> >> If power.lock is released, the transition states(resuming or suspe=
nding)
>> >> >
>> >> >> may be observed in rpm_suspend or rpm_resume, then tasks schedule
>> >> >
>> >> >> will be produced in these two functions,
>> >> >
>> >> > I don't think so, because the interrupts are still off.
>> >>
>> >> Yes, the interrupts are still off on local CPU, but the release of sp=
in lock may
>> >> cause another CPUs to run into rpm_suspend or rpm_resume and produce
>> >> task schedule inside the two functions.
>> >
>> > Not for the same device, though.
>>
>> I think it is probable to happen on the same device in theory, see below:
>>
>> - suppose irq_safe is set before calling two pm_runtime_suspend below
>> - suppose this patch has been applied
>>
>> CPU0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0CPU1
>> pm_runtime_suspend
>> =A0 =A0 =A0 acquired power lock
>> =A0 =A0 =A0 rpm_suspend
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 pm_runtime_suspend
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spining power lock
>> =A0 =A0 =A0 ...
>> =A0 =A0 =A0 release power lock
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acquired power lock
>> =A0 =A0 =A0 run .runtime_suspend
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found the dev suspending
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait for power state and schedule
>
> OK, I see what the problem is. =A0The second CPU can see the status
> being RPM_SUSPENDING in the irq_safe case, which isn't possible
> without the patch.
>
> Good catch!
>
> I think in that case rpm_suspend() should just release the lock,
> run cpu_relax(), reacquire the lock and go to the "repeat" label.

Yes, it makes sense in this case.

BTW: looks like something is wrong about PM mail list, I often got
the messages below these days:

Delivery to the following recipient has been delayed:

    linux-pm@lists.linux-foundation.org

Message will be retried for 1 more day(s)


thanks,
--=20
Ming Lei
