From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 27 Jun 2013 09:49:11 +0000
Subject: [PATCH 01/24] drm/rcar-du: Add missing alpha plane register definitions
Message-Id: <1372326574-4315-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Several alpha plane register definitions are missing, add them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_regs.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_regs.h b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
index 69f21f1..3aba27f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_regs.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
@@ -349,10 +349,25 @@
 #define APnMR_BM_AD		(2 << 4)	/* Auto Display Change Mode */
 
 #define APnMWR			0x0a104
+
+#define APnDSXR			0x0a110
+#define APnDSYR			0x0a114
+#define APnDPXR			0x0a118
+#define APnDPYR			0x0a11c
+
 #define APnDSA0R		0x0a120
 #define APnDSA1R		0x0a124
 #define APnDSA2R		0x0a128
+
+#define APnSPXR			0x0a130
+#define APnSPYR			0x0a134
+#define APnWASPR		0x0a138
+#define APnWAMWR		0x0a13c
+
+#define APnBTR			0x0a140
+
 #define APnMLR			0x0a150
+#define APnSWAPR		0x0a180
 
 /* -----------------------------------------------------------------------------
  * Display Capture Registers
-- 
1.8.1.5

