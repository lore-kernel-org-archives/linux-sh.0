From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Jun 2013 07:08:21 +0000
Subject: [PATCH 15/15] ARM: shmobile: Remove MEMORY_START uImage load address
Message-Id: <20130605070821.13311.23849.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130605070616.13311.69049.sendpatchset@w520>
In-Reply-To: <20130605070616.13311.69049.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove the CONFIG_MEMORY_START dependency in Makefile.boot
now when we keep track of board specific load addresses.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile.boot |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- 0021/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-06-04 17:09:37.000000000 +0900
@@ -1,6 +1,5 @@
-loadaddr-y	:= $(shell /bin/bash -c 'printf "0x%08x" \
-		     $$[$(CONFIG_MEMORY_START) + 0x8000]')
-
+# per-board load address for uImage
+loadaddr-y	: loadaddr-$(CONFIG_MACH_AG5EVM) += 0x40008000
 loadaddr-$(CONFIG_MACH_AP4EVB) += 0x40008000
 loadaddr-$(CONFIG_MACH_APE6EVM) += 0x40008000
