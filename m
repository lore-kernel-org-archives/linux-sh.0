From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 30 Jan 2014 00:57:59 +0000
Subject: [PATCH 10/10] ARM: shmobile: ape6evm: enable CONFIG_DEVTMPFS in defconfig
Message-Id: <877g9ii8vf.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DEVTMPFS is needed for udev

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/ape6evm_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/ape6evm_defconfig b/arch/arm/configs/ape6evm_defconfig
index cb26c62..bb396c0 100644
--- a/arch/arm/configs/ape6evm_defconfig
+++ b/arch/arm/configs/ape6evm_defconfig
@@ -48,6 +48,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_IPV6_SIT is not set
 CONFIG_NETFILTER=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FW_LOADER_USER_HELPER is not set
 CONFIG_NETDEVICES=y
 # CONFIG_NET_CADENCE is not set
-- 
1.7.9.5

