From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 30 Nov 2015 13:59:56 +0000
Subject: [PATCH 3/3] pinctrl: sh-pfc: sh73a0: Correct comment for LCD2 data pins
Message-Id: <1448891996-5263-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1448891996-5263-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448891996-5263-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The 12 data pins of LCD2 are numbered 0..11, not 0..12.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index cd7c6645f7a47df1..d25e6f674d0aba84 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2059,7 +2059,7 @@ static const unsigned int lcd2_data9_mux[] = {
 	LCD2D8_MARK,
 };
 static const unsigned int lcd2_data12_pins[] = {
-	/* D[0:12] */
+	/* D[0:11] */
 	128, 129, 142, 143, 144, 145, 138, 139,
 	140, 141, 130, 131,
 };
-- 
1.9.1

