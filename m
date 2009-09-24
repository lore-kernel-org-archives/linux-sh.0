From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 24 Sep 2009 06:28:27 +0000
Subject: [PATCH] sh: mach-ecovec24: Add active low setting for sh_eth
Message-Id: <uhbusrh4k.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 96bc169..5f9881e 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -121,6 +121,7 @@ static struct resource sh_eth_resources[] = {
 struct sh_eth_plat_data sh_eth_plat = {
 	.phy = 0x1f, /* SMSC LAN8700 */
 	.edmac_endian = EDMAC_LITTLE_ENDIAN,
+	.ether_link_active_low = 1
 };
 
 static struct platform_device sh_eth_device = {
-- 
1.6.0.4

