From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 27 Dec 2010 01:03:06 +0000
Subject: Re: SDHI polling
Message-Id: <AANLkTik0giUa2TpgPA+k11JpDAeWOj8UyUK51sNEcPrp@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20101226224506.GD21535@verge.net.au>
In-Reply-To: <20101226224506.GD21535@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Mon, Dec 27, 2010 at 9:10 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Mon, Dec 27, 2010 at 08:34:10AM +0900, Magnus Damm wrote:
>> On Mon, Dec 27, 2010 at 8:24 AM, Paul Mundt <lethal@linux-sh.org> wrote:
>> > On Mon, Dec 27, 2010 at 07:59:15AM +0900, Magnus Damm wrote:
>> >> On Mon, Dec 27, 2010 at 7:45 AM, Simon Horman <horms@verge.net.au> wr=
ote:
>> >> > I have it in mind to run the SDHI hardware block in some sort of
>> >> > polling mode - that is, with interrupts disabled - during early
>> >> > boot. Does this make any sense?
>> >>
>> >> I guess it depends on how early you mean. =3D)
>> >>
>> >> Usually you want to make use of interrupts if they are available, but
>> >> for really early code there is no interrupt support. So the in-kernel
>> >> early printk support is implemented without any interrupts for
>> >> instance. At least this is true for the SCIF driver used by SH and
>> >> SH-Mobile / R-Mobile, pretty sure it applies to other hardware
>> >> platforms as well.
>> >>
>> >> As for the SDHI version of the MMC loader, I think you should do the
>> >> same as the MMCIF loader that is present in
>> >> include/linux/mmc/sh_mmcif.h. As you know it gets compiled into a
>> >> separate image together with the rest of the zImage loader. No
>> >> interrupt handling is available in that code, so just implementing
>> >> things using polling mode is good enough.
>> >>
>> >> I'm not 100% sure about U-boot these days, but I wouldn't be surprised
>> >> if many boot loaders only implement polling.
>> >>
>> > That's probably true, but note that most boot loaders do have rudiment=
ary
>> > interrupt stubs for the timer tick and so forth. I wouldn't classify a
>> > boot loader as early code, it's more just half-assed. For true "early"
>> > code polling is probably ok, particularly if you aren't able to contin=
ue
>> > on without reading the image from the card. You will probably still wa=
nt
>> > to be able to track various state changes in order to ease debugging a=
nd
>> > work out whether you get stuck or not. If the block raises an exception
>> > for recoverable errors and so on then you're still going to have to de=
al
>> > with an asynchronous code flow, too.
>>
>> http://git.denx.de/?p=3Du-boot.git;a=3Dblob;f=3Darch/sh/cpu/sh4/interrup=
ts.c;hi88ecc7c28d1f345ee9d0b904c8e8b4e3eb8ccb;hb=CDc51c294ad33879c4e57edf4c=
9d2155381b1d59
>
> Wow, that's really taking half-assed to a whole new level. If only it
> were possible to unsee bootloader code.

Perhaps you would like me to send links to code for other unnamed architect=
ures?

> In any event, just because the boot loader people are useless doesn't
> mean you can't set the bar a bit higher for yourself when designing new
> features.

Sure, but I don't think that raising the bar by implementing interrupt
support is a good idea in this case. This since all you're doing is
loading a kernel image from a single device.

/ magnus
