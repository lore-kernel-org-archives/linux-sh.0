From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 20 Nov 2015 12:36:56 +0000
Subject: [PATCH 5/6] staging: board: kzm9d: Use "arm,pl390"
Message-Id: <1448023017-21816-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1448023017-21816-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448023017-21816-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Must be applied together with "ARM: shmobile: emev2 dtsi: Use
"arm,pl390" for GIC"!

Greg: Can you please provide your ack? Thanks!
---
 drivers/staging/board/kzm9d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/board/kzm9d.c b/drivers/staging/board/kzm9d.c
index 8d1eb09bc66ef413..05a6d434d307fe0f 100644
--- a/drivers/staging/board/kzm9d.c
+++ b/drivers/staging/board/kzm9d.c
@@ -11,7 +11,7 @@ static struct resource usbs1_res[] __initdata = {
 
 static void __init kzm9d_init(void)
 {
-	board_staging_gic_setup_xlate("arm,cortex-a9-gic", 32);
+	board_staging_gic_setup_xlate("arm,pl390", 32);
 
 	if (!board_staging_dt_node_available(usbs1_res,
 					     ARRAY_SIZE(usbs1_res))) {
-- 
1.9.1

