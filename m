From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 28 May 2014 07:23:55 +0000
Subject: [PATCH 0/8] ARM: shmobile: R-Car: Add PCIe clocks and DT nodes
Message-Id: <1401261843-6964-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These patches add PCIe support to the R-Car H2/M2 devices and enable it on the
Koelsch board. They depend on the following commits in Bjorn's PCI tree:
	c25da4778803b41e11fd82dd5576c35c09b5f0e0
	290c1fb35860540223bef1be021944d02232889d
	7869fc6e295cbb1f80e30555bebbc795abb5b9a7

They have been tested on an off-the-shelf Koelsch board, and also a Lager board
with some hardware mods.

They are based on Simon's renesas-devel-v3.15-rc7-20140528 tag.

Phil Edworthy (8):
  ARM: shmobile: r8a7790: Add PCIe clock device tree nodes
  ARM: shmobile: r8a7791: Add PCIe clock device tree nodes
  ARM: shmobile: r8a7790: Add PCIe device nodes
  ARM: shmobile: lager: Add dummy PCIe bus clock
  ARM: shmobile: r8a7791: Add PCIe device nodes
  ARM: shmobile: koelsch: Add PCIe bus clock and enable PCIe device
  ARM: shmobile: koelsch: Add PCIe to defconfig
  ARM: shmobile: henninger: Add dummy PCIe bus clock

 arch/arm/boot/dts/r8a7790-lager.dts       | 10 ++++++++++
 arch/arm/boot/dts/r8a7790.dtsi            | 31 ++++++++++++++++++++++++++++---
 arch/arm/boot/dts/r8a7791-henninger.dts   | 10 ++++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts     | 14 ++++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi            | 31 +++++++++++++++++++++++++++++--
 arch/arm/configs/koelsch_defconfig        |  3 +++
 include/dt-bindings/clock/r8a7790-clock.h |  1 +
 include/dt-bindings/clock/r8a7791-clock.h |  1 +
 8 files changed, 96 insertions(+), 5 deletions(-)

-- 
1.9.3

