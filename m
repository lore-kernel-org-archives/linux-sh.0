From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 06 Nov 2014 11:52:05 +0000
Subject: [PATCH 0/5] ARM: shmobile: sh73a0/r8a73a4: i2c-sh_mobile fixes
Message-Id: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

	Hi Wolfram, Simon, Magnus,

This patch series revives i2c on sh73a0/kzm9g (both legacy and reference), and
on r8a73a4/ape6evm (reference).

On these SoCs, the operating clock runs faster that on previous SoCs,
and the internal SCL clock counter gets incremented every 2 clocks of
the operating clock, just like on R-Car Gen2. But if this knowledge is not
available to the driver, probing fails with e.g.

    i2c-sh_mobile i2c-sh_mobile.0: timing values out of range: L/H=0x208/0x1bf
    sh_mobile: probe of i2c-sh_mobile.0 failed with error -22

The series also updates the binding documentation to list the various
SoC-specific compatible properties, to allow checkpatch to validate DTSes.

This was tested on sh73a0/kzm9g (both legacy and reference).
This was not tested on r8a73a4/ape6evm due to lack of hardware.

Geert Uytterhoeven (5):
  ARM: shmobile: kzm9g legacy: Set i2c clks_per_count to 2
  i2c: sh_mobile: Add support for r8a73a4 and sh73a0
  i2c: sh_mobile: Document SoC-specific bindings
  ARM: shmobile: sh73a0 dtsi: Add SoC-specific IIC compatible properties
  ARM: shmobile: r8a73a4 dtsi: Add SoC-specific IIC compatible
    properties

 .../devicetree/bindings/i2c/i2c-sh_mobile.txt        |  9 +++++++++
 arch/arm/boot/dts/r8a73a4.dtsi                       | 18 +++++++++---------
 arch/arm/boot/dts/sh73a0.dtsi                        | 10 +++++-----
 arch/arm/mach-shmobile/setup-sh73a0.c                | 20 ++++++++++++++++++++
 drivers/i2c/busses/i2c-sh_mobile.c                   | 14 ++++++++------
 5 files changed, 51 insertions(+), 20 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
