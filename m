From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 24 Jul 2015 08:41:48 +0000
Subject: [PATCH 7/9] ARM: multi_v7_defconfig: Remove Marzen
Message-Id: <8dd80b6d7c5bac89315d07c0c2495fe31d0cb348.1437726584.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1437726584.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1437726584.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Kill of the defconfig bits now when the marzen-reference board code is gone.

Based on work by Magnus Damm.

Acked-by: Magnus Damm <damm@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6d83a1bf0c74..b34cd868daa5 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -82,7 +82,6 @@ CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
-CONFIG_MACH_MARZEN=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_SIRF=y
 CONFIG_ARCH_TEGRA=y
-- 
2.1.4

