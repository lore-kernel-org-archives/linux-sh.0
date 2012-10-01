From: "Do Q.Thang" <dq-thang@jinso.co.jp>
Date: Mon, 01 Oct 2012 00:44:37 +0000
Subject: [PATCH] ASoC: fixup simple-card probe order
Message-Id: <5068E775.7040601@jinso.co.jp>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030407080307060108050702"
List-Id: <linux-sh.vger.kernel.org>
To: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Simon Horman <horms@verge.net.au>

This is a multi-part message in MIME format.
--------------030407080307060108050702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

KZM-A9-GT board and Armadillo-800eva board use the asoc-simple-card.
but probe of this sound card needs the fsi-dai's registered before.
So this message appear in the bootlog.

" asoc-simple-card asoc-simple-card.0: CPU DAI fsia-dai not registered
platform asoc-simple-card.0: Driver asoc-simple-card requests probe 
deferral "

The asoc-simple-card was probed while fsi-dai probe hasn't run yet.
So asoc-simple-card probe deferral is requested.
I think the simple-card should be probed after the fsi-dai probe.
I think this patch can fix this issue.

What do you think about this?

Thanks in advance.

---
Thang

--------------030407080307060108050702
Content-Type: text/x-patch;
 name="ASoC-fixup-simple-card-probe-order.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ASoC-fixup-simple-card-probe-order.patch"

From cfea76c9580a952fc299ade2c3b63c567b9b0cbe Mon Sep 17 00:00:00 2001
From: "Do Q.Thang" <dq-thang@jinso.co.jp>
Date: Mon, 24 Sep 2012 18:00:48 +0900
Subject: [PATCH] ASoC: fixup simple-card probe order

simple-card should be probed after fsi-dai probe. This patch fix it.

Signed-off-by: Do Q.Thang <dq-thang@jinso.co.jp>
---
 sound/soc/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 00a555a..2fe1313 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -6,7 +6,6 @@ obj-$(CONFIG_SND_SOC_DMAENGINE_PCM) += snd-soc-dmaengine-pcm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
 obj-$(CONFIG_SND_SOC)	+= codecs/
-obj-$(CONFIG_SND_SOC)	+= generic/
 obj-$(CONFIG_SND_SOC)	+= atmel/
 obj-$(CONFIG_SND_SOC)	+= au1x/
 obj-$(CONFIG_SND_SOC)	+= blackfin/
@@ -24,6 +23,7 @@ obj-$(CONFIG_SND_SOC)	+= pxa/
 obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
+obj-$(CONFIG_SND_SOC)	+= generic/
 obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
 obj-$(CONFIG_SND_SOC)	+= ux500/
-- 
1.7.9.5


--------------030407080307060108050702--
