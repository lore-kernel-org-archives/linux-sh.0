From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Sep 2015 07:33:21 +0000
Subject: [PATCH 0/9] sh-pfc: modify PINMUX_IPSR_MSEL() and r8a7795 support
Message-Id: <87wpw9jn3i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>


Hi LinusW, Laurent

These are new version of r8a7795 PFC support.
This time it includes PINMUX_IPSR_MSEL() modify patch too.

r8a7795 needs 1) 8) 9)
2) - 7) are cleanup patches, but not related to r8a7795

This time r8a7795 PFC driver is using many macros.
I took precedence "readable code" more than "80 character".
These macro are same as "datasheet" style. So, I believe review is easy.

Kuninori Morimoto (9):
      1) sh-pfc: modify PINMUX_IPSR_MSEL() macro order
      2) sh-pfc: pfc-sh7734: use PINMUX_IPSR_MSEL()
      3) sh-pfc: pfc-r8a7794: use PINMUX_IPSR_MSEL()
      4) sh-pfc: pfc-r8a7791: use PINMUX_IPSR_MSEL()
      5) sh-pfc: pfc-r8a7790: use PINMUX_IPSR_MSEL()
      6) sh-pfc: pfc-r8a7779: use PINMUX_IPSR_MSEL()
      7) sh-pfc: remove unused PINMUX_IPSR_MODSEL_DATA()
      8) sh-pfc: Initial R8A7795 PFC support
      9) sh-pfc: r8a7795: add SCIFx support

 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt |    1 +
 drivers/pinctrl/sh-pfc/Kconfig                                    |    5 +
 drivers/pinctrl/sh-pfc/Makefile                                   |    1 +
 drivers/pinctrl/sh-pfc/core.c                                     |    6 +
 drivers/pinctrl/sh-pfc/core.h                                     |    1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c                              |  420 +++++++++---------
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c                              | 1038 +++++++++++++++++++++----------------------
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c                              | 1076 ++++++++++++++++++++++----------------------
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c                              |  828 +++++++++++++++++-----------------
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c                              | 2263 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-sh7734.c                               |  778 ++++++++++++++++----------------
 drivers/pinctrl/sh-pfc/sh_pfc.h                                   |    2 -
 12 files changed, 4347 insertions(+), 2072 deletions(-)
