From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 08 Aug 2018 10:11:38 +0000
Subject: Re: [PATCH/RFC 4/4] sh-sci: Derive regshift value from DT compatible value
Message-Id: <CAMuHMdU4WW_Yx7P1rJjUNSaDXXcSGDAyqap1Gm9sVcDRgL09dg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180806140755.24087-1-geert+renesas@glider.be>
 <20180806140755.24087-5-geert+renesas@glider.be> <TY1PR01MB15621F645BA5AA48C6060F0D8A200@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdWfsdbmGUQPk4O=9jyPZ_tUEytO5z2XE6-TnagJ3taPVA@mail.gmail.com>
 <TY1PR01MB1562F2D2FD1BF47A80B044028A270@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdWgJrPRh8TRTrEjWsaRAhEQX0T7M5eBGP_z3Ft=T6FfDg@mail.gmail.com> <TY1PR01MB1562BACED660584300228AA08A260@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1562BACED660584300228AA08A260@TY1PR01MB1562.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, uli@fpond.eu, Yoshinori Sato <ysato@users.sourceforge.jp>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>

Hi Chris,

On Wed, Aug 8, 2018 at 2:16 AM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Tuesday, August 07, 2018, Geert Uytterhoeven wrote:
> > > I see that you added this:
> > >
> > > OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210",
> > rza2_early_console_setup);
> > >
> > >  and "renesas,scif-r7s9210" matches what I have in my .dtsi.
> > >
> > > But, when I run the code, I end up in function scif_early_console_setup,
> > > not rza2_early_console_setup
> >
> > Hmm, perhaps it doesn't pick the first/most specialized match.
>
> It seems it picks the first match.
>
> But, the table is built in the opposite order in which they are declared
> in the file. So "renesas,scif" was coming before
> "renesas,scif-r7s9210".
>
> So, by just swapping the order of "renesas,scif" and
> "renesas,scif-r7s9210" made it work!

Right, and since the RZ/A2 SCIF is not really compatible with
"renesas,scif" (see my conclusion as a reply to the cover letter), the
other order doesn't work.
BTW, I guess earlycon also works on RZ/A2 with current tty-next or
latest renesas-drivers?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
