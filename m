From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 13 Dec 2018 18:27:11 +0000
Subject: [PATCH 12/15] pinctrl: sh-pfc: Make pinmux_cfg_reg.var_field_width[] variable-length
Message-Id: <20181213182714.26094-13-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
In-Reply-To: <20181213182714.26094-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

pinmux_cfg_reg.var_field_width[] is actually a variable-length array,
terminated by a zero, and counting at most r_width entries.
Usually the number of entries is much smaller than r_width, so the
ability to catch bugs at compile time through an "excess elements in
array initializer" warning is fairly limited.

Hence make the array variable-length, decreasing kernel size slightly.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index a2c5d530aaa1c0b3..273b55de9fd67b03 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -142,8 +142,7 @@ struct pinmux_cfg_reg {
  */
 #define PINMUX_CFG_REG_VAR(name, r, r_width, var_fw0, var_fwn...) \
 	.reg = r, .reg_width = r_width,	\
-	.var_field_width = (const u8 [r_width]) \
-		{ var_fw0, var_fwn, 0 }, \
+	.var_field_width = (const u8 []) { var_fw0, var_fwn, 0 }, \
 	.enum_ids = (const u16 [])
 
 struct pinmux_drive_reg_field {
-- 
2.17.1
