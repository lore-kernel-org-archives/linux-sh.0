From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 02 Oct 2015 08:25:47 +0000
Subject: [git pull] pinctrl: sh-pfc: Updates for v4.4
Message-Id: <1443774347-383-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Linus,

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git sh-pfc-for-v4.4

for you to fetch changes up to 819fd4bfcc84805c48291de511c917596e911ffa:

  pinctrl: sh-pfc: r8a7795: add EtherAVB support (2015-10-02 09:54:41 +0200)

Summary:
  - Two fixes for incorrect pinmux data,
  - Initial r8a7795 (R-Car H3) support (incl. serial, I2C, audio,
    Ethernet),
  - Various cleanups.

Most have been acked by Laurent and/or by you.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (7):
      pinctrl: sh-pfc: Stop calling gpiochip_add_pin_range() on DT platforms
      pinctrl: sh-pfc: Remove empty gpio_function_free()
      pinctrl: sh-pfc: Confine legacy function GPIOs to SH
      pinctrl: sh-pfc: r8a7794: Remove bogus SCIF0 SCK pin data
      pinctrl: sh-pfc: r8a7791/r8a7793: Correct SCIFB1_B SCK MOD_SEL value
      pinctrl: sh-pfc: Get rid of CONFIG_ARCH_SHMOBILE_LEGACY
      pinctrl: sh-pfc: r8a7795: add SCIFx support

Kuninori Morimoto (10):
      pinctrl: sh-pfc: modify PINMUX_IPSR_MSEL() macro order
      pinctrl: sh-pfc: sh7734: use PINMUX_IPSR_MSEL()
      pinctrl: sh-pfc: r8a7794: use PINMUX_IPSR_MSEL()
      pinctrl: sh-pfc: r8a7791: use PINMUX_IPSR_MSEL()
      pinctrl: sh-pfc: r8a7790: use PINMUX_IPSR_MSEL()
      pinctrl: sh-pfc: r8a7779: use PINMUX_IPSR_MSEL()
      pinctrl: sh-pfc: remove unused PINMUX_IPSR_MODSEL_DATA()
      pinctrl: sh-pfc: r8a7795: add I2C pin support
      pinctrl: sh-pfc: r8a7795: add Audio clock pin support
      pinctrl: sh-pfc: r8a7795: add Audio SSI pin support

Laurent Pinchart (1):
      pinctrl: sh-pfc: Remove hardcoded IRQ numbers

Takeshi Kihara (2):
      pinctrl: sh-pfc: Initial R8A7795 PFC support
      pinctrl: sh-pfc: r8a7795: add EtherAVB support

 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    1 +
 drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
 drivers/pinctrl/sh-pfc/Makefile                    |    1 +
 drivers/pinctrl/sh-pfc/core.c                      |    6 +
 drivers/pinctrl/sh-pfc/core.h                      |    3 +
 drivers/pinctrl/sh-pfc/gpio.c                      |   37 +-
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c               |  116 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c               |   64 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c               |  420 +--
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c               | 1038 ++++----
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               | 1076 ++++----
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c               |  846 +++---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c               | 2817 ++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c                |   64 +-
 drivers/pinctrl/sh-pfc/pfc-sh7734.c                |  778 +++---
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |   12 +-
 16 files changed, 5047 insertions(+), 2237 deletions(-)
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a7795.c

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
