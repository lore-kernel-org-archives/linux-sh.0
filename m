From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Jun 2010 00:25:19 +0000
Subject: [PATCH 3/3] ARM: mach-shmobile: make sure static declaration on g3evm
Message-Id: <w3pbpbub7rl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-g3evm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-g3evm.c b/arch/arm/mach-shmobile/board-g3evm.c
index a8f20cb..95ccb94 100644
--- a/arch/arm/mach-shmobile/board-g3evm.c
+++ b/arch/arm/mach-shmobile/board-g3evm.c
@@ -100,7 +100,7 @@ static struct platform_device nor_flash_device = {
 };
 
 /* USBHS */
-void usb_host_port_power(int port, int power)
+static void usb_host_port_power(int port, int power)
 {
 	if (!power) /* only power-on supported for now */
 		return;
-- 
1.7.0.4

