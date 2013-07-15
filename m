From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 15 Jul 2013 23:40:03 +0000
Subject: [PATCH 15/19] sh-pfc: Pass the pin number down to the port function macro
Message-Id: <1373931607-4599-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The PORT_1 macro invokes a macro passed as a parameter. Pass the pin
number down to that macro at the bottom of the call stack. This will be
used to compute the pin ranges automatically.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 005b482..596ceb7 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -229,7 +229,7 @@ struct sh_pfc_soc_info {
  * PORT style (linear pin space)
  */
 
-#define PORT_1(pn, fn, pfx, sfx) fn(pfx, sfx)
+#define PORT_1(pn, fn, pfx, sfx) fn(pn, pfx, sfx)
 
 #define PORT_10(pn, fn, pfx, sfx)					  \
 	PORT_1(pn,   fn, pfx##0, sfx), PORT_1(pn+1, fn, pfx##1, sfx),	  \
@@ -246,7 +246,7 @@ struct sh_pfc_soc_info {
 	PORT_10(pn+90, fn, pfx##9, sfx)
 
 /* PORT_ALL(suffix) - Expand to a list of PORT_#_suffix */
-#define _PORT_ALL(pfx, sfx)		pfx##_##sfx
+#define _PORT_ALL(pn, pfx, sfx)		pfx##_##sfx
 #define PORT_ALL(str)			CPU_ALL_PORT(_PORT_ALL, PORT, str)
 
 /* PINMUX_GPIO - Expand to a sh_pfc_pin entry */
@@ -267,7 +267,7 @@ struct sh_pfc_soc_info {
 /* PINMUX_DATA_ALL - Expand to a list of PORT_name_DATA, PORT_name_FN0,
  *		     PORT_name_OUT, PORT_name_IN marks
  */
-#define _PORT_DATA(pfx, sfx)						\
+#define _PORT_DATA(pn, pfx, sfx)					\
 	PINMUX_DATA(PORT##pfx##_DATA, PORT##pfx##_FN0,			\
 		    PORT##pfx##_OUT, PORT##pfx##_IN)
 #define PINMUX_DATA_ALL()		CPU_ALL_PORT(_PORT_DATA, , unused)
-- 
1.8.1.5

