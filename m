From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 26 Aug 2015 18:02:22 +0000
Subject: [PATCH 3/5] pinctrl: sh-pfc: r8a7795: Fix SCIF5 pin data
Message-Id: <1440612144-16877-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1440612144-16877-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1440612144-16877-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Correct SCIF5 data pin numbers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 83cce48da9f928b7..52faa7faccdc5488 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -2405,7 +2405,7 @@ static const unsigned int scif4_ctrl_c_mux[] = {
 /* - SCIF5 ------------------------------------------------------------------ */
 static const unsigned int scif5_data_pins[] = {
 	/* RX, TX */
-	RCAR_GP_PIN(2, 19), RCAR_GP_PIN(2, 21),
+	RCAR_GP_PIN(5, 19), RCAR_GP_PIN(5, 21),
 };
 static const unsigned int scif5_data_mux[] = {
 	RX5_MARK, TX5_MARK,
-- 
1.9.1

