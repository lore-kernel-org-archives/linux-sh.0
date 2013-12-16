From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 16 Dec 2013 00:34:08 +0000
Subject: [PATCH 1/2] ARM: shmobile: koelsch: Enable CONFIG_PACKET in defconfig
Message-Id: <1387154049-9105-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387154049-9105-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1387154049-9105-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

CONFIG_PACKET is required for the ISC dhcpd daemon function.
This change brings the koelsch defconfig into line with
other shmobile defconfigs.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/koelsch_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index 284846e..4971acd 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -30,6 +30,7 @@ CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
+CONFIG_PACKET=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-- 
1.8.4

