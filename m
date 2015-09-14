From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Sep 2015 12:26:45 +0000
Subject: Re: [PATCH 00/14] SCI clocks cleanup
Message-Id: <CAMuHMdWKW5cbFpmX3eqkmHaaXESaBcSA=i+jRSvPXBvnGh5fQA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442232876-27629-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442232876-27629-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Mon, Sep 14, 2015 at 2:14 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The SCI driver currently handles two clocks, an interface clock named sci_ick
> and a functional clock named sci_fck. Studying the datasheets of the SH and
> ARM SoCs that incorportate (H)SCI(F)([AB]) instances showed (un)surprisingly
> that the hardware doesn't have a separate controllable interface clock.
>
> All the platforms that declare an interface clock for the SCI set it to the
> clock used as the SCI functional clock. The two clocks can thus be merged on
> the driver side, which is what this patch series does. The resulting clock is
> called "fck", and all SH and ARM users (both DT and non-DT) are fixed to name
> their SCI clocks appropriately.
>
> Support for the "sci_ick" name is kept in the sh-sci driver to ensure DT
> backward compatibility, and support for the "peripheral_clk" clock to not
> break SH platforms that don't declare device-specific SCI clocks. The later
> can be removed when all SH platforms will declare their SCI clocks properly.
>
> The patches have been developed for an ancien (v3.x for those who were born)
> kernel and rebased on top of Simon's master branch. I've only compile-tested
> them after the rebase. Geert, I believe this series is a good preliminary
> cleanup for the SCI baud rate generator clock support. Could you give it a try
> as part of your work on that ?

Thanks a lot!

There are a few more to fix up:
  - The example in new
    Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt
  - New arch/arm64/boot/dts/renesas/r8a7795.dtsi
  - The new old kid on the block: arch/h8300/boot/dts

I believe we can easily handle those.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
