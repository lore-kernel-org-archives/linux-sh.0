From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 30 Jan 2014 00:57:49 +0000
Subject: [PATCH 09/10] ARM: shmobile: armadillo: enable CONFIG_DEVTMPFS in defconfig
Message-Id: <878utyi8vp.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DEVTMPFS is needed for udev

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/armadillo800eva_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 9287a62..065addd 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -58,6 +58,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_MD=y
-- 
1.7.9.5

