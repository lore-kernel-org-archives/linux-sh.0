From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 04 Dec 2014 03:57:50 +0000
Subject: [PATCH 2/2] ARM: shmobile: defconfig: add MTD_BLOCK
Message-Id: <877fy883sj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

MTD_BLOOK is needed for accessing to SPI-FLASH

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reported-by: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Reported-by: Bui Duc Phuc ( Fukuda ) <bd-phuc@jinso.co.jp>
Reported-by: Nguyen Xuan Nui <nx-nui@jinso.co.jp>
---
 arch/arm/configs/shmobile_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index e04610b..fd84123 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -55,6 +55,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_EEPROM_AT24=y
-- 
1.7.9.5

