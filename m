From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 01 Sep 2015 15:12:41 +0000
Subject: [PATCH 6/6] arm64: renesas: select MFD_SYSCON
Message-Id: <1441120361-1232-7-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The Clock Pulse Generator (CPG) relies on syscon to obtain the values of
the mode pins.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 25a90317e8e932cf..7022581cf792d3be 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -72,6 +72,7 @@ config ARCH_SHMOBILE
 config ARCH_RENESAS
 	bool "Renesas SoC Platform"
 	select ARCH_SHMOBILE
+	select MFD_SYSCON
 	select PM_GENERIC_DOMAINS if PM
 	help
 	  This enables support for the ARMv8 based Renesas SoCs.
-- 
1.9.1

