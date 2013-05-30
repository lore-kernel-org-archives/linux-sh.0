From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Thu, 30 May 2013 15:08:44 +0000
Subject: [PATCH v2 5/5] ARM: shmobile: lager: map HSCIF0/1 to unused pins
Message-Id: <1369926524-3425-6-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These pins are not actually connected on the board, but at least they
don't conflict with anything else.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 arch/arm/mach-shmobile/board-lager.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 1e99b17..d8bd237 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -77,6 +77,10 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* SCIF1 (CN20: DEBUG SERIAL1) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7790",
 				  "scif1_data", "scif1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.8", "pfc-r8a7790",
+				  "hscif0_data", "hscif0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.9", "pfc-r8a7790",
+				  "hscif1_data_b", "hscif1"),
 };
 
 static void __init lager_add_standard_devices(void)
-- 
1.7.10.4

