From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 25 Jun 2010 07:26:05 +0000
Subject: [PATCH] ARM: sh-mobile: add GPIO definitions for switching between
Message-Id: <Pine.LNX.4.64.1006250922540.1223@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

With these defines now it is possible to use 
gpio_request(GPIO_FN_LCDC1_SELECT, NULL) or ...LCDC0... respectively to 
switch between the two LCDC instances.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/pfc-sh7372.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/pfc-sh7372.c b/arch/arm/mach-shmobile/pfc-sh7372.c
index 9557d09..ec42035 100644
--- a/arch/arm/mach-shmobile/pfc-sh7372.c
+++ b/arch/arm/mach-shmobile/pfc-sh7372.c
@@ -1160,6 +1160,9 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	GPIO_FN(LCDD18),	GPIO_FN(LCDD19),	GPIO_FN(LCDD20),
 	GPIO_FN(LCDD21),	GPIO_FN(LCDD22),	GPIO_FN(LCDD23),
 
+	GPIO_FN(LCDC0_SELECT),
+	GPIO_FN(LCDC1_SELECT),
+
 	/* IRDA */
 	GPIO_FN(IRDA_OUT),	GPIO_FN(IRDA_IN),	GPIO_FN(IRDA_FIRSEL),
 	GPIO_FN(IROUT_139),	GPIO_FN(IROUT_140),
-- 
1.6.2.4

