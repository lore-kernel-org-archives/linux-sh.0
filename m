From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 19 Nov 2013 09:04:20 +0000
Subject: [PATCH 1/6] ARM: shmobile: r8a7790: care EXTAL divider settings
Message-Id: <878uwkep9r.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

EXTAL clock frequency needs 1/2 when
(MD14, MD13, MD19) = (1, x, x).

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 6107571..be72032 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -328,10 +328,10 @@ void __init r8a7790_clock_init(void)
 		R8A7790_CLOCK_ROOT(20, &extal_clk, 130, 156, 80, 66);
 		break;
 	case MD(14):
-		R8A7790_CLOCK_ROOT(26, &extal_div2_clk, 200, 240, 122, 102);
+		R8A7790_CLOCK_ROOT(26 / 2, &extal_div2_clk, 200, 240, 122, 102);
 		break;
 	case MD(13) | MD(14):
-		R8A7790_CLOCK_ROOT(30, &extal_div2_clk, 172, 208, 106, 88);
+		R8A7790_CLOCK_ROOT(30 / 2, &extal_div2_clk, 172, 208, 106, 88);
 		break;
 	}
 
-- 
1.7.9.5

