From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Mon, 23 Dec 2013 20:28:28 +0000
Subject: [PATCH] pinctl: sh-pfc: r8a7790: Fix vsync value in the vin3_sync_mux array
Message-Id: <1387830508-10710-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This fixes a typo in the vin3_sync_mux array (s/VI2/VI3/).

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 293a51a..01236c5 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3564,7 +3564,7 @@ static const unsigned int vin3_sync_pins[] = {
 };
 static const unsigned int vin3_sync_mux[] = {
 	VI3_HSYNC_N_MARK,
-	VI2_VSYNC_N_MARK,
+	VI3_VSYNC_N_MARK,
 };
 static const unsigned int vin3_field_pins[] = {
 	RCAR_GP_PIN(1, 15),
-- 
1.8.3.1

