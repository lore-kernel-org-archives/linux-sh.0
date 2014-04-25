From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 Apr 2014 07:11:06 +0000
Subject: Re: [PATCH/RFC] serial: sh-sci: Add device tree support for r8a7779
Message-Id: <CAMuHMdWB4ZnwyNFXMK_rdCKAMOXt+HRMZKG+j4O-tdfiP_-PLg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398322484-3630-1-git-send-email-horms+renesas@verge.net.au>
 <1418731.YSFS18bIMD@avalon> <20140425002641.GB31164@verge.net.au>
 <1922942.7jvlviEDpf@avalon>
In-Reply-To: <1922942.7jvlviEDpf@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Apr 25, 2014 at 9:05 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> +     scif0: serial@ffe40000 {
>> +             compatible = "renesas,scif", "renesas,scif-r8a7779";
>> +             reg = <0xffe40000 265>;
>> +             interrupt-parent = <&gic>;
>> +             interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
>> +             clocks = <&cpg_clocks R8A7779_CLK_P>;
>> +             clock-names = "sci_ick";
>
> Clock handling in the sh-sci driver should probably be improved. The driver
> currently requires an "sci_ick" interface clock and supports an optional
> "sci_fck" functional clock. In practice, as far as I can see, platforms that
> provide both sci_ick and sci_fck set the two clocks to the same source.

That's right. As a consequence, the clock's enable count is incremented
3 times:
  - once for fck,
  - once for ick,
  - once for generic Runtime PM using the "NULL" clock.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
