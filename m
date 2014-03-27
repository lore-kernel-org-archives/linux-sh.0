From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Mar 2014 20:47:35 +0000
Subject: [PATCH 0/7] ARM: shmobile: Add rcar-gpio clock support
Message-Id: <1395953262-4290-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This series adds support to control the MSTP clocks of the GPIO blocks
on R-Car SoCs. Currently we depend on reset state / the bootloader to
have the right clocks enabled. If they're not enabled, GPIO will fail,
but not crash:
  - No heartbeat LED (if you had it enabled),
  - Keypad switches don't work,
  - System doesn't wake-up from suspend when pressing a keypad switch.

After applying this series, the MSTP clocks of the GPIO blocks will be
enabled automatically by runtime PM (or statically, if CONFIG_PM_RUNTIME=n)
during boot up.

    [1/7] gpio: rcar: Add helper variable dev = &pdev->dev
    [2/7] gpio: rcar: Add optional functional clock to bindings
    [3/7] gpio: rcar: Add minimal runtime PM support
    [4/7] ARM: shmobile: r8a7790 dtsi: Add GPIO clocks
    [5/7] ARM: shmobile: r8a7791 dtsi: Add GPIO clocks
    [6/7] ARM: shmobile: r8a7790 legacy: Add GPIO clocks
    [7/7] ARM: shmobile: r8a7791 legacy: Add GPIO clocks

For multiplatform, this depends on the series "[PATCH 0/5] ARM: shmobile:
Enable drivers/sh/pm_runtime.c on multi-platform" (or any other method
to enable drivers/sh/pm_runtime.c) to actually work.

For legacy, this slightly conflicts with that series, as
sh_pm_runtime_init() will be called too late to actually work.

However, it should be safe to apply this series, even without the
prerequisites.

This was tested on r8a7791/Koelsch, both legacy and multiplatform.
The changes for r8a7790 were straight-forward.
Similar changes will have to be made for r8a7778 and r8a7779, but I don't
have datasheets for those.

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

