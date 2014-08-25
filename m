From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 Aug 2014 03:36:44 +0000
Subject: [PATCH v2 01/02] ARM: shmobile: Only select PM_RMOBILE for legacy case
Message-Id: <20140825033644.9284.77026.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the ARM mach-shmobile Kconfig bits to only
select PM_RMOBILE in case of legacy. This allows us
to enable partial multiplatform support for various
SoCs before Power Domains DT bindings are finalized.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0007/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-08-19 22:56:40.000000000 +0900
@@ -22,7 +22,7 @@ config ARCH_RCAR_GEN2
 
 config ARCH_RMOBILE
 	bool
-	select PM_RMOBILE if PM
+	select PM_RMOBILE if PM && !ARCH_SHMOBILE_MULTI
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
 
