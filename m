From: Hideo Saito <saito@densan.co.jp>
Date: Wed, 14 May 2008 01:38:12 +0000
Subject: fix memcpy-sh4.S
Message-Id: <20080514.103812.68564161.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

In the code on memcpy-sh4.S with big endian, it seems that the following fix is needed.

--- ./arch/sh/lib/memcpy-sh4.S.org	2008-04-17 11:49:44.000000000 +0900
+++ ./arch/sh/lib/memcpy-sh4.S	2008-04-21 15:02:58.000000000 +0900
@@ -121,20 +121,20 @@
 	shlr8	r6		! 106 EX		! xxxN
 	mov	r1, r7		!   5 MT (latency=0)
 
 	or	r6,r3		!  82 EX		! QPON
 	bt/s	3b		! 109 BR
 
 	 mov.l	r3,@-r0		!  30 LS
 #else
-3:	mov	r1,r3		! OPQR
+3:	mov	r7,r3		! OPQR
 	shlr8	r3		! xOPQ
-	mov.l	@(r0,r5),r1	! KLMN
-	mov	r1,r6
+	mov.l	@(r0,r5),r7	! KLMN
+	mov	r7,r6
 	shll16	r6
 	shll8	r6		! Nxxx
 	or	r6,r3		! NOPQ
 	cmp/hi	r2,r0
 	bt/s	3b
 	 mov.l	r3,@-r0
 #endif
 
@@ -728,34 +728,34 @@ ENTRY(memcpy)
 	xtrct	r9, r8		!  48 EX
 
 	mov.l   @(0x00,r5), r12 !  18 LS (latency=2)
     	xtrct	r10, r9		!  48 EX
 
 	movca.l	r0,@r1		!  40 LS (latency=3-7)
 	add	#-0x1c, r1	!  50 EX
 
-	mov.l	r3, @(0x1c,r1)	!  33 LS
+	mov.l	r3, @(0x18,r1)	!  33 LS
 	xtrct	r11, r10	!  48 EX
 
-	mov.l	r6, @(0x18,r1)	!  33 LS
+	mov.l	r6, @(0x14,r1)	!  33 LS
 	xtrct	r12, r11	!  48 EX
 
-	mov.l	r7, @(0x14,r1)	!  33 LS
+	mov.l	r7, @(0x10,r1)	!  33 LS
 
-	mov.l	r8, @(0x10,r1)	!  33 LS
-	add	#-0x3e, r5	!  50 EX
+	mov.l	r8, @(0x0c,r1)	!  33 LS
+	add	#-0x1e, r5	!  50 EX
 
-	mov.l	r9, @(0x0c,r1)	!  33 LS
+	mov.l	r9, @(0x08,r1)	!  33 LS
 	cmp/eq	r2,r1		!  54 MT
 
-	mov.l	r10, @(0x08,r1)	!  33 LS
+	mov.l	r10, @(0x04,r1)	!  33 LS
 	bf/s	2b		! 109 BR
 
-	 mov.l	r11, @(0x04,r1)	!  33 LS
+	 mov.l	r11, @(0x00,r1)	!  33 LS
 #endif
 
 	mov.l	@r15+, r12
 	mov	r1, r0		!   5 MT (latency=0)
 
 	mov.l	@r15+, r11	!  15 LS
 	sub	r1, r5		!  75 EX
 
