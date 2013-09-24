From: takasi-y@ops.dti.ne.jp
Date: Tue, 24 Sep 2013 04:12:06 +0000
Subject: [PATCH 3/6] sh: clkfwk: Select sh-/common- clkfwk alternatively
Message-Id: <20130924131206.d57d07f5faa5cb0773fc328c@ops.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <52410F86.4040301@renesas.com>
In-Reply-To: <52410F86.4040301@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SH-Linux <linux-sh@vger.kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, ben.dooks@codethink.co.uk, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>, Paul Mundt <lethal@linux-sh.org>, Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org

Make sh clock framework core depend on HAVE_MACH_CLKDEV, and
set it
- y on sh for backward compatibility
- !CONFIG_COMMON_CLK on sh-mobile
This is a preparation for migration to common clock framework
from sh clock framework on sh-mobile.

Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
---
 arch/arm/Kconfig        | 2 +-
 arch/sh/Kconfig         | 1 +
 drivers/sh/clk/Makefile | 3 +--
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3f7714d..53044ca 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -650,7 +650,7 @@ config ARCH_SHMOBILE
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_CLK
-	select HAVE_MACH_CLKDEV
+	select HAVE_MACH_CLKDEV if !COMMON_CLK
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	select MULTI_IRQ_HANDLER
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 224f4bc..f57e47f 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -41,6 +41,7 @@ config SUPERH
 	select MODULES_USE_ELF_RELA
 	select OLD_SIGSUSPEND
 	select OLD_SIGACTION
+	select HAVE_MACH_CLKDEV
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/drivers/sh/clk/Makefile b/drivers/sh/clk/Makefile
index 5d15ebf..e73b031 100644
--- a/drivers/sh/clk/Makefile
+++ b/drivers/sh/clk/Makefile
@@ -1,3 +1,2 @@
-obj-y	:= core.o
-
+obj-$(CONFIG_HAVE_MACH_CLKDEV)	+= core.o
 obj-$(CONFIG_SH_CLK_CPG)	+= cpg.o
-- 
1.8.1.5

