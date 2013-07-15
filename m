From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 15 Jul 2013 23:39:52 +0000
Subject: [PATCH 04/19] sh-pfc: Remove unneeded const keywords
Message-Id: <1373931607-4599-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Two integer field structures are needlesly defined as const. Remove the
const keyword.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index d0a8ff8..2105487 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -30,7 +30,7 @@ enum {
 #define SH_PFC_PIN_CFG_PULL_DOWN	(1 << 3)
 
 struct sh_pfc_pin {
-	const pinmux_enum_t enum_id;
+	pinmux_enum_t enum_id;
 	const char *name;
 	unsigned int configs;
 };
@@ -64,7 +64,7 @@ struct sh_pfc_function {
 };
 
 struct pinmux_func {
-	const pinmux_enum_t enum_id;
+	pinmux_enum_t enum_id;
 	const char *name;
 };
 
-- 
1.8.1.5

