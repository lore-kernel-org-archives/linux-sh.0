From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Jun 2010 00:27:26 +0000
Subject: [PATCH 1/4] sh: make sure static declaration on mach-ap325rxa
Message-Id: <w3p8w6yb7o1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/boards/mach-ap325rxa/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 57e37e2..3a170bd 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -328,7 +328,7 @@ static struct soc_camera_platform_info camera_info = {
 	.set_capture = camera_set_capture,
 };
 
-struct soc_camera_link camera_link = {
+static struct soc_camera_link camera_link = {
 	.bus_id		= 0,
 	.add_device	= ap325rxa_camera_add,
 	.del_device	= ap325rxa_camera_del,
-- 
1.7.0.4

