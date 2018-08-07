From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 07 Aug 2018 19:37:06 +0000
Subject: Re: [PATCH/RFC 4/4] sh-sci: Derive regshift value from DT compatible value
Message-Id: <CAMuHMdWgJrPRh8TRTrEjWsaRAhEQX0T7M5eBGP_z3Ft=T6FfDg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180806140755.24087-1-geert+renesas@glider.be>
 <20180806140755.24087-5-geert+renesas@glider.be> <TY1PR01MB15621F645BA5AA48C6060F0D8A200@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdWfsdbmGUQPk4O=9jyPZ_tUEytO5z2XE6-TnagJ3taPVA@mail.gmail.com> <TY1PR01MB1562F2D2FD1BF47A80B044028A270@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1562F2D2FD1BF47A80B044028A270@TY1PR01MB1562.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, uli@fpond.eu, Yoshinori Sato <ysato@users.sourceforge.jp>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>

Hi Chris,

On Tue, Aug 7, 2018 at 9:24 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Monday, August 06, 2018 1, Geert Uytterhoeven wrote:
> > > I had a simple patch to add support for CONFIG_DEBUG_LL for RZ/A2
> > > because earlycon never worked because of RZ/A2's different register
> > locations.
> >
> > Yeah, sci_probe_regmap() assumed the wrong regtype for your TYPE_SCIF
> > port. You needed an OF_EARLYCON_DECLARE() line that also filled in
> > the correct regtype.
>
>
> I gave your patch a try.
> When earlycon is enabled, on RZ/A2, it gets stuck in here:
>
> static void sci_poll_put_char(struct uart_port *port, unsigned char c)
> {
>         unsigned short status;
>
>         do {
>                 status = serial_port_in(port, SCxSR);
>         } while (!(status & SCxSR_TDxE(port)));
>
>         serial_port_out(port, SCxTDR, c);
>         sci_clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
> }
>
>
> I see that you added this:
>
> OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210", rza2_early_console_setup);
>
>  and "renesas,scif-r7s9210" matches what I have in my .dtsi.
>
> But, when I run the code, I end up in function scif_early_console_setup,
> not rza2_early_console_setup

Hmm, perhaps it doesn't pick the first/most specialized match.

> I'm assuming I'm just supposed to use this on my bootargs:
>    earlycon=scif,0xE8009000

Just "earlycon" should be sufficient. It'll find the right port from
chosen/stdout-path
in DT. Can you please retry using that?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
