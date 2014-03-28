From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Mar 2014 08:09:23 +0000
Subject: Re: [RFC] Serial port aliases in DT
Message-Id: <CAMuHMdUaywK4JiiKgr=6=kFoQKQuuh=+_-ThYECr53U1cuVNLA@mail.gmail.com>
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
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Mar 28, 2014 at 8:28 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Thu, Mar 27, 2014 at 07:26:27PM +0100, Arnd Bergmann wrote:
>> On Thursday 27 March 2014 16:18:29 Sascha Hauer wrote:
>> > On Thu, Mar 27, 2014 at 08:54:09AM -0500, Rob Herring wrote:
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
> I really don't think making the numbering board specific is going to
> improve the situation.

On the Renesas SoCs, where this thread started, you also have different
types of IP blocks providing similar functionality on the same SoC.
E.g. 3 types of serial ports, 2 types of i2c, (at least) 2 types of spi...
Hence one more level of confusion (is SoC serial0 the first serial port of
type A, B, or C?).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
