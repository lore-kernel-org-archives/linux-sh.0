From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 30 Mar 2012 08:53:35 +0000
Subject: Re: [PATCH] i2c: i2c-sh_mobile device tree support
Message-Id: <CANqRtoTERUznk7xYr5qHMP4X5cVbvUw9vLZ5X-6YFkmVf69m4Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120330084402.19597.63655.sendpatchset@w520>
	<20120330084744.GF26543@linux-sh.org>
In-Reply-To: <20120330084744.GF26543-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org

On Fri, Mar 30, 2012 at 5:47 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Fri, Mar 30, 2012 at 05:44:02PM +0900, Magnus Damm wrote:
>> +static const struct of_device_id sh_mobile_i2c_dt_ids[] __devinitconst =
=3D {
>> + =A0 =A0 { .compatible =3D "renesas,rmobile-iic", },
>> + =A0 =A0 {},
>> +};
>> +MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
>> +
> Given that this block predates R-Mobile, using the rmobile naming here is
> pretty dubious. I suppose you can have it as an alias, though.

Sure, but creating new code based an old naming conventions seem rather odd=
 too.

Of course, if you think it is cramping your SH device tree style then
we can easily add a "renesas-shmobile-iic" entry as well.

Cheers,

/ magnus
