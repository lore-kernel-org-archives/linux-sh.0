From: Randy Dunlap <rdunlap@infradead.org>
Date: Sat, 01 Feb 2020 01:57:52 +0000
Subject: [PATCH] arch/sh: add hyphenation in NUMA Kconfig prompt
Message-Id: <6bae5963-2696-024d-b993-695367a1009c@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Hyphenate Non-Uniform in the NUMA kconfig prompt.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/mm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200131.orig/arch/sh/mm/Kconfig
+++ linux-next-20200131/arch/sh/mm/Kconfig
@@ -107,7 +107,7 @@ config VSYSCALL
 	  (the default value) say Y.
 
 config NUMA
-	bool "Non Uniform Memory Access (NUMA) Support"
+	bool "Non-Uniform Memory Access (NUMA) Support"
 	depends on MMU && SYS_SUPPORTS_NUMA
 	select ARCH_WANT_NUMA_VARIABLE_LOCALITY
 	default n
