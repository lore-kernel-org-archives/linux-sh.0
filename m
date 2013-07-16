From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 16 Jul 2013 00:11:02 +0000
Subject: [PATCH v2 10/27] sh-pfc: Remove unused PORT_DATA_* macros
Message-Id: <1373933479-17727-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Most of the PORT_DATA_* macros are not used, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 64219f6..0e3e00f 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -209,40 +209,10 @@ enum { GPIO_CFG_REQ, GPIO_CFG_FREE };
 #define GPIO_FN(str) PINMUX_GPIO_FN(GPIO_FN_##str, PINMUX_FN_BASE, str##_MARK)
 
 /* helper macro for pinmux_enum_t */
-#define PORT_DATA_I(nr)	\
-	PINMUX_DATA(PORT##nr##_DATA, PORT##nr##_FN0, PORT##nr##_IN)
-
-#define PORT_DATA_I_PD(nr)	\
-	PINMUX_DATA(PORT##nr##_DATA, PORT##nr##_FN0,	\
-		    PORT##nr##_IN, PORT##nr##_IN_PD)
-
-#define PORT_DATA_I_PU(nr)	\
-	PINMUX_DATA(PORT##nr##_DATA, PORT##nr##_FN0,	\
-		    PORT##nr##_IN, PORT##nr##_IN_PU)
-
-#define PORT_DATA_I_PU_PD(nr)	\
-	PINMUX_DATA(PORT##nr##_DATA, PORT##nr##_FN0,			\
-		    PORT##nr##_IN, PORT##nr##_IN_PD, PORT##nr##_IN_PU)
-
-#define PORT_DATA_O(nr)		\
-	PINMUX_DATA(PORT##nr##_DATA, PORT##nr##_FN0, PORT##nr##_OUT)
-
 #define PORT_DATA_IO(nr)	\
 	PINMUX_DATA(PORT##nr##_DATA, PORT##nr##_FN0, PORT##nr##_OUT,	\
 		    PORT##nr##_IN)
 
-#define PORT_DATA_IO_PD(nr)	\
-	PINMUX_DATA(PORT##nr##_DATA, PORT##nr##_FN0, PORT##nr##_OUT,	\
-		    PORT##nr##_IN, PORT##nr##_IN_PD)
-
-#define PORT_DATA_IO_PU(nr)	\
-	PINMUX_DATA(PORT##nr##_DATA, PORT##nr##_FN0, PORT##nr##_OUT,	\
-		    PORT##nr##_IN, PORT##nr##_IN_PU)
-
-#define PORT_DATA_IO_PU_PD(nr)	\
-	PINMUX_DATA(PORT##nr##_DATA, PORT##nr##_FN0, PORT##nr##_OUT,	\
-		    PORT##nr##_IN, PORT##nr##_IN_PD, PORT##nr##_IN_PU)
-
 /* helper macro for top 4 bits in PORTnCR */
 #define _PCRH(in, in_pd, in_pu, out)	\
 	0, (out), (in), 0,		\
-- 
1.8.1.5

