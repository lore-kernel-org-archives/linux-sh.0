From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Wed, 29 Jun 2016 13:40:46 +0000
Subject: [PATCH v4 01/22] sh: Add sh-specific early_init_dt_reserve_memory_arch
Message-Id: <1467207667-15768-2-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

sh used P1 address space in early device tree.
So need convert P1 to physical address before reserve memory.

Changes v4
none

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boards/of-generic.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 57d45dc..8dbf978 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -15,6 +15,7 @@
 #include <linux/clocksource.h>
 #include <linux/irqchip.h>
 #include <linux/clk-provider.h>
+#include <linux/memblock.h>
 #include <asm/machvec.h>
 #include <asm/rtc.h>
 
@@ -203,3 +204,14 @@ static int __init sh_of_device_init(void)
 	return 0;
 }
 arch_initcall_sync(sh_of_device_init);
+
+int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
+					     phys_addr_t size, bool nomap)
+{
+	if (nomap)
+		return memblock_remove(base, size);
+
+	if (base >= P1SEG)
+		base &= ~P1SEG;
+	return memblock_reserve(base, size);
+}
-- 
2.7.0

