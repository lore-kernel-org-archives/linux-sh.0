From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 02 Feb 2015 09:45:37 +0000
Subject: Re: [RFC 4/5] ARM: shmobile: r8a7790: let rst module allow watchdog resets if desired
Message-Id: <CAMuHMdXkyeRAMWz9VHDv9fZ3nnLB_9NcjenWPLJ_En5ou_cBsw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-5-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Sun, Feb 1, 2015 at 3:47 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  arch/arm/mach-shmobile/setup-rcar-gen2.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> index e2b9bb46393d..0d408ac5b96a 100644
> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> @@ -28,7 +28,18 @@
>  #include "common.h"
>  #include "rcar-gen2.h"
>
> -#define MODEMR 0xe6160060
> +#define WDTRSTCR       0xe6160054
> +#define MODEMR         0xe6160060
> +
> +void __init rcar_gen2_wdt_rst_init(void)
> +{
> +#if defined(CONFIG_WATCHDOG)
> +       void __iomem *p = ioremap_nocache(WDTRSTCR, 4);
> +       BUG_ON(!p);
> +       iowrite32(0xa55a0000, p);

This is dangerous. If the xWDT was left running, the system will be
restarted soon.

I think clearing the xWDT reset mask should be handled in the WDT driver
itself, when enabling the watchdog.

As the wiring between WDT and reset controller differs on the various SoCs
(R-Car Gen2 uses the RST module, R-Mobile APE6 uses the SYSC module),
I was thinking about representing this into DT, e.g. adding a node for the RST:

        rst: reset-controller@e6160000 {
                compatible = "renesas,rst-r8a7791", "syscon";
                reg = <0 0xe6160000 0 0x64>;
        };

and adding a link to the RST to the wdt node:

        syscon = <&rst 0>; /* 0 for RWDT, 1 for SWDT */

On APE6 it can become a link to the SYSC instead.
It's slightly more complicated there, as we already have a driver for the
SYSC on R-Mobile (rmobile-reset), and a device node can't be bound
by both the syscon and the rmobile-reset driver.

On older SH-Mobile / R-Mobile, the link can be left out, as the reset is
not configurable on these SoCs, I think.

Do you have a better idea?

> +       iounmap(p);
> +#endif
> +}
>
>  u32 rcar_gen2_read_mode_pins(void)
>  {
> @@ -132,6 +143,9 @@ void __init rcar_gen2_timer_init(void)
>  #ifdef CONFIG_COMMON_CLK
>         rcar_gen2_clocks_init(mode);
>  #endif
> +       /* allow watchdog timers to trigger reset */
> +       rcar_gen2_wdt_rst_init();
> +
>         clocksource_of_init();
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
