From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Apr 2014 20:09:00 +0000
Subject: Re: [RFC/PATCH 5/6] ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT
Message-Id: <CAMuHMdXS4KVBye1_WN-z-PGk8GNyM3rcYpVWYpR+N=p6sQRMdw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398817906-6023-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398817906-6023-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 30, 2014 at 6:21 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> > > > --- a/arch/arm/mach-shmobile/board-lager-reference.c
>> > > > +++ b/arch/arm/mach-shmobile/board-lager-reference.c
>> > > > @@ -91,16 +91,6 @@ static void __init lager_add_du_device(void)
>> > > >   */
>> > > >  static const struct clk_name clk_names[] __initconst = {
>> > > >         { "cmt0", NULL, "sh_cmt.0" },
>> > > > -       { "scifa0", NULL, "sh-sci.0" },
>> > > > -       { "scifa1", NULL, "sh-sci.1" },
>> > > > -       { "scifb0", NULL, "sh-sci.2" },
>> > > > -       { "scifb1", NULL, "sh-sci.3" },
>> > > > -       { "scifb2", NULL, "sh-sci.4" },
>> > > > -       { "scifa2", NULL, "sh-sci.5" },
>> > > > -       { "scif0", NULL, "sh-sci.6" },
>> > > > -       { "scif1", NULL, "sh-sci.7" },
>> > > > -       { "hscif0", NULL, "sh-sci.8" },
>> > > > -       { "hscif1", NULL, "sh-sci.9" },
>> > > >         { "du0", "du.0", "rcar-du-r8a7790" },
>> > > >         { "du1", "du.1", "rcar-du-r8a7790" },
>> > > >         { "du2", "du.2", "rcar-du-r8a7790" },
>> > >
>> > > Is this correct. Magnus seemed to think otherwise for a slightly
>> > > different change I proposed for Marzen.
>
> The clk_names array workaround is only needed to expose DT-defined clocks to
> non-DT devices. Now that the SCIF devices are instantiated from DT, we don't
> need SCIF entries in the array anymore.
>
> The clk_enables array workaround is needed for drivers that don't enable the
> device clock(s) manually and instead rely on runtime PM to do so. As the sh-
> sci driver enables the clock manually there's no need to add SCIF entries to
> the clk_enables array.

Yes indeed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
