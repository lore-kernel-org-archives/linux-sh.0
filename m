Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1392D56B6F
	for <linux-sh@vger.kernel.org>; Fri,  1 Mar 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326970; cv=none; b=ejCyxeC0wZF7qFmEXhoCs81mcl9wBscBQQ0JaIQv+KLYWdyNMuDCHkc1wYbczD+dSpiIdsH4vSp0C78XcuMov/XUVAIWpb/VxC1dUipYaiwn293xWaLP5UeMrCNljn+CyfWmA1ImrR8MYov7LdOYjb7SXzFY5E/Hfa8iZhsJ+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326970; c=relaxed/simple;
	bh=iFhRPXkYrRTAyOSfLti9NFRV7ZKuRkjcotdtKCX33/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/z1kLpOfVav10Fd4iqRECrpeg0vjf2zjlErJU69JID7L7DNAJkZo3OVMt6hZLLRBEqPTrFwVHjO89qdPQAnPfSAuRwj7aNAr1BKJFakg+Dz+86Z54jBW4A6/VoBoSuI+wzQ5Nn7ip3YJuUxpEzz6lcLA2pgd6FW5mHEDMFoFAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by michel.telenet-ops.be with bizsmtp
	id tZ2e2B00A1TWuYv06Z2ewx; Fri, 01 Mar 2024 22:02:43 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024gY-Ap;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8rb-52;
	Fri, 01 Mar 2024 22:02:38 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 09/20] sh: ftrace: Fix missing prototypes
Date: Fri,  1 Mar 2024 22:02:23 +0100
Message-Id: <910c8846a025e1c3b744a83ddf8e2816a3c5569d.1709326528.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709326528.git.geert+renesas@glider.be>
References: <cover.1709326528.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

arch/sh/kernel/ftrace.c:130:6: warning: no previous prototype for ‘arch_ftrace_nmi_enter’ [-Wmissing-prototypes]
arch/sh/kernel/ftrace.c:140:6: warning: no previous prototype for ‘arch_ftrace_nmi_exit’ [-Wmissing-prototypes]
arch/sh/kernel/ftrace.c:316:6: warning: no previous prototype for ‘prepare_ftrace_return’ [-Wmissing-prototypes]

Fix this by moving existing forward declarations to <asm/ftrace.h>, and
adding the missing forward declaration for prepare_ftrace_return().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/include/asm/ftrace.h | 10 ++++++++++
 arch/sh/kernel/traps.c       | 10 ++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/sh/include/asm/ftrace.h b/arch/sh/include/asm/ftrace.h
index b1c1dc0cc261d1db..1c10e106639098fc 100644
--- a/arch/sh/include/asm/ftrace.h
+++ b/arch/sh/include/asm/ftrace.h
@@ -33,6 +33,8 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
+void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr);
+
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 
@@ -43,6 +45,14 @@ extern void *return_address(unsigned int);
 
 #define ftrace_return_address(n) return_address(n)
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+extern void arch_ftrace_nmi_enter(void);
+extern void arch_ftrace_nmi_exit(void);
+#else
+static inline void arch_ftrace_nmi_enter(void) { }
+static inline void arch_ftrace_nmi_exit(void) { }
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_SH_FTRACE_H */
diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index 01884054aeb2bd30..4339c4cafa79ce2a 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -15,6 +15,8 @@
 
 #include <linux/extable.h>
 #include <linux/module.h>	/* print_modules */
+
+#include <asm/ftrace.h>
 #include <asm/unwinder.h>
 #include <asm/traps.h>
 
@@ -170,14 +172,6 @@ BUILD_TRAP_HANDLER(bug)
 	force_sig(SIGTRAP);
 }
 
-#ifdef CONFIG_DYNAMIC_FTRACE
-extern void arch_ftrace_nmi_enter(void);
-extern void arch_ftrace_nmi_exit(void);
-#else
-static inline void arch_ftrace_nmi_enter(void) { }
-static inline void arch_ftrace_nmi_exit(void) { }
-#endif
-
 BUILD_TRAP_HANDLER(nmi)
 {
 	TRAP_HANDLER_DECL;
-- 
2.34.1

