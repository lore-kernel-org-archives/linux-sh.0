From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 30 Nov 2015 13:59:55 +0000
Subject: [PATCH 2/3] pinctrl: sh-pfc: r8a7740: Correct comment for LCD1 data pins
Message-Id: <1448891996-5263-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1448891996-5263-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448891996-5263-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The 12 data pins of LCD1 are numbered 0..11, not 0..12.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 279e9dd442e44729..7f7c8a6e76e88f29 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -2214,7 +2214,7 @@ static const unsigned int lcd1_data9_mux[] = {
 	LCD1_D8_MARK,
 };
 static const unsigned int lcd1_data12_pins[] = {
-	/* D[0:12] */
+	/* D[0:11] */
 	4, 3, 2, 1, 0, 91, 92, 23,
 	93, 94, 21, 201,
 };
-- 
1.9.1

