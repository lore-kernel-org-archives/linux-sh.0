From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 09 Aug 2012 06:03:07 +0000
Subject: [PATCH] ARM: shmobile: armadillo800eva: fixup: sound card detection order
Message-Id: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Since armadillo800eva has 2 sound cards,
and had reversed deferred probe order issue,
it was purposely registered in reverse order.

But it was solved by
1d29cfa57471a5e4b8a7c2a7433eeba170d3ad92
(driver core: fixup reversed deferred probe order)

armadillo800eva board is expecting that
FSI-WM8978 is the 1st, and FSI-HDMI is the 2nd sound card.
This patch fixes it up

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index cf10f92..ecd8136 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -901,8 +901,8 @@ static struct platform_device *eva_devices[] __initdata = {
 	&camera_device,
 	&ceu0_device,
 	&fsi_device,
-	&fsi_hdmi_device,
 	&fsi_wm8978_device,
+	&fsi_hdmi_device,
 };
 
 static void __init eva_clock_init(void)
-- 
1.7.5.4

