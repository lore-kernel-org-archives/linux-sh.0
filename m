From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 26 Aug 2009 10:49:44 +0000
Subject: [PATCH] sh: fix CPU_SH7723/7724 numbering bug
Message-Id: <ufxbehmt3.wl%morimoto.kuninori@renesas.com>
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
index 10e6795..afd3e73 100644
--- a/arch/sh/kernel/cpu/sh4/probe.c
+++ b/arch/sh/kernel/cpu/sh4/probe.c
@@ -141,7 +141,7 @@ int __init detect_cpu_and_cache_system(void)
 	case 0x300b:
 		switch (prr) {
 		case 0x20:
-			boot_cpu_data.type = CPU_SH7723;
+			boot_cpu_data.type = CPU_SH7724;
 			boot_cpu_data.flags |= CPU_HAS_L2_CACHE;
 			break;
 		case 0x50:
-- 
1.6.0.4

