From: Simon Horman <horms@verge.net.au>
Date: Thu, 23 Feb 2012 10:06:41 +0000
Subject: [PATCH] mackerel: Do not enable TMU timer in default config
Message-Id: <20120223100640.GA3091@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1329111377-15676-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1329111377-15676-1-git-send-email-horms@verge.net.au>
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

Hi Rafael,

I would appreciate it if you could consider this change for 3.3.

It is a band-aid solution, however, it resolves a regression -
the boot or lack thereof of a mackerel board using the default config -
since 3.2.

I have discussed this a little with Magnus Damm and he is of
the opinion that this problem likely relates to an interaction
between TMU and power domains and that a full fix would be difficult
within the 3.3 time-frame.

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

