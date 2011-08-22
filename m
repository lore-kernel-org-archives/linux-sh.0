From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 22 Aug 2011 15:56:08 +0000
Subject: [PATCH 1/2] sh: Fix unaligned memory access for branches without delay
Message-Id: <1314028568-7571-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch just clears the return code for those cases where an
unaligned memory access occurs on branch instructions without a
delay slot.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/sh/kernel/traps_32.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index d9006f8..61fa4a5 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -466,6 +466,7 @@ int handle_unaligned_access(insn_size_t instruction, struct pt_regs *regs,
 		case 0x0500: /* mov.w @(disp,Rm),R0 */
 			goto simple;
 		case 0x0B00: /* bf   lab - no delayslot*/
+			ret = 0;
 			break;
 		case 0x0F00: /* bf/s lab */
 			ret = handle_delayslot(regs, instruction, ma);
@@ -479,6 +480,7 @@ int handle_unaligned_access(insn_size_t instruction, struct pt_regs *regs,
 			}
 			break;
 		case 0x0900: /* bt   lab - no delayslot */
+			ret = 0;
 			break;
 		case 0x0D00: /* bt/s lab */
 			ret = handle_delayslot(regs, instruction, ma);
-- 
1.7.0.4

