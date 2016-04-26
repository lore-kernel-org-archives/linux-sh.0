From: Rich Felker <dalias@libc.org>
Date: Tue, 26 Apr 2016 01:24:18 +0000
Subject: [PATCH] sh: fix futex/robust_list on nommu models
Message-Id: <20160426012418.GA3927@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The futex cmpxchg runtime testing in kernel/futex.c depends on
accesses to address 0 producing EFAULT, which obviously does not work
on nommu. Since SH always has cmpxchg, disable the broken runtime
detection.

At some point this should be fixed at the kernel/futex.c level. UP
machines can always provide a working cmpxchg with interrupt masking,
and SMP cannot function without a working cmpxchg anyway.

Signed-off-by: Rich Felker <dalias@libc.org>
---
 arch/sh/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 0223e5e..4fa5894 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -44,6 +44,7 @@ config SUPERH
 	select OLD_SIGSUSPEND
 	select OLD_SIGACTION
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_FUTEX_CMPXCHG if FUTEX
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
-- 
2.8.1

