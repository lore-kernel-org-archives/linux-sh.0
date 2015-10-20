From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 20 Oct 2015 19:26:32 +0000
Subject: [PATCH/RFC 1/4] pinctrl: sh-pfc: Add PINMUX_SINGLE()
Message-Id: <1445369195-25117-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1445369195-25117-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1445369195-25117-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a macro to describe a pinmux configuration for a single-function
pin.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 63e6cd050d0fb7d2..932fbef8bad400dd 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -277,6 +277,13 @@ struct sh_pfc_soc_info {
 	PINMUX_DATA(fn##_MARK, FN_##ms, FN_##ipsr, FN_##fn)
 
 /*
+ * Describe a pinmux configuration for a single-function pin.
+ *   - fn: Function name
+ */
+#define PINMUX_SINGLE(fn)						\
+	PINMUX_DATA(fn##_MARK, FN_##fn)
+
+/*
  * GP port style (32 ports banks)
  */
 
-- 
1.9.1

