From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Mar 2015 01:38:25 +0000
Subject: [PATCH 0/6] ARM: shmobile: r8a779x: sound DMA support
Message-Id: <87y4n5skce.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Arnd

These patches add DMA DT entry for Renesas sound driver.
Renesas sound driver needs 1st/2nd DMA, and now,
1st DMA is implemented by DMAEngine, and 2nd is implemented
in sound driver.
These patches add Renesas sound DMA DT entry for r8a7790/r8a7791.

Simon

New sound driver patches are accepted by Mark's branch,
but, these patches have no dependency with sound driver side.
Current sound driver (= on renesas-devel base) just ignores these DT entry.
New sound driver will use these DT entry if sound and SH-ARM branches
are merged.

Kuninori Morimoto (6):
      ARM: shmobile: r8a7790: add reg-names for sound
      ARM: shmobile: r8a7791: add reg-names for sound
      ARM: shmobile: r8a7790: enable Audio DMAC peri peri via sound driver
      ARM: shmobile: r8a7791: enable Audio DMAC peri peri via sound driver
      ARM: shmobile: r8a7790: sound enables Audio DMAC entry on DTSI
      ARM: shmobile: r8a7791: sound enables Audio DMAC entry on DTSI

 arch/arm/boot/dts/r8a7790.dtsi | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
 arch/arm/boot/dts/r8a7791.dtsi | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
 2 files changed, 224 insertions(+), 60 deletions(-)


Best regards
---
Kuninori Morimoto
