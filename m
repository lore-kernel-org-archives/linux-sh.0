From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 May 2012 17:06:32 +0000
Subject: Re: [PATCH] clocksource: em_sti: Emma Mobile STI driver
Message-Id: <CANqRtoRr5z2GLOfaFnRCFcsQaAaVMvkaDh2=yrhQTvNmAQN-Pg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120503125611.4314.52231.sendpatchset@w520>
	<alpine.LFD.2.02.1205072054130.6271@ionos>
In-Reply-To: <alpine.LFD.2.02.1205072054130.6271@ionos>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, horms@verge.net.au, arnd@arndb.de, linux-sh@vger.kernel.org, johnstul@us.ibm.com, rjw@sisk.pl, lethal@linux-sh.org, gregkh@linuxfoundation.org, olof@lixom.net

Hi Thomas,

On Tue, May 8, 2012 at 4:10 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 3 May 2012, Magnus Damm wrote:
>> +/* private flags */
>> +#define FLAG_CLOCKEVENT (1 << 0)
>> +#define FLAG_CLOCKSOURCE (1 << 1)
>> +
>> +static int em_sti_start(struct em_sti_priv *p, unsigned long flag)
>> +{
>> + =A0 =A0 int ret =3D 0;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&p->lock, flags);
>> +
>> + =A0 =A0 if (!(p->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D em_sti_enable(p);
>
> That's confusing. You seem to enable both CLOCKEVENT and CLOCKSOURCE
> independent of "flag" value.

Hm, I believe the idea is to check if it has been enabled already...

>> +
>> + =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 p->flags |=3D flag;
>
> And then just or "flag" ??????

... but it certainly is overly complicated. I'll rework it into
something that is easier to digest. =3D)

>> + =A0 =A0 spin_unlock_irqrestore(&p->lock, flags);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static void em_sti_stop(struct em_sti_priv *p, unsigned long flag)
>> +{
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 unsigned long f;
>> +
>> + =A0 =A0 spin_lock_irqsave(&p->lock, flags);
>> +
>> + =A0 =A0 f =3D p->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE);
>> + =A0 =A0 p->flags &=3D ~flag;
>> +
>> + =A0 =A0 if (f && !(p->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 em_sti_disable(p);
>
> Huch? If the caller wants to disable the clockevent, you stop the
> clocksource as well because em_sti_disable() stops the clock.
>
> /me is confused.

I believe the idea is that if the timer is currently enabled (f) and
if we are the last user thenthen stop.

A regular usage counter probably makes much more sense!

>> +static void em_sti_clock_event_start(struct em_sti_priv *p)
>> +{
>> + =A0 =A0 struct clock_event_device *ced =3D &p->ced;
>> +
>> + =A0 =A0 em_sti_start(p, FLAG_CLOCKEVENT);
>> +
>> + =A0 =A0 /* TODO: calculate good shift from rate and counter bit width =
*/
>> +
>> + =A0 =A0 ced->shift =3D 32;
>> + =A0 =A0 ced->mult =3D div_sc(p->rate, NSEC_PER_SEC, ced->shift);
>
> IIRC, we have a generic function to do that :)

Ok, thanks for pointing that out. Need to look it up!

Will update and post a V2. Thanks for your help!

Cheers,

/ magnus
