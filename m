From: Simon Horman <horms@verge.net.au>
Date: Mon, 14 Apr 2014 23:06:55 +0000
Subject: Re: [PATCH v2 0/6] ARM: shmobile: Add rcar-gpio clock support
Message-Id: <20140414230655.GH22518@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1397500397-12607-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1397500397-12607-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 14, 2014 at 08:33:11PM +0200, Geert Uytterhoeven wrote:
> This series adds support to control the MSTP clocks of the GPIO blocks
> on R-Car Gen2 SoCs. Currently we depend on reset state / the bootloader to
> have the right clocks enabled. If they're not enabled, GPIO will fail,
> but not crash:
>   - No heartbeat LED (if you had it enabled),
>   - Keypad switches don't work,
>   - System doesn't wake-up from suspend when pressing a keypad switch.
> 
> After applying this series, the MSTP clocks of the GPIO blocks will be
> enabled automatically by runtime PM (or statically, if CONFIG_PM_RUNTIME=n)
> during boot up.
> 
>   - [1/6] gpio: rcar: Add optional functional clock to bindings
>   - [2/6] gpio: rcar: Add minimal runtime PM support

I believe that the above two patches need to be merged
by Linus Walleij.

>   - [3/6] ARM: shmobile: r8a7790 dtsi: Add GPIO clocks
>   - [4/6] ARM: shmobile: r8a7791 dtsi: Add GPIO clocks

The above two dtsi patches appear to depend on the new binding added
by patch 1. If that is so please repost them once the binding has been
merged.

>   - [5/6] ARM: shmobile: r8a7790 legacy: Add GPIO clocks
>   - [6/6] ARM: shmobile: r8a7791 legacy: Add GPIO clocks
> 
> For legacy, this should work as-is.

For legacy, is patch 2 required in order for patches 5 and 6 to have
any effect?

> For multiplatform, this needs a method to enable drivers/sh/pm_runtime.c to
> actually work.
> 
> This was tested on r8a7791/Koelsch, both legacy and multiplatform.
> The changes for r8a7790 were straight-forward.
> R-Car Gen1 doesn't seem to be affected, at least the r8a7778 datasheet
> doesn't mention MSTP bits for GPIO modules.

Thanks, good to know.

> Thanks for applying!
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
