From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Feb 2008 14:57:57 +0000
Subject: [PATCH] sh: add probe support for new sh7722 cut
Message-Id: <20080206145757.27052.81857.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds support for sh7722 devices with prr value 0xa1.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4/probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/kernel/cpu/sh4/probe.c
+++ work/arch/sh/kernel/cpu/sh4/probe.c	2008-02-06 20:23:07.000000000 +0900
@@ -126,7 +126,7 @@ int __init detect_cpu_and_cache_system(v
 					  CPU_HAS_LLSC;
 		break;
 	case 0x3008:
-		if (prr = 0xa0) {
+		if (prr = 0xa0 || prr = 0xa1) {
 			boot_cpu_data.type = CPU_SH7722;
 			boot_cpu_data.icache.ways = 4;
 			boot_cpu_data.dcache.ways = 4;
