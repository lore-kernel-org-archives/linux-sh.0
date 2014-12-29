From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 29 Dec 2014 01:47:07 +0000
Subject: [PATCH 4/4] ARM: shmobile: r8a73a4: Multiplatform support
Message-Id: <39695882d3d642a73bca551e682426e4e3bcd158.1419810196.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1419810196.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1419810196.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Enable r8a73a4 Multiplatform support for the generic r8a73a4
machine vector.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 1b4fafe..d107b93 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -51,6 +51,11 @@ config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
 	select SYS_SUPPORTS_SH_MTU2
 
+config ARCH_R8A73A4
+	bool "R-Mobile APE6 (R8A73A40)"
+	select ARCH_RMOBILE
+	select RENESAS_IRQC
+
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
 	select ARCH_RMOBILE
-- 
2.1.3

