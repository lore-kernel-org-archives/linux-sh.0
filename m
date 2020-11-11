From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Wed, 11 Nov 2020 13:33:51 +0000
Subject: [PATCH seccomp v2 5/8] s390: Enable seccomp architecture tracking
Message-Id: <a381b10aa2c5b1e583642f3cd46ced842d9d4ce5.1605101222.git.yifeifz2@illinois.edu>
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
for s390.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/s390/include/asm/seccomp.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/include/asm/seccomp.h b/arch/s390/include/asm/seccomp.h
index 795bbe0d7ca6..71d46f0ba97b 100644
--- a/arch/s390/include/asm/seccomp.h
+++ b/arch/s390/include/asm/seccomp.h
@@ -16,4 +16,13 @@
 
 #include <asm-generic/seccomp.h>
 
+#define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_S390X
+#define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+#define SECCOMP_ARCH_NATIVE_NAME	"s390x"
+#ifdef CONFIG_COMPAT
+# define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_S390
+# define SECCOMP_ARCH_COMPAT_NR		NR_syscalls
+# define SECCOMP_ARCH_COMPAT_NAME	"s390"
+#endif
+
 #endif	/* _ASM_S390_SECCOMP_H */
-- 
2.29.2
