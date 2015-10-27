From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 27 Oct 2015 23:05:26 +0000
Subject: [PATCH v4 0/3] arm64: renesas: r8a7795: add I2C support
Message-Id: <1445987129-13496-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

these patches add i2c support to the r8a7795/Salvator-X.

These patches are an update of work by Kuninori Morimoto,
broken out of a larger patchset posted by him.

The main change to the patches themselves since Morimoto-san's v3
posting is to update to new CPG/MSSR bindings via Geert Uytterhoeven.

Morimoto-san, I would be most grateful if you could look over this and repost
if there are problems.

Base:

* "[PATCH v12 0/7] arm64: renesas: Add Renesas R8A7795 SoC support".
  This can be found in the topic/arm64-rcar-gen3-v12 branch of
  my renesas tree on kernel.org.

Availability:
* This patchset is available in the  topic/r8a7795-i2c-v4 branch of my
  renesas tree on kernel.org


Kuninori Morimoto (3):
  arm64: renesas: r8a7795: add I2C support
  arm64: renesas: salvator-x: enable I2C
  arm64: defconfig: Enable Renesas R-Car I2C Controller

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 +++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 87 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  2 +
 3 files changed, 101 insertions(+)

-- 
2.1.4

