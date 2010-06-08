From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Tue, 08 Jun 2010 02:00:13 +0000
Subject: [PATCH 1/2] sh: Drop dependence for 29bit mode of
Message-Id: <AANLkTim7PR--Y_fueeMtdvnVX8BUJZK0iwG-rModFYzK@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When CONFIG_PMB enable, ITLB is not cleared by reset of watchdog timer.
This should use trigger_address_error().

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/include/asm/system_32.h |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/sh/include/asm/system_32.h b/arch/sh/include/asm/system_32.h
index 51296b3..9bd2684 100644
--- a/arch/sh/include/asm/system_32.h
+++ b/arch/sh/include/asm/system_32.h
@@ -216,13 +216,12 @@ int handle_unaligned_access(insn_size_t
instruction, struct pt_regs *regs,

 static inline void trigger_address_error(void)
 {
-	if (__in_29bit_mode())
-		__asm__ __volatile__ (
-			"ldc %0, sr\n\t"
-			"mov.l @%1, %0"
-			:
-			: "r" (0x10000000), "r" (0x80000001)
-		);
+	__asm__ __volatile__ (
+		"ldc %0, sr\n\t"
+		"mov.l @%1, %0"
+		:
+		: "r" (0x10000000), "r" (0x80000001)
+	);
 }

 asmlinkage void do_address_error(struct pt_regs *regs,
-- 
1.7.0.3
