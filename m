From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Date: Sun, 13 Oct 2019 22:13:05 +0000
Subject: [PATCH 1/6] sh: Move cmpxchg-xchg.h to asm-generic
Message-Id: <20191013221310.30748-2-sebastian@breakpoint.cc>
List-Id: <linux-sh.vger.kernel.org>
References: <20191013221310.30748-1-sebastian@breakpoint.cc>
In-Reply-To: <20191013221310.30748-1-sebastian@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>

The header file is very generic and could be reused by other
architectures as long as they provide __cmpxchg_u32().

Move sh's cmpxchg-xchg.h to asm-generic.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/sh/include/asm/Kbuild                                  | 1 +
 {arch/sh/include/asm => include/asm-generic}/cmpxchg-xchg.h | 0
 2 files changed, 1 insertion(+)
 rename {arch/sh/include/asm => include/asm-generic}/cmpxchg-xchg.h (100%)

diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 51a54df22c110..08c1d96286d9d 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
+generic-y += cmpxchg-xchg.h
 generic-y += compat.h
 generic-y += current.h
 generic-y += delay.h
diff --git a/arch/sh/include/asm/cmpxchg-xchg.h b/include/asm-generic/cmpxchg-xchg.h
similarity index 100%
rename from arch/sh/include/asm/cmpxchg-xchg.h
rename to include/asm-generic/cmpxchg-xchg.h
-- 
2.23.0
