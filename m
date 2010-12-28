From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Dec 2010 08:26:52 +0000
Subject: [PATCH 01/04] ARM: mach-shmobile: Enable CONFIG_MULTI_IRQ_HANDLER
Message-Id: <20101228082652.11806.39945.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Always enable MULTI_IRQ_HANDLER on SH-Mobile.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- 0002/arch/arm/Kconfig
+++ work/arch/arm/Kconfig	2010-12-28 13:47:08.000000000 +0900
@@ -612,6 +612,7 @@ config ARCH_SHMOBILE
 	select GENERIC_CLOCKEVENTS
 	select NO_IOPORT
 	select SPARSE_IRQ
+	select MULTI_IRQ_HANDLER
 	help
 	  Support for Renesas's SH-Mobile and R-Mobile ARM platforms.
 
