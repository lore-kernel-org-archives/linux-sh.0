From: Simon Horman <horms+renesas@verge.net.au>
Date: Sat, 23 Aug 2014 01:44:13 +0000
Subject: [PATCH 8/8] ARM: shmobile: defconfig: enable initrd
Message-Id: <874ee23c83d888f8824305c277e047c7799f30b9.1408670623.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1408670623.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1408670623.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kevin Hilman <khilman@linaro.org>

Enable initrd support.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
[horms+renesas@verge.net.au: dropped enabling atag dtb compat]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 0cd63f5..b7ebf1e 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -3,6 +3,7 @@ CONFIG_NO_HZ=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
-- 
2.0.1

