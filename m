From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 08 Dec 2009 00:18:20 +0000
Subject: [PATCH] sh: mach-ap325rxa: Add SOCAM_DATA_ACTIVE_HIGH flags for
Message-Id: <uocmagvxv.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current soc-camera needs SOCAM_DATA_ACTIVE_xxx flags for use.
We can not open old ncm03j camera device without this patch.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ap325rxa/setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index cf9dc12..4b4320b 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -322,7 +322,8 @@ static struct soc_camera_platform_info camera_info = {
 		.height = 480,
 	},
 	.bus_param = SOCAM_PCLK_SAMPLE_RISING | SOCAM_HSYNC_ACTIVE_HIGH |
-	SOCAM_VSYNC_ACTIVE_HIGH | SOCAM_MASTER | SOCAM_DATAWIDTH_8,
+	SOCAM_VSYNC_ACTIVE_HIGH | SOCAM_MASTER | SOCAM_DATAWIDTH_8 |
+	SOCAM_DATA_ACTIVE_HIGH,
 	.set_capture = camera_set_capture,
 	.link = {
 		.bus_id		= 0,
-- 
1.6.3.3

