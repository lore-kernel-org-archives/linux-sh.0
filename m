From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 30 Nov 2015 13:59:54 +0000
Subject: [PATCH 1/3] pinctrl: sh-pfc: emev2: Correct comment for CFI data pins
Message-Id: <1448891996-5263-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1448891996-5263-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448891996-5263-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The 8 data pins of the Compact Flash Interface are numbered 0..7, not
0..8.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-emev2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-emev2.c b/drivers/pinctrl/sh-pfc/pfc-emev2.c
index a3a4b67c5434163d..1cbbe04d7df657e8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-emev2.c
+++ b/drivers/pinctrl/sh-pfc/pfc-emev2.c
@@ -749,7 +749,7 @@ static const unsigned int cf_ctrl_mux[] = {
 };
 
 static const unsigned int cf_data8_pins[] = {
-	/* CF_D[0:8] */
+	/* CF_D[0:7] */
 	77, 78, 79, 80,
 	81, 82, 83, 84,
 };
-- 
1.9.1

