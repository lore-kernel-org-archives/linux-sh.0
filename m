From: Simon Horman <horms@verge.net.au>
Date: Mon, 13 Feb 2012 05:36:17 +0000
Subject: [PATCH] mackerel: Do not enable TMU timer in default config
Message-Id: <1329111377-15676-1-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This allows the mackerel to boot using a kernel compiled
using the mackerel default config. Without this change
the kernel boot hangs during or immediately after SCIF
initialisation.

SuperH SCI(F) driver initialized
sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 80) is a scifa
sh-sci sh-sci.0: start latency exceeded, new value 5416 ns
console [ttySC0] enabled, bootconsole disabled
console [ttySC0] enabled, bootconsole disabled

Signed-off-by: Simon Horman <horms@verge.net.au>

---

This resolves a regression since 3.2.
I am unsure if there is a cleaner way to resolve this problem
nor if other boards are affected.
---
 arch/arm/configs/mackerel_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
index 306a2e2..41d014e 100644
--- a/arch/arm/configs/mackerel_defconfig
+++ b/arch/arm/configs/mackerel_defconfig
@@ -18,6 +18,7 @@ CONFIG_ARCH_SHMOBILE=y
 CONFIG_ARCH_SH7372=y
 CONFIG_MACH_MACKEREL=y
 CONFIG_MEMORY_SIZE=0x10000000
+# CONFIG_SH_TIMER_TMU is not set
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
 CONFIG_FORCE_MAX_ZONEORDER
-- 
1.7.2.3

