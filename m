From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 30 Jan 2014 00:57:24 +0000
Subject: [PATCH 07/10] ARM: shmobile: genmai: enable CONFIG_DEVTMPFS in defconfig
Message-Id: <87bnyui8wd.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DEVTMPFS is needed for udev

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/genmai_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/genmai_defconfig b/arch/arm/configs/genmai_defconfig
index aa0b704f..c56a7ff 100644
--- a/arch/arm/configs/genmai_defconfig
+++ b/arch/arm/configs/genmai_defconfig
@@ -50,6 +50,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_CORE is not set
 # CONFIG_NET_VENDOR_ARC is not set
-- 
1.7.9.5

