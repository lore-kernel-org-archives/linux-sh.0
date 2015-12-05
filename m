From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 05 Dec 2015 02:12:51 +0000
Subject: [PATCH v2 17/32] v4l: vsp1: Fix typo in VI6_DISP_IRQ_STA_DST register name
Message-Id: <1449281586-25726-18-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449281586-25726-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1449281586-25726-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Rename the VI6_DISP_IRQ_STA_DSE register to VI6_DISP_IRQ_STA_DST to fix
a typo and match the datasheet.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/vsp1/vsp1_regs.h b/drivers/media/platform/vsp1/vsp1_regs.h
index 25b48738b147..8173ceaab9f9 100644
--- a/drivers/media/platform/vsp1/vsp1_regs.h
+++ b/drivers/media/platform/vsp1/vsp1_regs.h
@@ -46,7 +46,7 @@
 #define VI6_DISP_IRQ_ENB_LNEE(n)	(1 << (n))
 
 #define VI6_DISP_IRQ_STA		0x007c
-#define VI6_DISP_IRQ_STA_DSE		(1 << 8)
+#define VI6_DISP_IRQ_STA_DST		(1 << 8)
 #define VI6_DISP_IRQ_STA_MAE		(1 << 5)
 #define VI6_DISP_IRQ_STA_LNE(n)		(1 << (n))
 
-- 
2.4.10

