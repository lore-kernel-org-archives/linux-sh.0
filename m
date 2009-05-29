From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 29 May 2009 07:41:23 +0000
Subject: [PATCH] sh7724: L2 cache support
Message-Id: <uoctcwe3g.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/kernel/cpu/sh4/probe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/probe.c b/arch/sh/kernel/cpu/sh4/probe.c
index 973ff83..7d821ce 100644
--- a/arch/sh/kernel/cpu/sh4/probe.c
+++ b/arch/sh/kernel/cpu/sh4/probe.c
@@ -160,7 +160,7 @@ int __init detect_cpu_and_cache_system(void)
 		boot_cpu_data.type = CPU_SH7724;
 		boot_cpu_data.icache.ways = 4;
 		boot_cpu_data.dcache.ways = 4;
-		boot_cpu_data.flags |= CPU_HAS_LLSC | CPU_HAS_FPU;
+		boot_cpu_data.flags |= CPU_HAS_LLSC | CPU_HAS_FPU | CPU_HAS_L2_CACHE;
 		break;
 	case 0x4000:	/* 1st cut */
 	case 0x4001:	/* 2nd cut */
-- 
1.6.0.4

