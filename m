From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Tue, 03 Nov 2020 13:43:02 +0000
Subject: [PATCH seccomp 6/8] sh: Enable seccomp architecture tracking
Message-Id: <46d7f8d02bdaadf364a59db2d60f43466227b3af.1604410035.git.yifeifz2@illinois.edu>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1604410035.git.yifeifz2@illinois.edu>
In-Reply-To: <cover.1604410035.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: containers@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, Tobin Feldman-Fitzthum <tobin@ibm.com>, Hubertus Franke <frankeh@us.ibm.com>, Jack Chen <jianyan2@illinois.edu>, linux-riscv@lists.infradead.org, Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org, YiFei Zhu <yifeifz2@illinois.edu>, linux-csky@vger.kernel.org, Tianyin Xu <tyxu@illinois.edu>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Valentin Rothberg <vrothber@redhat.com>, Josep Torrellas <torrella@illinois.edu>, Will Drewry <wad@chromium.org>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Dimitrios Skarlatos <dskarlat@cs.cmu.edu>, David Laight <David.Laight@aculab.com>, Giuseppe Scrivano <gscrivan@redhat.com>, linuxppc-dev@lists.ozlabs.org

From: YiFei Zhu <yifeifz2@illinois.edu>

To enable seccomp constant action bitmaps, we need to have a static
mapping to the audit architecture and system call table size. Add these
for sh.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/sh/include/asm/seccomp.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/sh/include/asm/seccomp.h b/arch/sh/include/asm/seccomp.h
index 54111e4d32b8..b8d169292a34 100644
--- a/arch/sh/include/asm/seccomp.h
+++ b/arch/sh/include/asm/seccomp.h
@@ -8,4 +8,14 @@
 #define __NR_seccomp_exit __NR_exit
 #define __NR_seccomp_sigreturn __NR_rt_sigreturn
 
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define __SECCOMP_ARCH_LE_BIT		__AUDIT_ARCH_LE
+#else
+#define __SECCOMP_ARCH_LE_BIT		0
+#endif
+
+#define SECCOMP_ARCH_NATIVE		(AUDIT_ARCH_SH | __SECCOMP_ARCH_LE)
+#define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+#define SECCOMP_ARCH_NATIVE_NAME	"sh"
+
 #endif /* __ASM_SECCOMP_H */
-- 
2.29.2
