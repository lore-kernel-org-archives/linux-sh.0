From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 11 Nov 2014 04:36:00 +0000
Subject: [PATCH 0/2] ARM: shmobile: lager/koelsh: add Volume Ramp usage on comment
Message-Id: <87fvdq2w2b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

ALSA SoC maintainer accepted "Volume Ramp" support for R-Car sound driver.
3539cacff2031f6d47881c5f3a4932b0ad5ec224
(ASoC: rsnd: Add Volume Ramp support)
These patches add usage for it on DTS comment area.
# above patches are not merged to Simon's branch
# but, these are just comment, no problem ?

Kuninori Morimoto (2):
      ARM: shmobile: lager: add Volume Ramp usage on comment
      ARM: shmobile: koelsch: add Volume Ramp usage on comment

 arch/arm/boot/dts/r8a7790-lager.dts   |    9 +++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts |    9 +++++++++
 2 files changed, 18 insertions(+)

Best regards
---
Kuninori Morimoto
