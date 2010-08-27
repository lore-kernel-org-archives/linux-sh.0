From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 27 Aug 2010 10:15:44 +0000
Subject: [PATCH] fbdev: sh-mobile_hdmi: remove un-necessity settings
Message-Id: <w3pfwy0icog.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current gamut, acp, isrc1, isrc2 settings are wrong,
and not necessary for now.

Tested-by: Takanari Hayama <taki@igel.co.jp>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mobile_hdmi.c |  106 ----------------------------------------
 1 files changed, 0 insertions(+), 106 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 2fde08c..afebe80 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -519,100 +519,6 @@ static void sh_hdmi_audio_infoframe_setup(struct sh_hdmi *hdmi)
 }
 
 /**
- * sh_hdmi_gamut_metadata_setup() - Gamut Metadata Packet of CONTROL PACKET
- */
-static void sh_hdmi_gamut_metadata_setup(struct sh_hdmi *hdmi)
-{
-	int i;
-
-	/* Gamut Metadata Packet */
-	hdmi_write(hdmi, 0x04, HDMI_CTRL_PKT_BUF_INDEX);
-
-	/* Packet Type = 0x0A */
-	hdmi_write(hdmi, 0x0A, HDMI_CTRL_PKT_BUF_ACCESS_HB0);
-	/* Gamut Packet is not used, so default value */
-	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_HB1);
-	/* Gamut Packet is not used, so default value */
-	hdmi_write(hdmi, 0x10, HDMI_CTRL_PKT_BUF_ACCESS_HB2);
-
-	/* GBD bytes 0 through 27 */
-	for (i = 0; i <= 27; i++)
-		/* HDMI_CTRL_PKT_BUF_ACCESS_PB0_63H - PB27_7EH */
-		hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB0 + i);
-}
-
-/**
- * sh_hdmi_acp_setup() - Audio Content Protection Packet (ACP)
- */
-static void sh_hdmi_acp_setup(struct sh_hdmi *hdmi)
-{
-	int i;
-
-	/* Audio Content Protection Packet (ACP) */
-	hdmi_write(hdmi, 0x01, HDMI_CTRL_PKT_BUF_INDEX);
-
-	/* Packet Type = 0x04 */
-	hdmi_write(hdmi, 0x04, HDMI_CTRL_PKT_BUF_ACCESS_HB0);
-	/* ACP_Type */
-	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_HB1);
-	/* Reserved (0) */
-	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_HB2);
-
-	/* GBD bytes 0 through 27 */
-	for (i = 0; i <= 27; i++)
-		/* HDMI_CTRL_PKT_BUF_ACCESS_PB0 - PB27 */
-		hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB0 + i);
-}
-
-/**
- * sh_hdmi_isrc1_setup() - ISRC1 Packet
- */
-static void sh_hdmi_isrc1_setup(struct sh_hdmi *hdmi)
-{
-	int i;
-
-	/* ISRC1 Packet */
-	hdmi_write(hdmi, 0x02, HDMI_CTRL_PKT_BUF_INDEX);
-
-	/* Packet Type = 0x05 */
-	hdmi_write(hdmi, 0x05, HDMI_CTRL_PKT_BUF_ACCESS_HB0);
-	/* ISRC_Cont, ISRC_Valid, Reserved (0), ISRC_Status */
-	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_HB1);
-	/* Reserved (0) */
-	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_HB2);
-
-	/* PB0 UPC_EAN_ISRC_0-15 */
-	/* Bytes PB16-PB27 shall be set to a value of 0. */
-	for (i = 0; i <= 27; i++)
-		/* HDMI_CTRL_PKT_BUF_ACCESS_PB0 - PB27 */
-		hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB0 + i);
-}
-
-/**
- * sh_hdmi_isrc2_setup() - ISRC2 Packet
- */
-static void sh_hdmi_isrc2_setup(struct sh_hdmi *hdmi)
-{
-	int i;
-
-	/* ISRC2 Packet */
-	hdmi_write(hdmi, 0x03, HDMI_CTRL_PKT_BUF_INDEX);
-
-	/* HB0 Packet Type = 0x06 */
-	hdmi_write(hdmi, 0x06, HDMI_CTRL_PKT_BUF_ACCESS_HB0);
-	/* Reserved (0) */
-	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_HB1);
-	/* Reserved (0) */
-	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_HB2);
-
-	/* PB0 UPC_EAN_ISRC_16-31 */
-	/* Bytes PB16-PB27 shall be set to a value of 0. */
-	for (i = 0; i <= 27; i++)
-		/* HDMI_CTRL_PKT_BUF_ACCESS_PB0 - PB27 */
-		hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB0 + i);
-}
-
-/**
  * sh_hdmi_configure() - Initialise HDMI for output
  */
 static void sh_hdmi_configure(struct sh_hdmi *hdmi)
@@ -632,18 +538,6 @@ static void sh_hdmi_configure(struct sh_hdmi *hdmi)
 	/* Audio InfoFrame */
 	sh_hdmi_audio_infoframe_setup(hdmi);
 
-	/* Gamut Metadata packet */
-	sh_hdmi_gamut_metadata_setup(hdmi);
-
-	/* Audio Content Protection (ACP) Packet */
-	sh_hdmi_acp_setup(hdmi);
-
-	/* ISRC1 Packet */
-	sh_hdmi_isrc1_setup(hdmi);
-
-	/* ISRC2 Packet */
-	sh_hdmi_isrc2_setup(hdmi);
-
 	/*
 	 * Control packet auto send with VSYNC control: auto send
 	 * General control, Gamut metadata, ISRC, and ACP packets
-- 
1.7.0.4

