From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 12 Jun 2014 04:42:51 +0000
Subject: [PATCH 0/3] ARM: shmobile: r8a7791: MSTP/sound support on DTSI
Message-Id: <87oaxyeo1h.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are MSTP/sound support for r8a7791.
This patch set doesn't include koelsch sound.
The reason is same as lager.

Kuninori Morimoto (3):
      ARM: shmobile: r8a7791: add audio clock on DTSI
      ARM: shmobile: r8a7791: add MSTP10 support on DTSI
      ARM: shmobile: r8a7791: add R-Car sound support on DTSI

 arch/arm/boot/dts/r8a7791.dtsi            |  112 +++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7791-clock.h |   26 +++++++
 2 files changed, 138 insertions(+)
