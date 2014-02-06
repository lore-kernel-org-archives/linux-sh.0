From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Feb 2014 06:20:29 +0000
Subject: [PATCH 09/13] ARM: shmobile: kzm9d: enable CONFIG_DEVTMPFS in defconfig
Message-Id: <c5aa40f8485b9b6aaeae14e5bddd5e569829ac2f.1391651074.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1391651074.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1391651074.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DEVTMPFS is needed for udev

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/kzm9d_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/kzm9d_defconfig b/arch/arm/configs/kzm9d_defconfig
index e42ce37..1cc330b 100644
--- a/arch/arm/configs/kzm9d_defconfig
+++ b/arch/arm/configs/kzm9d_defconfig
@@ -50,6 +50,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_BLK_DEV is not set
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_BROADCOM is not set
-- 
1.8.5.2

