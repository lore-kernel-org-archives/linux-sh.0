From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 27 Mar 2014 15:18:29 +0000
Subject: Re: [RFC] Serial port aliases in DT
Message-Id: <20140327151829.GX17250@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <5448979.WQPtOb56tW@avalon>
 <2488692.p5nEA6pWSY@wuerfel>
 <1454965.NzCSO7fLpj@avalon>
 <9498012.PtNMJ9hipe@avalon>
 <CAL_Jsq+SWZUz4D+3pdDs5yfi_XbTODC0ytt1S5KpmR_C5vVL=A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+SWZUz4D+3pdDs5yfi_XbTODC0ytt1S5KpmR_C5vVL=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Mar 27, 2014 at 08:54:09AM -0500, Rob Herring wrote:
> >>
> >> > This however comes back to the more general issue of serial port device
> >> > naming: Linux traditionally uses separate names per driver (e.g. ttySC0
> >> > instead of ttyS0).
> >> >
> >> > There has been discussion in the past about changing this to let all
> >> > drivers use the same namespace, but it's not yet clear to me how we'd do
> >> > this in a 100% backwards compatible way. Maybe it's best left to udev to
> >> > figure out the driver independent name, but then we definitely should use
> >> > the alias for that name.
> 
> This discussion has come up in just the last month or so.
> 
> My opinion is device name numbering should start at 0 with 0 being the
> preferred console device.

That's completely different to everything I've heard and seen so far ;)

For specifying the console we have the linux,stdout-path property in the
chosen node. My preferred console may not be a serial port at all in
which case I would end up with a serial0 = &lcd0 alias.  Many
devicetrees specify aliases for i2c/spi/mmc controllers aswell.  Should
they order their i2c controllers in the order of preference now?

Most dtsi files in the kernel specify a SoC specific order of aliases
and I think this makes the most sense.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
