From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Jun 2013 06:59:06 +0000
Subject: [PATCH 02/15] ARM: shmobile: AG5EVM uImage rework
Message-Id: <20130605070633.13311.4000.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130605070616.13311.69049.sendpatchset@w520>
In-Reply-To: <20130605070616.13311.69049.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add AG5EVM specific load address to Makefile.boot

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile.boot |    2 ++
 1 file changed, 2 insertions(+)

--- 0009/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-06-04 16:06:50.000000000 +0900
@@ -1,6 +1,8 @@
 loadaddr-y	:= $(shell /bin/bash -c 'printf "0x%08x" \
 		     $$[$(CONFIG_MEMORY_START) + 0x8000]')
 
+loadaddr-$(CONFIG_MACH_AG5EVM) += 0x40008000
+
 __ZRELADDR	:= $(shell /bin/bash -c \
 		     'echo $(loadaddr-y) | tr " " "\n" | sort | uniq')
 
