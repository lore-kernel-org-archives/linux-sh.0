From: Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 18 Sep 2020 02:14:04 +0000
Subject: [PATCH v2 RESEND +TRIVIAL] arch/sh: hyphenate Non-Uniform in Kconfig prompt
Message-Id: <93d98bab-01dd-5530-9fdb-76faf8dcdd41@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <trivial@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Hyphenate Non-Uniform in the NUMA kconfig prompt.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: Jiri Kosina <trivial@kernel.org>
---
v2: rebase from JAN-2020 to current.

 arch/sh/mm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200917.orig/arch/sh/mm/Kconfig
+++ linux-next-20200917/arch/sh/mm/Kconfig
@@ -105,7 +105,7 @@ config VSYSCALL
 	  (the default value) say Y.
 
 config NUMA
-	bool "Non Uniform Memory Access (NUMA) Support"
+	bool "Non-Uniform Memory Access (NUMA) Support"
 	depends on MMU && SYS_SUPPORTS_NUMA
 	select ARCH_WANT_NUMA_VARIABLE_LOCALITY
 	default n
