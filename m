From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 08 Dec 2014 11:35:24 +0000
Subject: [PATCH] ARM: shmobile: Enable MICREL_PHY in shmobile_defconfig
Message-Id: <1418038524-27990-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

commit 1c9106cb783cd227 ("ARM: shmobile: lager-reference: DTS-only board
support"), dropped the MACH_LAGER Kconfig section, which did "select
MICREL_PHY if SH_ETH". Hence we now have to enable MICREL_PHY explicitly
in shmobile_defconfig.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 7128e81cc83d858d..dfc1efcb4a866ef3 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -78,6 +78,7 @@ CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_SMSC_PHY=y
+CONFIG_MICREL_PHY=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
-- 
1.9.1

