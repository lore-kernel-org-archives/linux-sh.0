From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Date: Wed, 17 Nov 2010 06:51:52 +0000
Subject: [PATCH (sh-2.6)] sh: fix vsyscall compilation due to .eh_frame issue
Message-Id: <1289976712-27750-1-git-send-email-peppe.cavallaro@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes the following error obtained when
compile the Kernel with the VSYSCALL support enabled:

  SYSCALL arch/sh/kernel/vsyscall/vsyscall-trapa.so
  sh4-linux/bin/ld: error in arch/sh/kernel/vsyscall/vsyscall-trapa.o(.eh_frame);
  no .eh_frame_hdr table will be created.
  AS      arch/sh/kernel/vsyscall/vsyscall-syscall.o

Disassembling the vsyscall-trapa.o code, with this fix applied,
we get the __kernel_vsyscall symbol defined; otherwise it was
missing.

Disassembly of section .text:

00000000 <__kernel_vsyscall>:
   0:	10 00       	.word 0x0010
   2:	00 00       	.word 0x0000
[snip]
0000040 <__kernel_sigreturn>:
  40:	05 93       	mov.w	4e <__kernel_sigreturn+0xe>,r3	! 77
  42:	10 c3       	trapa	#16
[snip]

00000060 <__kernel_rt_sigreturn>:
  60:	05 93       	mov.w	6e <__kernel_rt_sigreturn+0xe>,r3	! ad
  62:	10 c3       	trapa	#16
[snip]

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Reviewed-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 arch/sh/kernel/vsyscall/vsyscall-trapa.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/vsyscall/vsyscall-trapa.S b/arch/sh/kernel/vsyscall/vsyscall-trapa.S
index 3b6eb34..3e70f85 100644
--- a/arch/sh/kernel/vsyscall/vsyscall-trapa.S
+++ b/arch/sh/kernel/vsyscall/vsyscall-trapa.S
@@ -8,9 +8,9 @@ __kernel_vsyscall:
 	 * fill out .eh_frame -- PFM. */
 .LEND_vsyscall:
 	.size __kernel_vsyscall,.-.LSTART_vsyscall
-	.previous
 
 	.section .eh_frame,"a",@progbits
+	.previous
 .LCIE:
 	.ualong	.LCIE_end - .LCIE_start
 .LCIE_start:
-- 
1.5.5.6

