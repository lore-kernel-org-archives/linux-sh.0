From: shinkoi2005 <shinkoi2005@gmail.com>
Date: Mon, 08 Dec 2008 14:04:11 +0000
Subject: [PATCH] SH: Delete unnecessary mov in the top of interrupt
Message-Id: <493D295B.1010806@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, all.

I think that to move INTEVT address to the scratch reg in the top of
interrupt is already unnecessary.
So this patch delete it.

Signed-off-by: Aoi Shinkai <shinkoi2005@gmail.com>
---
 b/arch/sh/kernel/cpu/sh3/entry.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
--- a/arch/sh/kernel/cpu/sh3/entry.S	2008-12-08 19:42:26.000000000 +0900
+++ b/arch/sh/kernel/cpu/sh3/entry.S	2008-12-08 19:42:42.000000000 +0900
@@ -376,9 +376,9 @@ tlb_miss:
 !
 	.balign 	512,0,512
 interrupt:
-	mov.l	2f, k2
 	mov.l	3f, k3
 #if defined(CONFIG_KGDB_NMI)
+	mov.l	2f, k2
 	! Debounce (filter nested NMI)
 	mov.l	@k2, k0
 	mov.l	5f, k1
@@ -390,6 +390,7 @@ interrupt:
 	rte
 	 nop
 	.align	2
+2:	.long	INTEVT
 5:	.long	NMI_VEC
 6:	.long	in_nmi
 0:
@@ -399,7 +400,6 @@ interrupt:

 	.align	2
 1:	.long	EXPEVT
-2:	.long	INTEVT
 3:	.long	ret_from_irq
 4:	.long	ret_from_exception

