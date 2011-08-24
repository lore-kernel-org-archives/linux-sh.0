From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 24 Aug 2011 10:43:59 +0000
Subject: [PATCH 2/2 v3] sh: Add unaligned memory access for PC relative
Message-Id: <1314182639-15213-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds unaligned memory access support for the following instructions:
  mov.w @(disp,PC),Rn
  mov.l @(disp,PC),Rn

These instructions are often used on SH2A toolchains.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v3:
  Fixed the PC relative address calculation
v2:
  Fixed the mov.l case for big endian
  Fixed typo in commit msg

 arch/sh/kernel/traps_32.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index 61fa4a5..7bbef95 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -316,6 +316,35 @@ static int handle_unaligned_ins(insn_size_t instruction, struct pt_regs *regs,
 			break;
 		}
 		break;
+
+	case 9: /* mov.w @(disp,PC),Rn */
+		srcu = (unsigned char __user *)regs->pc;
+		srcu += 4;
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
+		srcu = (unsigned char __user *)(regs->pc & ~0x3);
+		srcu += 4;
+		srcu += (instruction & 0x00FF) << 2;
+		dst = (unsigned char *)rn;
+		*(unsigned long *)dst = 0;
+
+		if (ma->from(dst, srcu, 4))
+			goto fetch_fault;
+		ret = 0;
+		break;
 	}
 	return ret;
 
@@ -496,6 +525,9 @@ int handle_unaligned_access(insn_size_t instruction, struct pt_regs *regs,
 		}
 		break;
 
+	case 0x9000: /* mov.w @(disp,Rm),Rn */
+		goto simple;
+
 	case 0xA000: /* bra label */
 		ret = handle_delayslot(regs, instruction, ma);
 		if (ret=0)
@@ -509,6 +541,9 @@ int handle_unaligned_access(insn_size_t instruction, struct pt_regs *regs,
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

