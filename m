From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Jan 2014 13:05:46 +0000
Subject: Re: [PATCH v4 13/14] spi: rspi: Add DT support
Message-Id: <CAMuHMdWFzJ-PfFQz-mgbtYdV9d_8=mr+F51=1Jhx0K-HrGrwFg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390553044-11860-1-git-send-email-geert@linux-m68k.org>
	<1390553044-11860-14-git-send-email-geert@linux-m68k.org>
	<20140124093349.GK15586@e106331-lin.cambridge.arm.com>
In-Reply-To: <20140124093349.GK15586-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, Jan 24, 2014 at 10:33 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> +- interrupts       : 1 interrupt for RSPI cores using a single multiplexed
>> +                  interrupt,
>> +                  3 interrupts (SPEI, SPRI, SPTI) for RSPI cores using
>> +                  separate interrupts.
>> +- interrupt-names  : Array of strings associated with the interrupt numbers:
>> +                  "error" for SPEI, "rx" for SPRI, and "tx" for SPTI.
>> +                  For RSPI cores using a single multiplexed interrupt, the
>> +                  name "mux" is optional.
>
> Rather than defining the set of interrupts twice, it would be nice to
> have interrupts defined in terms of interrupt-names:
>
> - interrupts: a list of interrupt-specifiers, one for each entry in
>   interrupt-names. If interrupt-names is not present, an interrupt
>   specifier for a single muxed interrupt.
>
> - interrupt-names: A list of interrupt names. Should contain (if
>   present):
>   * "error" for SPEI
>   * "rx" for SPRI
>   * "tx" to SPTI
>   * "mux" for a single muxed interrupt

Yes, that sounds much better, thank you.
Will update.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
