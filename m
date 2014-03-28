From: Rob Herring <robherring2@gmail.com>
Date: Fri, 28 Mar 2014 14:46:36 +0000
Subject: Re: [RFC] Serial port aliases in DT
Message-Id: <CAL_JsqLJjEkuhKWwoq_+LgX4E0=VLr-+M2aB9ejLAkKUxSBb4g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5448979.WQPtOb56tW@avalon>
	<CAL_Jsq+SWZUz4D+3pdDs5yfi_XbTODC0ytt1S5KpmR_C5vVL=A@mail.gmail.com>
	<20140327151829.GX17250@pengutronix.de>
	<4966076.uASvrV0Iy2@wuerfel>
	<20140328072827.GY17250@pengutronix.de>
In-Reply-To: <20140328072827.GY17250-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Mar 28, 2014 at 2:28 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Thu, Mar 27, 2014 at 07:26:27PM +0100, Arnd Bergmann wrote:
>> On Thursday 27 March 2014 16:18:29 Sascha Hauer wrote:
>> > On Thu, Mar 27, 2014 at 08:54:09AM -0500, Rob Herring wrote:
>> > > >>
>> > > >> > This however comes back to the more general issue of serial port device
>> > > >> > naming: Linux traditionally uses separate names per driver (e.g. ttySC0
>> > > >> > instead of ttyS0).
>> > > >> >
>> > > >> > There has been discussion in the past about changing this to let all
>> > > >> > drivers use the same namespace, but it's not yet clear to me how we'd do
>> > > >> > this in a 100% backwards compatible way. Maybe it's best left to udev to
>> > > >> > figure out the driver independent name, but then we definitely should use
>> > > >> > the alias for that name.
>> > >
>> > > This discussion has come up in just the last month or so.
>> > >
>> > > My opinion is device name numbering should start at 0 with 0 being the
>> > > preferred console device.
>> >
>> > That's completely different to everything I've heard and seen so far
>> >
>> > For specifying the console we have the linux,stdout-path property in the
>> > chosen node. My preferred console may not be a serial port at all in
>> > which case I would end up with a serial0 = &lcd0 alias.
>>
>> Agreed. Also, don't we already have /dev/console for the preferred console
>> device?
>>
>> >  Many
>> > devicetrees specify aliases for i2c/spi/mmc controllers aswell.  Should
>> > they order their i2c controllers in the order of preference now?
>> >
>> > Most dtsi files in the kernel specify a SoC specific order of aliases
>> > and I think this makes the most sense.
>>
>> I disagree with this one: the aliases should be a board specific
>> property, if not settable in the boot loader. This is how it traditionally
>> work on OF, and I think it's the most sensible approach for end users:
>> If the machine has multiple serial ports coming out the back, they are
>> normally numbered in some way, and the numbers should match what you
>> see in the OS, regardless of what the SoC calls them.
>
> Freescale starts numbering the devices at 1, Linux normally starts at 0.
> This leads to enough confusion already. I really don't want to have an
> additional board vendor specific translation. This would mean when
> talking about an UART we would not only have to make clear whether we
> mean freescale numbering or Linux numbering, but also whether we me mean
> board vendor numbering. Things like earlyprintk would still have the SoC
> numbering. Bootloaders which still use the SoC numbering would add to
> the confusion.

I'm working on a series to support early console from command line or
DT (linux,stdout-path). This should mostly replace using DEBUG_LL for
earlyprintk (although they can coexist).

> I really don't think making the numbering board specific is going to
> improve the situation.

The way I look at is if I pick-up any board with UARTs labeled in some
way with ordering whether it is 0,1,2; 1,2,3; or A,B,C that I can
count on connecting to the 1st port and get a console on /dev/ttyS0. I
really don't care what physical UART that corresponds to and I don't
want to have to go look it up on every different board. That works on
any PC ever made no matter what chipset. It should be for ARM as well.
We should be designing things to just work for an experienced Linux
user, not someone familiar with particular h/w knowledge. Of course we
are not there yet with separate namespaces for each UART, but that is
a kernel problem which we need to fix.

Rob
