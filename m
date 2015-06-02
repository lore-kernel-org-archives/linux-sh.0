From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 02 Jun 2015 01:34:37 +0000
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable shmobile r8a7793/gose platform
Message-Id: <1433208877-3284-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1433208877-3284-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1433208877-3284-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 0d6d6984eb71..ffe3346529f9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -72,6 +72,7 @@ CONFIG_ARCH_R8A7740=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
+CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_MACH_MARZEN=y
-- 
2.1.4

