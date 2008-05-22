From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 May 2008 13:24:51 +0000
Subject: [PATCH] sh: add probe support for new sh7723 cut
Message-Id: <20080522132451.12251.62947.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds support for sh7723 silicon with a prr value of 0x51.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4/probe.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/sh/kernel/cpu/sh4/probe.c
+++ work/arch/sh/kernel/cpu/sh4/probe.c	2008-05-22 11:44:02.000000000 +0900
@@ -132,6 +132,7 @@ int __init detect_cpu_and_cache_system(v
 
 		switch (prr) {
 		case 0x50:
+		case 0x51:
 			boot_cpu_data.type = CPU_SH7723;
 			boot_cpu_data.flags |= CPU_HAS_FPU | CPU_HAS_L2_CACHE;
 			break;
