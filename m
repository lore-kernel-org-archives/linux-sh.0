From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 15 Jul 2015 06:45:23 +0000
Subject: [PATCH] ARM: multi_v7_defconfig: Remove Marzen
Message-Id: <1436942723-5934-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Kill of the defconfig bits now when the marzen-reference board code is gone.

Based on work by Magnus Damm.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

---
Tested on top of renesas-next-20150715-v4.2-rc1

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

