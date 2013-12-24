From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 24 Dec 2013 06:03:40 +0000
Subject: [PATCH 7/7] ARM: shmobile: koelsch: Do not disable CONFIG_{INOTIFY_USER,UNIX} in defconfig
Message-Id: <559cec66f1a2620bc85bb79191512a569a404cb8.1387854925.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1387854925.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1387854925.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

CONFIG_INOTIFY_USER and CONFIG_UNIX are required for udev to function.
This change brings the koelsch defconfig into line with
other shmobile defconfigs.

Signed-off-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/koelsch_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index ef79cbf..acec6b8 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -31,6 +31,7 @@ CONFIG_NEON=y
 CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
 CONFIG_PACKET=y
+CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
@@ -66,7 +67,6 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 # CONFIG_IOMMU_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
-# CONFIG_INOTIFY_USER is not set
 CONFIG_TMPFS=y
 CONFIG_CONFIGFS_FS=y
 # CONFIG_MISC_FILESYSTEMS is not set
-- 
1.8.4

