From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 06 Dec 2013 01:41:19 +0000
Subject: [PATCH 2/2] ARM: shmobile: armadillo800eva: Enable SMSC_PHY in defconfig
Message-Id: <1386294079-16392-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1386294079-16392-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1386294079-16392-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The armadillo800eva board uses has an SMSC LAN8710A phy.
Enable SMSC_PHY in the defconfig to make use of the SMSC-specific phy
driver rather than relying on the generic phy driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/armadillo800eva_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 5abf1a2..6162a4b 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -75,6 +75,7 @@ CONFIG_SH_ETH=y
 # CONFIG_NET_VENDOR_SEEQ is not set
 # CONFIG_NET_VENDOR_SMSC is not set
 # CONFIG_NET_VENDOR_STMICRO is not set
+CONFIG_SMSC_PHY=y
 # CONFIG_WLAN is not set
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
-- 
1.8.4

