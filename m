From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 May 2010 09:03:19 +0000
Subject: [PATCH] ARM: mach-shmobile: Enable TMU driver build
Message-Id: <20100512090319.32408.43141.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Allow users to build the TMU driver on SH-Mobile ARM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0006/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2010-05-12 17:39:57.000000000 +0900
@@ -94,6 +94,12 @@ config SH_TIMER_CMT
 	help
 	  This enables build of the CMT timer driver.
 
+config SH_TIMER_TMU
+	bool "TMU timer driver"
+	default y
+	help
+	  This enables build of the TMU timer driver.
+
 endmenu
 
 endif
