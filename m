Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4589CCE7A81
	for <linux-sh@archiver.kernel.org>; Mon, 25 Sep 2023 12:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjIYM46 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 25 Sep 2023 08:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYM45 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 25 Sep 2023 08:56:57 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D999FC
        for <linux-sh@vger.kernel.org>; Mon, 25 Sep 2023 05:56:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ee18:727e:6235:2ac2])
        by albert.telenet-ops.be with bizsmtp
        id qCwn2A00B4XpEKH06CwnFJ; Mon, 25 Sep 2023 14:56:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qkl8R-004XvW-64;
        Mon, 25 Sep 2023 14:56:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qkl8p-00FRoC-3P;
        Mon, 25 Sep 2023 14:56:47 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Manuel Lauss <manuel.lauss@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: sh: dma-sh7760: Use %pad and %zu to format dma_addr_t and size_t
Date:   Mon, 25 Sep 2023 14:56:46 +0200
Message-Id: <20230925125646.3681807-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

sound/soc/sh/dma-sh7760.c: In function ‘camelot_prepare’:
./include/linux/kern_levels.h:5:25: warning: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘unsigned int’ [-Wformat=]
    5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
sound/soc/sh/dma-sh7760.c:198:9: note: in expansion of macro ‘pr_debug’
  198 |         pr_debug("PCM data: addr 0x%08lx len %d\n",
      |         ^~~~~~~~

Fix this by using "%pad" and taking the address to format the DMA
address.  While at it, use "%zu" to format size_t.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309250903.XNAjFuxy-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/sh/dma-sh7760.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 121e48f984c50cab..85fe126233528252 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -195,9 +195,9 @@ static int camelot_prepare(struct snd_soc_component *component,
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct camelot_pcm *cam = &cam_pcm_data[asoc_rtd_to_cpu(rtd, 0)->id];
 
-	pr_debug("PCM data: addr 0x%08lx len %d\n",
-		 (u32)runtime->dma_addr, runtime->dma_bytes);
- 
+	pr_debug("PCM data: addr %pad len %zu\n", &runtime->dma_addr,
+		 runtime->dma_bytes);
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		BRGREG(BRGATXSAR) = (unsigned long)runtime->dma_area;
 		BRGREG(BRGATXTCR) = runtime->dma_bytes;
-- 
2.34.1

