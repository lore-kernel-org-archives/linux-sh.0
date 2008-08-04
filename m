From: Takashi Yoshii <yoshii.takashi@renesas.com>
Date: Mon, 04 Aug 2008 05:28:38 +0000
Subject: [PATCH] add addrespace definition for sh2a.
Message-Id: <48969386.4050705@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Newfile: arch/sh/include/cpu-sh2a/cpu/addrspace.h

This file seems had be removed to use fallback (cpu-common/cpu/addrspace.h),
but, I'd like to add sh2a specific file here, because
1. the values defined there are not suitable for sh2a.
2. I don't think there is "common" definition for these values.

Values are chosen by consideration of followings...
 P1 is 0. perhaps no question.
 P2 is from hardware manual, which says no-cache area starts at 20000000.
 It means that P? space size 000000.
 P3 is P2+size since asm/ptrace.h uses P3 as a end of P2. 
 P4 is P3+size since asm/fixup.h uses P4 as a end of P3.

Signed-off-by: Takashi YOSHII <yoshii.takashi@renesas.com>
---
 arch/sh/include/cpu-sh2a/cpu/addrspace.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)
 create mode 100644 arch/sh/include/cpu-sh2a/cpu/addrspace.h

diff --git a/arch/sh/include/cpu-sh2a/cpu/addrspace.h b/arch/sh/include/cpu-sh2a/cpu/addrspace.h
new file mode 100644
index 0000000..31eb4b5
--- /dev/null
+++ b/arch/sh/include/cpu-sh2a/cpu/addrspace.h
@@ -0,0 +1,10 @@
+#ifndef __ASM_SH_CPU_SH2A_ADDRSPACE_H
+#define __ASM_SH_CPU_SH2A_ADDRSPACE_H
+
+#define P0SEG		0x00000000
+#define P1SEG		0x00000000
+#define P2SEG		0x20000000
+#define P3SEG		0x40000000
+#define P4SEG		0x60000000
+
+#endif /* __ASM_SH_CPU_SH2A_ADDRSPACE_H */
-- 
1.5.4.5

