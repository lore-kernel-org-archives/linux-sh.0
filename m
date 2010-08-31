From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 31 Aug 2010 05:45:51 +0000
Subject: [PATCH 0/4 v2] Add FSI - HDMI support V2
Message-Id: <w3p39tv72sx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Linux-SH <linux-sh@vger.kernel.org>


Dear Mark, Paul

These are FSI - HDMI prototype sound support V2

Kuninori Morimoto (4):
      fbdev: sh-mobile: Add HDMI sound type selection
      ASoC: Add sh_mobile_hdmi sound support
      ASoC: fsi-codec: Add FSI - HDMI support
      ARM: mach-shmobile: ap4evb: Add HDMI sound support

>> Paul
1st patch is depend on 
[PATCH] fbdev: sh-mobile_hdmi: remove un-necessity settings
which I sent to LinuxSH ML in 2010/08/27

>> Mark
2nd, 3rd ASoC patches are based on Mark's "for-2.6.37"
