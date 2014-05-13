From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 13 May 2014 11:37:45 +0000
Subject: [PATCH v2 0/4] pinctrl: sh-pfc: Extend Multiplatform Support
Message-Id: <1399981069-29366-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set enables multiplatform support for r8a7740, sh73a0 and r8a73a4.
It reworks the v1 submitted by Magnus Damm with modifications to the original
patches and one additional patch.

The core issue is that the mach/irq.h header isn't available for multiplatform
builds. The header is needed for the irq_pin() macro only, which is in turn
only needed to initialize the irq field of the pinmux_irq structure through
the PINMUX_IRQ macro.

As the irq field is not used in multiplatform builds we don't have to set it.
The first patch in the series thus provides a version of the PINMUX_IRQ macro
that ignores the irq argument. The remaining three patches can then just avoid
including mach/irq.h without having to touch the rest of the code.

Magnus, I've only compile-tested this series (I have no Armadillo board to
test it on anymore, remember ? :-)). Could you please give it a try ? Making
sure that GPIO keys still work should be enough.

Laurent Pinchart (1):
  pinctrl: sh-pfc: Don't set the pinmux_irq irq field for multiplatform

Magnus Damm (3):
  pinctrl: sh-pfc: r8a7740: Allow Multiplatform Build
  pinctrl: sh-pfc: sh73a0: Allow Multiplatform Build
  pinctrl: sh-pfc: r8a73a4: Allow Multiplatform Build

 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c | 3 +++
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 2 ++
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  | 2 ++
 drivers/pinctrl/sh-pfc/sh_pfc.h      | 5 +++++
 4 files changed, 12 insertions(+)

-- 
Regards,

Laurent Pinchart

