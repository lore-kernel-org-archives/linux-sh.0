From: Hideo Saito <saito@densan.co.jp>
Date: Sat, 16 Feb 2008 01:12:23 +0000
Subject: needs change macro HAS_SR_RB
Message-Id: <20080216.101223.68566246.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

I wonder if you don't change a name intentionally, if not so ...

diff -pU8 -Naur linux-2.6.24.org/include/asm-sh/entry-macros.S linux-2.6.24/include/asm-sh/entry-macros.S
--- linux-2.6.24.org/include/asm-sh/entry-macros.S	2008-01-25 07:58:37.000000000 +0900
+++ linux-2.6.24/include/asm-sh/entry-macros.S	2008-02-04 11:45:35.000000000 +0900
@@ -7,25 +7,25 @@
 	.endm
 
 	.macro	sti
 	mov	#0xf0, r11
 	extu.b	r11, r11
 	not	r11, r11
 	stc	sr, r10
 	and	r11, r10
-#ifdef CONFIG_HAS_SR_RB
+#ifdef CONFIG_CPU_HAS_SR_RB
 	stc	k_g_imask, r11
 	or	r11, r10
 #endif
 	ldc	r10, sr
 	.endm
 
 	.macro	get_current_thread_info, ti, tmp
-#ifdef CONFIG_HAS_SR_RB
+#ifdef CONFIG_CPU_HAS_SR_RB
 	stc	r7_bank, \ti
 #else
 	mov	#((THREAD_SIZE - 1) >> 10) ^ 0xff, \tmp
 	shll8	\tmp
 	shll2	\tmp
 	mov	r15, \ti
 	and	\tmp, \ti
 #endif	
