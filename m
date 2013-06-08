From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 08 Jun 2013 00:07:13 +0000
Subject: [PATCH 9/9] sh_eth: remove dependencies from Kconfig
Message-Id: <201306080407.14357.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201306080351.39018.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306080351.39018.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

Since dependence on the certain SoCs is no  longer  necessary to compile the
driver, remove the dependency list from its Kconfig entry which is a popular
demand anyway...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/Kconfig |    6 ------
 1 file changed, 6 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/Kconfig
=================================--- net-next.orig/drivers/net/ethernet/renesas/Kconfig
+++ net-next/drivers/net/ethernet/renesas/Kconfig
@@ -4,12 +4,6 @@
 
 config SH_ETH
 	tristate "Renesas SuperH Ethernet support"
-	depends on (SUPERH || ARCH_SHMOBILE) && \
-		(CPU_SUBTYPE_SH7710 || CPU_SUBTYPE_SH7712 || \
-		 CPU_SUBTYPE_SH7763 || CPU_SUBTYPE_SH7619 || \
-		 CPU_SUBTYPE_SH7724 || CPU_SUBTYPE_SH7734 || \
-		 CPU_SUBTYPE_SH7757 || ARCH_R8A7740 || \
-		 ARCH_R8A7778 || ARCH_R8A7779)
 	select CRC32
 	select NET_CORE
 	select MII
