From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 25 May 2012 03:39:06 +0000
Subject: Re: [PATCH 02/03] clocksource: em_sti: Emma Mobile STI driver V2
Message-Id: <CANqRtoS24CUp3cpoWykJ5Ty5XT3Yn+LNvGL_kF5NdEPAQL0f4A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120509143926.27521.20342.sendpatchset@w520>
	<20120509143942.27521.8595.sendpatchset@w520>
	<alpine.LFD.2.02.1205250135340.3231@ionos>
In-Reply-To: <alpine.LFD.2.02.1205250135340.3231@ionos>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, horms@verge.net.au, linux-sh@vger.kernel.org, johnstul@us.ibm.com, rjw@sisk.pl, lethal@linux-sh.org, gregkh@linuxfoundation.org, olof@lixom.net

Hi Thomas,

On Fri, May 25, 2012 at 8:42 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 9 May 2012, Magnus Damm wrote:
>> +static irqreturn_t em_sti_interrupt(int irq, void *dev_id)
>> +{
>> + =A0 =A0 struct em_sti_priv *p =3D dev_id;
>> +
>> + =A0 =A0 /* Always regprogram timer compare A */
>> + =A0 =A0 if (p->ced.mode =3D CLOCK_EVT_MODE_PERIODIC)
>> + =A0 =A0 =A0 =A0 =A0 =A0 em_sti_update(p);
>
> Why do you want to do that? The core code already handles timers which
> only support oneshot mode.

Oh, I wasn't aware that oneshot only is a valid combination. Thanks
for pointing that out, the code will surely become cleaner!

>> + =A0 =A0 spin_lock_irqsave(&p->lock, flags);
>
> Please make that a raw_spinlock.

Ok!

>> +static void em_sti_clock_event_mode(enum clock_event_mode mode,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 clock_event_device *ced)
>> +{
>> + =A0 =A0 struct em_sti_priv *p =3D ced_to_em_sti(ced);
>> +
>> + =A0 =A0 /* deal with old setting first */
>> + =A0 =A0 switch (ced->mode) {
>> + =A0 =A0 case CLOCK_EVT_MODE_PERIODIC:
>> + =A0 =A0 case CLOCK_EVT_MODE_ONESHOT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 em_sti_stop(p, USER_CLOCKEVENT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 switch (mode) {
>> + =A0 =A0 case CLOCK_EVT_MODE_PERIODIC:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&p->pdev->dev, "used for periodic clo=
ck events\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 em_sti_start(p, USER_CLOCKEVENT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 clockevents_config(&p->ced, p->rate);
>> + =A0 =A0 =A0 =A0 =A0 =A0 p->delta =3D (p->rate + HZ/2) / HZ;
>> + =A0 =A0 =A0 =A0 =A0 =A0 p->next =3D em_sti_count(p);
>> + =A0 =A0 =A0 =A0 =A0 =A0 em_sti_update(p);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> All that code in this case can go away.

Right!

>> +static void em_sti_register_clockevent(struct em_sti_priv *p)
>> +{
>> + =A0 =A0 struct clock_event_device *ced =3D &p->ced;
>> +
>> + =A0 =A0 memset(ced, 0, sizeof(*ced));
>> + =A0 =A0 ced->name =3D dev_name(&p->pdev->dev);
>> + =A0 =A0 ced->features =3D CLOCK_EVT_FEAT_PERIODIC;
>> + =A0 =A0 ced->features |=3D CLOCK_EVT_FEAT_ONESHOT;
>
> If you make that:
>
> =A0 =A0 =A0 =A0ced->features =3D CLOCK_EVT_FEAT_ONESHOT;

Gotcha!

Thanks,

/ magnus
