From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Mar 2014 10:40:03 +0000
Subject: Re: [RFC] Serial port aliases in DT
Message-Id: <CAMuHMdVJ8Jid=bdWLb7g5MP5dFOwDkvoHEbFH4nQD5bWp-2sxw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5448979.WQPtOb56tW@avalon>
	<6506478.py2Axu25u1@wuerfel>
	<CAMuHMdVYhGGt7+fR4oHzf-hDvTOWbHfhM2g92eo3RqULd6yR2A@mail.gmail.com>
	<14685448.67FSBAE5nm@wuerfel>
In-Reply-To: <14685448.67FSBAE5nm@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Arnd,

On Fri, Mar 28, 2014 at 11:28 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 28 March 2014 09:39:22 Geert Uytterhoeven wrote:
>> On Fri, Mar 28, 2014 at 9:30 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Friday 28 March 2014 09:09:23 Geert Uytterhoeven wrote:
>> >> On the Renesas SoCs, where this thread started, you also have different
>> >> types of IP blocks providing similar functionality on the same SoC.
>> >> E.g. 3 types of serial ports, 2 types of i2c, (at least) 2 types of spi...
>> >> Hence one more level of confusion (is SoC serial0 the first serial port of
>> >> type A, B, or C?).
>> >
>> > The 'serial' aliases are defined to refer to UARTs only, there is no debate
>> > about that.
>>
>> All 3 serial port types are UARTs.
>>
>> For the serial ports, they are sufficiently similar to use the same driver.
>> For i2c and spi, that's not the case, and they use different drivers.
>
> Ok, I see. I just misunderstood what you meant.
>
> The aliases are really meant to put all the uarts into a flat numbering space,
> regardless of the driver, and you can mix them them in any possible way. If
> a board uses one uart of each type, then serial0 through serial2 should
> point to the three that are used, but not the ones that aren't connected.

So we should move all aliases from *.dtsi to <board>.dts.

> Unfortunately, the Linux uart naming system doesn't work well with that,
> because you'd end up with something like /dev/ttyA0, /dev/ttyC1, /dev/ttyB2
> for the case that you are using the A, C and B drivers in that order.
> I would argue that we should try to fix it by changing the way that Linux
> allocates the names (in a backwards compatible way of course), not by changing
> the DT binding.

Yes!

> Using a separate name space for each driver keeps causing more problems than
> it solves, and we really should be addressing this. One way to do this
> that I think would handle it nicely is to make it optional for a uart_driver
> to provide a major/minor number range and device name for
> uart_register_driver, and move the ttyS%d namespace handling from the 8250
> driver into serial_core.c. There are a couple of open questions regarding
> how to implement backwards compatibility with the existing behavior, but
> I think it can be done.

Not serial_core.c. That's deprecated for new drivers, and we want a common
namespace across all serial drivers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
