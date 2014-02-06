From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Feb 2014 06:20:33 +0000
Subject: [PATCH 13/13] ARM: shmobile: ape6evm: enable CONFIG_DEVTMPFS in defconfig
Message-Id: <0771ddff31186836f62a20c42e7958bd37f7b4ed.1391651074.git.horms+renesas@verge.net.au>
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
 arch/arm/configs/ape6evm_defconfig | 2 ++
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
1.8.5.2

