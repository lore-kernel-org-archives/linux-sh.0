From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Fri, 11 Apr 2008 06:21:44 +0000
Subject: sh: fix compressed kernel build
Message-Id: <20080411062144.GA2136@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This should probably go to Linus before he releases 2.6.25.
I'm also not sure about the sh64 bit since I don't have a working toolchain for it.

--- 

commit 54a015104136974262afa4b8ddd943ea70dec8a2 broke zImage build on sh arch:

 LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  AS      arch/sh/boot/compressed/head_32.o
In file included from /k/arch/sh/boot/compressed/head_32.S:11:
/k/include/linux/linkage.h:34: error: syntax error in macro parameter list

Fix it for both sh and sh64.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/sh/boot/compressed/head_32.S |    1 -
 arch/sh/boot/compressed/head_64.S |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boot/compressed/head_32.S b/arch/sh/boot/compressed/head_32.S
index a8399b0..06ac31f 100644
--- a/arch/sh/boot/compressed/head_32.S
+++ b/arch/sh/boot/compressed/head_32.S
@@ -7,7 +7,6 @@
 
 .text
 
-#include <linux/linkage.h>
 #include <asm/page.h>
 
 	.global	startup
diff --git a/arch/sh/boot/compressed/head_64.S b/arch/sh/boot/compressed/head_64.S
index 1d4ecbf..f72c198 100644
--- a/arch/sh/boot/compressed/head_64.S
+++ b/arch/sh/boot/compressed/head_64.S
@@ -13,7 +13,6 @@
  * Modification for compressed loader:
  *   Copyright (C) 2002 Stuart Menefy (stuart.menefy@st.com)
  */
-#include <linux/linkage.h>
 #include <asm/cache.h>
 #include <asm/cpu/mmu_context.h>
 #include <asm/cpu/registers.h>
-- 
1.5.4.5

