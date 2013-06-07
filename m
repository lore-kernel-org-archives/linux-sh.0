From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 07 Jun 2013 07:51:35 +0000
Subject: [PATCH 05/27] ARM: shmobile: use do{ }while() on SH_CLK_SET_RATIO()
Message-Id: <1370591517-20239-6-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1370591517-20239-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370591517-20239-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

SH_CLK_SET_RATIO() will be trouble without this patch

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/clock.h | 4 ++--
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
1.8.2.1

