From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Wed, 11 Nov 2020 13:33:49 +0000
Subject: [PATCH seccomp v2 3/8] powerpc: Enable seccomp architecture tracking
Message-Id: <0b64925362671cdaa26d01bfe50b3ba5e164adfd.1605101222.git.yifeifz2@illinois.edu>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1605101222.git.yifeifz2@illinois.edu>
In-Reply-To: <cover.1605101222.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: containers@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, Tobin Feldman-Fitzthum <tobin@ibm.com>, Hubertus Franke <frankeh@us.ibm.com>, Jack Chen <jianyan2@illinois.edu>, linux-riscv@lists.infradead.org, Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org, YiFei Zhu <yifeifz2@illinois.edu>, linux-csky@vger.kernel.org, Tianyin Xu <tyxu@illinois.edu>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Valentin Rothberg <vrothber@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, Josep Torrellas <torrella@illinois.edu>, Will Drewry <wad@chromium.org>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Dimitrios Skarlatos <dskarlat@cs.cmu.edu>, David Laight <David.Laight@aculab.com>, Giuseppe Scrivano <gscrivan@redhat.com>, linuxppc-dev@lists.ozlabs.org

From: YiFei Zhu <yifeifz2@illinois.edu>

To enable seccomp constant action bitmaps, we need to have a static
mapping to the audit architecture and system call table size. Add these
for powerpc.

__LITTLE_ENDIAN__ is used here instead of CONFIG_CPU_LITTLE_ENDIAN
to keep it consistent with asm/syscall.h.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/powerpc/include/asm/seccomp.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/powerpc/include/asm/seccomp.h b/arch/powerpc/include/asm/seccomp.h
index 51209f6071c5..ac2033f134f0 100644
--- a/arch/powerpc/include/asm/seccomp.h
+++ b/arch/powerpc/include/asm/seccomp.h
@@ -8,4 +8,27 @@
 
 #include <asm-generic/seccomp.h>
 
+#ifdef __LITTLE_ENDIAN__
+#define __SECCOMP_ARCH_LE		__AUDIT_ARCH_LE
+#define __SECCOMP_ARCH_LE_NAME		"le"
+#else
+#define __SECCOMP_ARCH_LE		0
+#define __SECCOMP_ARCH_LE_NAME
+#endif
+
+#ifdef CONFIG_PPC64
+# define SECCOMP_ARCH_NATIVE		(AUDIT_ARCH_PPC64 | __SECCOMP_ARCH_LE)
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"ppc64" __SECCOMP_ARCH_LE_NAME
+# ifdef CONFIG_COMPAT
+#  define SECCOMP_ARCH_COMPAT		(AUDIT_ARCH_PPC | __SECCOMP_ARCH_LE)
+#  define SECCOMP_ARCH_COMPAT_NR	NR_syscalls
+#  define SECCOMP_ARCH_COMPAT_NAME	"ppc" __SECCOMP_ARCH_LE_NAME
+# endif
+#else /* !CONFIG_PPC64 */
+# define SECCOMP_ARCH_NATIVE		(AUDIT_ARCH_PPC | __SECCOMP_ARCH_LE)
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"ppc" __SECCOMP_ARCH_LE_NAME
+#endif
+
 #endif	/* _ASM_POWERPC_SECCOMP_H */
-- 
2.29.2
