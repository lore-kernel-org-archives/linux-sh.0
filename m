From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 12 Feb 2013 15:34:31 +0000
Subject: [PATCH 3/2] pinctrl: sh-pfc: fix a typo and simplify a definition on sh73a0
Message-Id: <Pine.LNX.4.64.1302121633000.7059@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix definition of the SDHIWP0 function and simplify the CPU_ALL_PORT
definition on sh73a0.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

I think it's better to add this one to the fixes too.

 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index b048fa4..9bcb81f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -25,11 +25,7 @@
 #include "sh_pfc.h"
 
 #define CPU_ALL_PORT(fn, pfx, sfx)				\
-	PORT_10(fn, pfx,    sfx), PORT_10(fn, pfx##1, sfx),	\
-	PORT_10(fn, pfx##2, sfx), PORT_10(fn, pfx##3, sfx),	\
-	PORT_10(fn, pfx##4, sfx), PORT_10(fn, pfx##5, sfx),	\
-	PORT_10(fn, pfx##6, sfx), PORT_10(fn, pfx##7, sfx),	\
-	PORT_10(fn, pfx##8, sfx), PORT_10(fn, pfx##9, sfx),	\
+	PORT_10(fn, pfx,    sfx), PORT_90(fn, pfx, sfx),	\
 	PORT_10(fn, pfx##10, sfx),				\
 	PORT_1(fn, pfx##110, sfx), PORT_1(fn, pfx##111, sfx),	\
 	PORT_1(fn, pfx##112, sfx), PORT_1(fn, pfx##113, sfx),	\
@@ -1502,7 +1498,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(SDHID0_2_PU_MARK, PORT254_FN1, PORT254_IN_PU),
 	PINMUX_DATA(SDHID0_3_PU_MARK, PORT255_FN1, PORT255_IN_PU),
 	PINMUX_DATA(SDHICMD0_PU_MARK, PORT256_FN1, PORT256_IN_PU),
-	PINMUX_DATA(SDHIWP0_PU_MARK,  PORT257_FN1, PORT256_IN_PU),
+	PINMUX_DATA(SDHIWP0_PU_MARK,  PORT257_FN1, PORT257_IN_PU),
 	PINMUX_DATA(SDHID1_0_PU_MARK, PORT259_FN1, PORT259_IN_PU),
 	PINMUX_DATA(SDHID1_1_PU_MARK, PORT260_FN1, PORT260_IN_PU),
 	PINMUX_DATA(SDHID1_2_PU_MARK, PORT261_FN1, PORT261_IN_PU),
-- 
1.7.2.5

