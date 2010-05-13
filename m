From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 13 May 2010 14:19:22 +0000
Subject: [PATCH] sh: allow romImage data between head.S and the zero page
Message-Id: <20100513141922.20425.48182.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Extend the romImage code to allow putting data between
the head.S file and the empty_zero_page. Needed in the
case of more advanced loader code in a separate C file.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boot/romimage/head.S      |   12 +++++++++---
 arch/sh/boot/romimage/vmlinux.scr |    1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

--- 0001/arch/sh/boot/romimage/head.S
+++ work/arch/sh/boot/romimage/head.S	2010-05-07 19:49:01.000000000 +0900
@@ -13,7 +13,9 @@ romstart:
 #include <mach/romimage.h>
 
 	/* copy the empty_zero_page contents to where vmlinux expects it */
-	mova	empty_zero_page_src, r0
+	mova	extra_data_pos, r0
+	mov.l	extra_data_size, r1
+	add	r1, r0
 	mov.l	empty_zero_page_dst, r1
 	mov	#(PAGE_SHIFT - 4), r4
 	mov	#1, r3
@@ -37,7 +39,9 @@ romstart:
 	mov	#PAGE_SHIFT, r4
 	mov	#1, r1
 	shld	r4, r1
-	mova	empty_zero_page_src, r0
+	mova	extra_data_pos, r0
+	add	r1, r0
+	mov.l	extra_data_size, r1
 	add	r1, r0
 	jmp	@r0
 	 nop
@@ -45,4 +49,6 @@ romstart:
 	.align 2
 empty_zero_page_dst:
 	.long	_text
-empty_zero_page_src:
+extra_data_pos:
+extra_data_size:
+	.long	zero_page_pos - extra_data_pos
--- 0001/arch/sh/boot/romimage/vmlinux.scr
+++ work/arch/sh/boot/romimage/vmlinux.scr	2010-05-07 19:46:57.000000000 +0900
@@ -1,6 +1,7 @@
 SECTIONS
 {
   .text : {
+	zero_page_pos = .;
 	*(.data)
 	}
 }
