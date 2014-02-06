From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Feb 2014 06:20:31 +0000
Subject: [PATCH 11/13] ARM: shmobile: bockw: enable CONFIG_DEVTMPFS in defconfig
Message-Id: <f921163add46d0dd8321f9d59496bbc17fb38850.1391651074.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1391651074.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1391651074.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This reverts commit e14ee5deab24200e4b70fe31a8c806f0acd3d37c
("ARM: shmobile: bockw: Do not enable CONFIG_DEVTMPFS defconfig").

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
[horms+renesas@verge.net.au: Added subject of reverted commit to changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/bockw_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index 80cff50..e816140 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -44,6 +44,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_FW_LOADER is not set
-- 
1.8.5.2

