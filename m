From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 13 Dec 2018 18:26:59 +0000
Subject: [PATCH 00/15] pinctrl: sh-pfc: Fix config register descriptions
Message-Id: <20181213182714.26094-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

This patch series contains enhancements for config register descriptions
and their handling in the Renesas pinctrl drivers.
  - Patches 1-10 are fixes for config register descriptions, of which all
    but 6 and 10 were found by the pinmux table validation in the RFC
    patches at the end of the series,
  - Patches 11-12 are small improvements for debugging and memory
    consumption,
  - Patches 13-15 are an RFC, to add the option of doing some validation
    of all builtin pinmux tables at runtime.  While these aren't ready
    for prime-time yet, they were very valuable in finding most of the
    issues fixed above.  Hence I think it would be good to integrate an
    evolved form of them later, to help catching bugs early.
    Note that patches 13 and 14 are incomplete (the real ones are boring
    and very large), but just serve as an example.

Probably I will queue the most important fixes in sh-pfc-for-v4.21.
The rest will have to wait for v4.22.

Thanks for your comments!

Geert Uytterhoeven (15):
  pinctrl: sh-pfc: r8a77994: Remove bogus IPSR9 field
  pinctrl: sh-pfc: r8a779970: Add missing MOD_SEL0 field
  pinctrl: sh-pfc: r8a779980: Add missing MOD_SEL0 field
  pinctrl: sh-pfc: sh7734: Add missing IPSR11 field
  pinctrl: sh-pfc: r8a77990: Fix MOD_SEL0 SEL_I2C1 field width
  pinctrl: sh-pfc: r8a77995: Remove bogus SEL_PWM[0-3]_3 configurations
  pinctrl: sh-pfc: sh7264: Fix PFCR3 and PFCR0 register configuration
  pinctrl: sh-pfc: sh7269: Add missing PCIOR0 field
  pinctrl: sh-pfc: sh7734: Remove bogus IPSR10 value
  pinctrl: sh-pfc: sh7734: Fix shifted values in IPSR10
  pinctrl: sh-pfc: Print actual field width for variable-width fields
  pinctrl: sh-pfc: Make pinmux_cfg_reg.var_field_width[] variable-length
  [RFC/INCOMPLETE] pinctrl: sh-pfc: Absorb enum IDs in PINMUX_CFG_REG() macro
  [RFC/INCOMPLETE] pinctrl: sh-pfc: Absorb enum IDs in PINMUX_CFG_REG_VAR() macro
  [RFC] pinctrl: sh-pfc: Validate pinmux tables at runtime when
    debugging

 drivers/pinctrl/sh-pfc/Kconfig           |  36 ----
 drivers/pinctrl/sh-pfc/Makefile          |  13 ++
 drivers/pinctrl/sh-pfc/core.c            | 104 +++++++++++-
 drivers/pinctrl/sh-pfc/pfc-emev2.c       |  67 +++++---
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c     |  20 +--
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c     |  16 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c    | 135 ++++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c     | 101 ++++++-----
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c     | 117 +++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c     | 131 ++++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c     | 155 ++++++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a7792.c     | 134 ++++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c     | 126 ++++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 124 +++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     | 129 +++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     | 129 +++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c    | 129 +++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c    |  67 ++++----
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c    |  75 +++++----
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c    | 108 ++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c    | 105 ++++++------
 drivers/pinctrl/sh-pfc/pfc-sh7203.c      | 124 +++++++-------
 drivers/pinctrl/sh-pfc/pfc-sh7264.c      | 191 +++++++++++----------
 drivers/pinctrl/sh-pfc/pfc-sh7269.c      | 206 +++++++++++------------
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c      |  12 +-
 drivers/pinctrl/sh-pfc/pfc-sh7720.c      |  72 ++++----
 drivers/pinctrl/sh-pfc/pfc-sh7722.c      | 128 +++++++-------
 drivers/pinctrl/sh-pfc/pfc-sh7723.c      | 108 ++++++------
 drivers/pinctrl/sh-pfc/pfc-sh7724.c      | 112 ++++++------
 drivers/pinctrl/sh-pfc/pfc-sh7734.c      | 144 +++++++++-------
 drivers/pinctrl/sh-pfc/pfc-sh7757.c      | 140 +++++++--------
 drivers/pinctrl/sh-pfc/pfc-sh7785.c      |  72 ++++----
 drivers/pinctrl/sh-pfc/pfc-sh7786.c      |  44 ++---
 drivers/pinctrl/sh-pfc/pfc-shx3.c        |  16 +-
 drivers/pinctrl/sh-pfc/sh_pfc.h          |  68 ++++++--
 35 files changed, 1873 insertions(+), 1585 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
