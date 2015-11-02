From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 02 Nov 2015 17:08:38 +0000
Subject: [RFC PATCH 0/3] Add PCIe to r8a7795 & Salvator-X
Message-Id: <1446484121-26682-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These patches are needed to get PCIe working on the Salvator-X board, see
https://lkml.org/lkml/2015/11/2/445.

They depend on the cpg-mssr driver and other patches so are on top of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
renesas-drivers-2015-10-27-v4.3-rc7

Phil Edworthy (3):
  clk: shmobile: r8a7795: Add PCIe clocks
  arm64: renesas: r8a7795: Add PCIe nodes
  arm64: dts: r8a7795: enable PCIe on Salvator-X

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 +++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 60 +++++++++++++++++++++-
 drivers/clk/shmobile/clk-r8a7795-cpg-mssr.c        |  2 +
 3 files changed, 73 insertions(+), 1 deletion(-)

-- 
1.9.1

