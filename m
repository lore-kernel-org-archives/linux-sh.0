From: Christoph Hellwig <hch@lst.de>
Date: Wed, 01 May 2019 17:39:41 +0000
Subject: [PATCH 3/5] sh: don't use asm-generic/ptrace.h
Message-Id: <20190501173943.5688-4-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190501173943.5688-1-hch@lst.de>
In-Reply-To: <20190501173943.5688-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Doing the indirection through macros for the regs accessors just
makes them harder to read, so implement the helpers directly.

Note that only the helpers actually used are implemented now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/ptrace.h | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/ptrace.h b/arch/sh/include/asm/ptrace.h
index 9143c7babcbe..6c89e3e04cee 100644
--- a/arch/sh/include/asm/ptrace.h
+++ b/arch/sh/include/asm/ptrace.h
@@ -16,8 +16,31 @@
 #define user_mode(regs)			(((regs)->sr & 0x40000000)=0)
 #define kernel_stack_pointer(_regs)	((unsigned long)(_regs)->regs[15])
 
-#define GET_FP(regs)	((regs)->regs[14])
-#define GET_USP(regs)	((regs)->regs[15])
+static inline unsigned long instruction_pointer(struct pt_regs *regs)
+{
+	return regs->pc;
+}
+static inline void instruction_pointer_set(struct pt_regs *regs,
+		unsigned long val)
+{
+	regs->pc = val;
+}
+
+static inline unsigned long frame_pointer(struct pt_regs *regs)
+{
+	return regs->regs[14];
+}
+
+static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+{
+	return regs->regs[15];
+}
+
+static inline void user_stack_pointer_set(struct pt_regs *regs,
+		unsigned long val)
+{
+	regs->regs[15] = val;
+}
 
 #define arch_has_single_step()	(1)
 
@@ -112,7 +135,5 @@ static inline unsigned long profile_pc(struct pt_regs *regs)
 
 	return pc;
 }
-#define profile_pc profile_pc
 
-#include <asm-generic/ptrace.h>
 #endif /* __ASM_SH_PTRACE_H */
-- 
2.20.1
