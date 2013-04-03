From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 03 Apr 2013 07:22:09 +0000
Subject: [PATCH] ARM: shmobile: remove unnecessary comma from SH_FIXED_RATIO_CLK() macro
Message-Id: <87hajocc4i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/clock.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/clock.h b/arch/arm/mach-shmobile/include/mach/clock.h
index 76ac612..8902044 100644
--- a/arch/arm/mach-shmobile/include/mach/clock.h
+++ b/arch/arm/mach-shmobile/include/mach/clock.h
@@ -24,11 +24,11 @@ struct clk name = {			\
 }
 
 #define SH_FIXED_RATIO_CLK(name, p, r)		\
-static SH_FIXED_RATIO_CLKg(name, p, r);
+static SH_FIXED_RATIO_CLKg(name, p, r)
 
 #define SH_FIXED_RATIO_CLK_SET(name, p, m, d)	\
 	SH_CLK_RATIO(name, m, d);		\
-	SH_FIXED_RATIO_CLK(name, p, name);
+	SH_FIXED_RATIO_CLK(name, p, name)
 
 #define SH_CLK_SET_RATIO(p, m, d)	\
 {			\
-- 
1.7.9.5

