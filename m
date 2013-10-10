From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 10 Oct 2013 07:16:35 +0000
Subject: [PATCH 10/11] ARM: shmobile: marzen: Enable CONFIG_PACKET in defconfig
Message-Id: <1381389396-22000-11-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1381389396-22000-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1381389396-22000-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

CONFIG_PACKET is required for the ISC dhcpd daemon function.
This change brings the marzen defconfig into line with
other shmobile defconfigs.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/marzen_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 292728d..7f3aa36 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -35,6 +35,7 @@ CONFIG_KEXEC=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
+CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
-- 
1.8.4

