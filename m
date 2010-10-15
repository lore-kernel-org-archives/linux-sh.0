From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Oct 2010 06:58:00 +0000
Subject: [PATCH] fbdev: sh_mobile_hdmi: fix compilation without SOUND enabled
Message-Id: <Pine.LNX.4.64.1010150841280.3945@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Paul Mundt <lethal@linux-sh.org>

At least two more Kconfig options have to be selected to be able to compile
sh_mobile_hdmi.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---

Liam, Mark: since this patch only touches drivers/video, although that's a 
central commonly-used file there, the scope of this patch is limited to 
the FB_SH_MOBILE_HDMI block, so, this should safe to go via an SH tree, 
but, if Paul doesn't mind, it should also be ok to go via sound.

 drivers/video/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 43e90b8..935cdc2 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1919,6 +1919,8 @@ config FB_SH_MOBILE_HDMI
 	tristate "SuperH Mobile HDMI controller support"
 	depends on FB_SH_MOBILE_LCDC
 	select FB_MODE_HELPERS
+	select SOUND
+	select SND
 	select SND_SOC
 	---help---
 	  Driver for the on-chip SH-Mobile HDMI controller.
-- 
1.7.1

