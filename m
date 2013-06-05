From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Jun 2013 07:07:56 +0000
Subject: [PATCH 12/15] ARM: shmobile: Mackerel uImage rework
Message-Id: <20130605070756.13311.50136.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130605070616.13311.69049.sendpatchset@w520>
In-Reply-To: <20130605070616.13311.69049.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add Mackerel specific load address to Makefile.boot

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile.boot |    1 +
 1 file changed, 1 insertion(+)

--- 0019/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-06-04 17:03:10.000000000 +0900
@@ -12,6 +12,7 @@ loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
 loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
+loadaddr-$(CONFIG_MACH_MACKEREL) += 0x40008000
 
 __ZRELADDR	:= $(shell /bin/bash -c \
 		     'echo $(loadaddr-y) | tr " " "\n" | sort | uniq')
