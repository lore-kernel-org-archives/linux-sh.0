From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Aug 2009 10:31:53 +0000
Subject: [PATCH] sh: let ARCH_SHMOBILE select PM and PM_RUNTIME
Message-Id: <20090819103153.12327.77501.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

With the Runtime PM driver changes in place, we must have
Runtime PM support in place. Otherwise there is no way to
enable clocks to the Runtime PM enabled hardware blocks.
This patch makes Runtime PM mandatory on SuperH Mobile.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 For the everchanging sh/pm-runtime topic branch.

 arch/sh/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-08-17 18:57:45.000000000 +0900
@@ -219,6 +219,8 @@ config CPU_SHX3
 config ARCH_SHMOBILE
 	bool
 	select ARCH_SUSPEND_POSSIBLE
+	select PM
+	select PM_RUNTIME
 
 if SUPERH32
 
