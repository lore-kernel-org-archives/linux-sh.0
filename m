From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Fri, 30 Aug 2013 12:37:37 +0000
Subject: [RFC 03/10] ASoC: Add SPDIF DAI format
Message-Id: <1377866264-21110-4-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dai.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index ae9a227..eea0501 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -33,6 +33,7 @@ struct snd_compr_stream;
 #define SND_SOC_DAIFMT_DSP_B		5 /* L data MSB during FRM LRC */
 #define SND_SOC_DAIFMT_AC97		6 /* AC97 */
 #define SND_SOC_DAIFMT_PDM		7 /* Pulse density modulation */
+#define SND_SOC_DAIFMT_SPDIF		8 /* SPDIF */
 
 /* left and right justified also known as MSB and LSB respectively */
 #define SND_SOC_DAIFMT_MSB		SND_SOC_DAIFMT_LEFT_J
-- 
1.8.1.4

