From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 24 Oct 2015 17:42:56 +0000
Subject: Re: [RFC v2 4/5] ARM: shmobile: r8a7790: let rst module allow watchdog resets if desired
Message-Id: <CAMuHMdVn5GYV0s2xPDpnikeKK8qdmMOHbvk-DcuotUKtgv+Qpg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444632876-2672-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1444632876-2672-5-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Mon, Oct 12, 2015 at 8:54 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> index aa3339258d9c02..39976ae23a3df2 100644
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
> +       iounmap(p);
> +#endif

I think (most of) my comments from "Re: [RFC 4/5] ARM: shmobile: r8a7790: let
rst module allow watchdog resets if desired" are still valid
(http://www.spinics.net/lists/linux-sh/msg39799.html):

| This is dangerous. If the xWDT was left running, the system will be
| restarted soon.
|
| I think clearing the xWDT reset mask should be handled in the WDT driver
| itself, when enabling the watchdog.
|
| As the wiring between WDT and reset controller differs on the various SoCs
| (R-Car Gen2 uses the RST module, R-Mobile APE6 uses the SYSC module),
| I was thinking about representing this into DT, e.g. adding a node
for the RST:
|
|        rst: reset-controller@e6160000 {
|                compatible = "renesas,rst-r8a7791", "syscon";
|                reg = <0 0xe6160000 0 0x64>;
|        };
|
| and adding a link to the RST to the wdt node:
|
|        syscon = <&rst 0>; /* 0 for RWDT, 1 for SWDT */
|
| On APE6 it can become a link to the SYSC instead.
| [...]
| On older SH-Mobile / R-Mobile, the link can be left out, as the reset is
| not configurable on these SoCs, I think.

However, the below is no longer true, as syscon no longer interferes with
another driver for the same device:

| It's slightly more complicated there, as we already have a driver for the
| SYSC on R-Mobile (rmobile-reset), and a device node can't be bound
| by both the syscon and the rmobile-reset driver.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
