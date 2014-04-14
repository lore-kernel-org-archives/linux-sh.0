From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Apr 2014 18:33:11 +0000
Subject: [PATCH v2 0/6] ARM: shmobile: Add rcar-gpio clock support
Message-Id: <1397500397-12607-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This series adds support to control the MSTP clocks of the GPIO blocks
on R-Car Gen2 SoCs. Currently we depend on reset state / the bootloader to
have the right clocks enabled. If they're not enabled, GPIO will fail,
but not crash:
  - No heartbeat LED (if you had it enabled),
  - Keypad switches don't work,
  - System doesn't wake-up from suspend when pressing a keypad switch.

After applying this series, the MSTP clocks of the GPIO blocks will be
enabled automatically by runtime PM (or statically, if CONFIG_PM_RUNTIME=n)
during boot up.

  - [1/6] gpio: rcar: Add optional functional clock to bindings
  - [2/6] gpio: rcar: Add minimal runtime PM support
  - [3/6] ARM: shmobile: r8a7790 dtsi: Add GPIO clocks
  - [4/6] ARM: shmobile: r8a7791 dtsi: Add GPIO clocks
  - [5/6] ARM: shmobile: r8a7790 legacy: Add GPIO clocks
  - [6/6] ARM: shmobile: r8a7791 legacy: Add GPIO clocks

For legacy, this should work as-is.
For multiplatform, this needs a method to enable drivers/sh/pm_runtime.c to
actually work.

This was tested on r8a7791/Koelsch, both legacy and multiplatform.
The changes for r8a7790 were straight-forward.
R-Car Gen1 doesn't seem to be affected, at least the r8a7778 datasheet
doesn't mention MSTP bits for GPIO modules.

Thanks for applying!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
