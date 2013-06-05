From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Jun 2013 10:44:37 +0000
Subject: [PATCH 01/03] ARM: Let arm_add_memory() always use 64-bit arguments
Message-Id: <20130605104437.1720.36474.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130605104427.1720.68752.sendpatchset@w520>
In-Reply-To: <20130605104427.1720.68752.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The DTB and/or the kernel command line may pass
64-bit addresses regardless of kernel configuration,
so update arm_add_memory() to take 64-bit arguments
independently of the phys_addr_t size.

This allows non-wrapping handling of high memory
banks such as the second memory bank of APE6EVM
(at 0x2_0000_0000) in case of 32-bit phys_addr_t.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/include/asm/setup.h |    2 +-
 arch/arm/kernel/setup.c      |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--- 0001/arch/arm/include/asm/setup.h
+++ work/arch/arm/include/asm/setup.h	2013-06-05 18:47:09.000000000 +0900
@@ -49,7 +49,7 @@ extern struct meminfo meminfo;
 #define bank_phys_end(bank)	((bank)->start + (bank)->size)
 #define bank_phys_size(bank)	(bank)->size
 
-extern int arm_add_memory(phys_addr_t start, phys_addr_t size);
+extern int arm_add_memory(u64 start, u64 size);
 extern void early_print(const char *str, ...);
 extern void dump_machine_table(void);
 
--- 0001/arch/arm/kernel/setup.c
+++ work/arch/arm/kernel/setup.c	2013-06-05 18:47:34.000000000 +0900
@@ -527,7 +527,7 @@ void __init dump_machine_table(void)
 		/* can't use cpu_relax() here as it may require MMU setup */;
 }
 
-int __init arm_add_memory(phys_addr_t start, phys_addr_t size)
+int __init arm_add_memory(u64 start, u64 size)
 {
 	struct membank *bank = &meminfo.bank[meminfo.nr_banks];
 
@@ -577,8 +577,8 @@ int __init arm_add_memory(phys_addr_t st
 static int __init early_mem(char *p)
 {
 	static int usermem __initdata = 0;
-	phys_addr_t size;
-	phys_addr_t start;
+	u64 size;
+	u64 start;
 	char *endp;
 
 	/*
