From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 10 Jun 2016 10:05:01 +0000
Subject: [PATCH 1/3] pinctrl: sh-pfc: Move SoC-specific forward declarations to sh_pfc.h
Message-Id: <1465553103-6345-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1465553103-6345-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1465553103-6345-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Laxman Dewangan <ldewangan@nvidia.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

With C=1:

    drivers/pinctrl/sh-pfc/pfc-emev2.c:1695:30: warning: symbol 'emev2_pinmux_info' was not declared. Should it be static?
    drivers/pinctrl/sh-pfc/pfc-r8a7779.c:3888:30: warning: symbol 'r8a7779_pinmux_info' was not declared. Should it be static?

Note that there are more warnings on SH.

The sh_pfc_soc_info structure is defined in sh_pfc.h, while all forward
declarations for the SoC-specific versions are in core.h.
Move the forward declarations from core.h to sh_pfc.h to fix this.

Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.h   | 24 ------------------------
 drivers/pinctrl/sh-pfc/sh_pfc.h | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index dc1b2adb24c5c588..539ec7dc0b644dbe 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -67,28 +67,4 @@ void sh_pfc_write_reg(struct sh_pfc *pfc, u32 reg, unsigned int width,
 int sh_pfc_get_pin_index(struct sh_pfc *pfc, unsigned int pin);
 int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type);
 
-extern const struct sh_pfc_soc_info emev2_pinmux_info;
-extern const struct sh_pfc_soc_info r8a73a4_pinmux_info;
-extern const struct sh_pfc_soc_info r8a7740_pinmux_info;
-extern const struct sh_pfc_soc_info r8a7778_pinmux_info;
-extern const struct sh_pfc_soc_info r8a7779_pinmux_info;
-extern const struct sh_pfc_soc_info r8a7790_pinmux_info;
-extern const struct sh_pfc_soc_info r8a7791_pinmux_info;
-extern const struct sh_pfc_soc_info r8a7793_pinmux_info;
-extern const struct sh_pfc_soc_info r8a7794_pinmux_info;
-extern const struct sh_pfc_soc_info r8a7795_pinmux_info;
-extern const struct sh_pfc_soc_info sh7203_pinmux_info;
-extern const struct sh_pfc_soc_info sh7264_pinmux_info;
-extern const struct sh_pfc_soc_info sh7269_pinmux_info;
-extern const struct sh_pfc_soc_info sh73a0_pinmux_info;
-extern const struct sh_pfc_soc_info sh7720_pinmux_info;
-extern const struct sh_pfc_soc_info sh7722_pinmux_info;
-extern const struct sh_pfc_soc_info sh7723_pinmux_info;
-extern const struct sh_pfc_soc_info sh7724_pinmux_info;
-extern const struct sh_pfc_soc_info sh7734_pinmux_info;
-extern const struct sh_pfc_soc_info sh7757_pinmux_info;
-extern const struct sh_pfc_soc_info sh7785_pinmux_info;
-extern const struct sh_pfc_soc_info sh7786_pinmux_info;
-extern const struct sh_pfc_soc_info shx3_pinmux_info;
-
 #endif /* __SH_PFC_CORE_H__ */
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index ea3a527514558add..332d379b302cba70 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -225,6 +225,30 @@ struct sh_pfc_soc_info {
 	u32 unlock_reg;
 };
 
+extern const struct sh_pfc_soc_info emev2_pinmux_info;
+extern const struct sh_pfc_soc_info r8a73a4_pinmux_info;
+extern const struct sh_pfc_soc_info r8a7740_pinmux_info;
+extern const struct sh_pfc_soc_info r8a7778_pinmux_info;
+extern const struct sh_pfc_soc_info r8a7779_pinmux_info;
+extern const struct sh_pfc_soc_info r8a7790_pinmux_info;
+extern const struct sh_pfc_soc_info r8a7791_pinmux_info;
+extern const struct sh_pfc_soc_info r8a7793_pinmux_info;
+extern const struct sh_pfc_soc_info r8a7794_pinmux_info;
+extern const struct sh_pfc_soc_info r8a7795_pinmux_info;
+extern const struct sh_pfc_soc_info sh7203_pinmux_info;
+extern const struct sh_pfc_soc_info sh7264_pinmux_info;
+extern const struct sh_pfc_soc_info sh7269_pinmux_info;
+extern const struct sh_pfc_soc_info sh73a0_pinmux_info;
+extern const struct sh_pfc_soc_info sh7720_pinmux_info;
+extern const struct sh_pfc_soc_info sh7722_pinmux_info;
+extern const struct sh_pfc_soc_info sh7723_pinmux_info;
+extern const struct sh_pfc_soc_info sh7724_pinmux_info;
+extern const struct sh_pfc_soc_info sh7734_pinmux_info;
+extern const struct sh_pfc_soc_info sh7757_pinmux_info;
+extern const struct sh_pfc_soc_info sh7785_pinmux_info;
+extern const struct sh_pfc_soc_info sh7786_pinmux_info;
+extern const struct sh_pfc_soc_info shx3_pinmux_info;
+
 /* -----------------------------------------------------------------------------
  * Helper macros to create pin and port lists
  */
-- 
1.9.1

