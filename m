From: Matt Fleming <matt@console-pimps.org>
Date: Sun, 28 Mar 2010 20:08:25 +0000
Subject: [PATCH] sh: Enable the mmu in start_secondary()
Message-Id: <a460f3c9762b32919a8886a12ecaf3347358234d.1269806815.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

For the boot, enable_mmu() is called from setup_arch() but we don't call
setup_arch() for any of the other cpus. So turn on the non-boot cpu's
mmu inside of start_secondary().

I noticed this bug on an SMP board when trying to map I/O memory
(smsc911x registers) into the kernel address space. Since the Address
Translation bit in MMUCR wasn't set, accessing the virtual address where
the smsc911x registers were supposedly mapped actually performed a
physical address access.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/kernel/smp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index e124cf7..002cc61 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -69,6 +69,7 @@ asmlinkage void __cpuinit start_secondary(void)
 	unsigned int cpu;
 	struct mm_struct *mm = &init_mm;
 
+	enable_mmu();
 	atomic_inc(&mm->mm_count);
 	atomic_inc(&mm->mm_users);
 	current->active_mm = mm;
-- 
1.6.4.rc0

