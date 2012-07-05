From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Jul 2012 08:25:24 +0000
Subject: [PATCH 02/12 v2] ARM: shmobile: r8a7740: fixup: MSEL1CR 7bit control
Message-Id: <873956r4wf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

MSEL1CR 7bit selects IRQ7 source pin which was
VBUS pin or A21/MSIOF0_RSYNC/MSIOF1_TSYNC pin.
But current pfc-r8a7740 MSEL1CR 7bit setting was wrong.
This patch fix it up

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - same as v1

 arch/arm/mach-shmobile/pfc-r8a7740.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pfc-r8a7740.c b/arch/arm/mach-shmobile/pfc-r8a7740.c
index 03def0f..ce9e7fa 100644
--- a/arch/arm/mach-shmobile/pfc-r8a7740.c
+++ b/arch/arm/mach-shmobile/pfc-r8a7740.c
@@ -1261,7 +1261,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(A21_MARK,			PORT120_FN1),
 	PINMUX_DATA(MSIOF0_RSYNC_MARK,		PORT120_FN2),
 	PINMUX_DATA(MSIOF1_TSYNC_PORT120_MARK,	PORT120_FN3,	MSEL4CR_10_0),
-	PINMUX_DATA(IRQ7_PORT120_MARK,		PORT120_FN0,	MSEL1CR_7_0),
+	PINMUX_DATA(IRQ7_PORT120_MARK,		PORT120_FN0,	MSEL1CR_7_1),
 
 	/* Port121 */
 	PINMUX_DATA(A20_MARK,			PORT121_FN1),
@@ -1623,7 +1623,7 @@ static pinmux_enum_t pinmux_data[] = {
 
 	/* Port209 */
 	PINMUX_DATA(VBUS_MARK,			PORT209_FN1),
-	PINMUX_DATA(IRQ7_PORT209_MARK,		PORT209_FN0,	MSEL1CR_7_1),
+	PINMUX_DATA(IRQ7_PORT209_MARK,		PORT209_FN0,	MSEL1CR_7_0),
 
 	/* Port210 */
 	PINMUX_DATA(IRQ9_PORT210_MARK,		PORT210_FN0,	MSEL1CR_9_1),
-- 
1.7.5.4

