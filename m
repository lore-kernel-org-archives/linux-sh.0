From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 24 Apr 2008 12:53:07 +0000
Subject: [PATCH] sh: intc register modify fix
Message-Id: <20080424125307.19688.80999.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Make sure register modifications stay atomic. Fixes processors with
shared priority register masking. Dual bitmap masking is unaffected.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/irq/intc.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 0013/arch/sh/kernel/cpu/irq/intc.c
+++ work/arch/sh/kernel/cpu/irq/intc.c	2008-04-24 20:44:38.000000000 +0900
@@ -101,17 +101,26 @@ static void write_32(unsigned long addr,
 
 static void modify_8(unsigned long addr, unsigned long h, unsigned long data)
 {
+	unsigned long flags;
+	local_irq_save(flags);
 	ctrl_outb(set_field(ctrl_inb(addr), data, h), addr);
+	local_irq_restore(flags);
 }
 
 static void modify_16(unsigned long addr, unsigned long h, unsigned long data)
 {
+	unsigned long flags;
+	local_irq_save(flags);
 	ctrl_outw(set_field(ctrl_inw(addr), data, h), addr);
+	local_irq_restore(flags);
 }
 
 static void modify_32(unsigned long addr, unsigned long h, unsigned long data)
 {
+	unsigned long flags;
+	local_irq_save(flags);
 	ctrl_outl(set_field(ctrl_inl(addr), data, h), addr);
+	local_irq_restore(flags);
 }
 
 enum {	REG_FN_ERR = 0, REG_FN_WRITE_BASE = 1, REG_FN_MODIFY_BASE = 5 };
