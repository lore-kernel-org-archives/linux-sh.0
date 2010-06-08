From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Tue, 08 Jun 2010 02:00:36 +0000
Subject: [PATCH 2/2] sh: Fix reboot on 32bit boot mode
Message-Id: <AANLkTikXJ1cGxTYDjnTKnXNaA0jL6pHBx9Wc2uHRsULJ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When manual reset is executed, V bit of ITLB is not cleared.
Therefore, when reboot kernel, information on TLB is not
initialized.
This problem is solved the initialization of the TI bit of
MMUCR when the manual is reset.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/reboot.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/reboot.c b/arch/sh/kernel/reboot.c
index b1fca66..541fb39 100644
--- a/arch/sh/kernel/reboot.c
+++ b/arch/sh/kernel/reboot.c
@@ -9,6 +9,7 @@
 #include <asm/addrspace.h>
 #include <asm/reboot.h>
 #include <asm/system.h>
+#include <asm/mmu_context.h>

 void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
@@ -25,6 +26,11 @@ static void native_machine_restart(char * __unused)
 {
 	local_irq_disable();

+#ifdef CONFIG_PMB
+	/* PMB entry clear. */
+	writel(MMUCR_TI, MMUCR);
+#endif
+
 	/* Address error with SR.BL=1 first. */
 	trigger_address_error();

-- 
1.7.0.3
