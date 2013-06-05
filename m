From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Jun 2013 06:59:30 +0000
Subject: [PATCH 05/15] ARM: shmobile: Armadillo800EVA uImage rework
Message-Id: <20130605070656.13311.78020.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130605070616.13311.69049.sendpatchset@w520>
In-Reply-To: <20130605070616.13311.69049.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add Armadillo800EVA specific load address to Makefile.boot

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile.boot |    1 +
 1 file changed, 1 insertion(+)

--- 0012/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-06-04 16:12:59.000000000 +0900
@@ -4,6 +4,7 @@ loadaddr-y	:= $(shell /bin/bash -c 'prin
 loadaddr-$(CONFIG_MACH_AG5EVM) += 0x40008000
 loadaddr-$(CONFIG_MACH_AP4EVB) += 0x40008000
 loadaddr-$(CONFIG_MACH_APE6EVM) += 0x40008000
+loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
 
 __ZRELADDR	:= $(shell /bin/bash -c \
 		     'echo $(loadaddr-y) | tr " " "\n" | sort | uniq')
