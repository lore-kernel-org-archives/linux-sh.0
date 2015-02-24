From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Feb 2015 02:17:58 +0000
Subject: [PATCH 0/4][resend] ARM: shmobile: r8a779x: add SDHI DMA support
Message-Id: <874mqc126w.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

As I mentioned in
http://news.gmane.org/gmane.linux.ports.sh.devel
these are resend of SDHI DMA support

These are based on v4.0-rc1

Kuninori Morimoto (2):
      ARM: shmobile: r8a7790: tidyup SDHI register size on DTSI
      ARM: shmobile: r8a7791: tidyup SDHI register size on DTSI

Laurent Pinchart (2):
      ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
      ARM: shmobile: r8a7791: Reference DMA channels in SDHI DT nodes

 arch/arm/boot/dts/r8a7790.dtsi |   12 ++++++++++--
 arch/arm/boot/dts/r8a7791.dtsi |    8 +++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)


Best regards
---
Kuninori Morimoto
