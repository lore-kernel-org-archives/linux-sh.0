From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 12 Apr 2013 07:41:07 +0000
Subject: [PATCH 1/4 v2] ARM: shmobile: use do{ }while() on SH_CLK_SET_RATIO()
Message-Id: <87vc7snqls.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH_CLK_SET_RATIO() will be trouble without this patch

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - v1 didn't have this

 arch/arm/mach-shmobile/include/mach/clock.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/clock.h b/arch/arm/mach-shmobile/include/mach/clock.h
index 8902044..03e5607 100644
--- a/arch/arm/mach-shmobile/include/mach/clock.h
+++ b/arch/arm/mach-shmobile/include/mach/clock.h
@@ -31,9 +31,9 @@ static SH_FIXED_RATIO_CLKg(name, p, r)
 	SH_FIXED_RATIO_CLK(name, p, name)
 
 #define SH_CLK_SET_RATIO(p, m, d)	\
-{			\
+do {			\
 	(p)->mul = m;	\
 	(p)->div = d;	\
-}
+} while (0)
 
 #endif
-- 
1.7.9.5

