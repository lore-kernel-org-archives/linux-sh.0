From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 22 Aug 2011 15:56:37 +0000
Subject: [PATCH 2/2] sh: Add unaligned memory access for PC relative intructions
Message-Id: <1314028597-7612-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This add unaligned memory access support for the following instructions:
  mov.w @(disp,PC),Rn
  mov.l @(disp,PC),Rn

These instructions are often used on SH2A toolchains.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/sh/kernel/traps_32.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index 61fa4a5..957c506 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -316,6 +316,37 @@ static int handle_unaligned_ins(insn_size_t instruction, struct pt_regs *regs,
 			break;
 		}
 		break;
+
+	case 9: /* mov.w @(disp,PC),Rn */
+		srcu = (unsigned char __user *)regs->pc;
+		srcu += (instruction & 0x00FF) << 1;
+		dst = (unsigned char *)rn;
+		*(unsigned long *)dst = 0;
+
+#if !defined(__LITTLE_ENDIAN__)
+		dst += 2;
+#endif
+
+		if (ma->from(dst, srcu, 2))
+			goto fetch_fault;
+		sign_extend(2, dst);
+		ret = 0;
+		break;
+
+	case 0xd: /* mov.l @(disp,PC),Rn */
+		srcu = (unsigned char __user *)regs->pc;
+		srcu += (instruction & 0x00FF) << 2;
+		dst = (unsigned char *)rn;
+		*(unsigned long *)dst = 0;
+
+#if !defined(__LITTLE_ENDIAN__)
+		dst += 2;
+#endif
+
+		if (ma->from(dst, srcu, 4))
+			goto fetch_fault;
+		ret = 0;
+		break;
 	}
 	return ret;
 
@@ -496,6 +527,9 @@ int handle_unaligned_access(insn_size_t instruction, struct pt_regs *regs,
 		}
 		break;
 
+	case 0x9000: /* mov.w @(disp,Rm),Rn */
+		goto simple;
+
 	case 0xA000: /* bra label */
 		ret = handle_delayslot(regs, instruction, ma);
 		if (ret=0)
@@ -509,6 +543,9 @@ int handle_unaligned_access(insn_size_t instruction, struct pt_regs *regs,
 			regs->pc += SH_PC_12BIT_OFFSET(instruction);
 		}
 		break;
+
+	case 0xD000: /* mov.l @(disp,Rm),Rn */
+		goto simple;
 	}
 	return ret;
 
-- 
1.7.0.4

