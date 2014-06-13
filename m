From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Fri, 13 Jun 2014 09:37:14 +0000
Subject: [PATCH v3 0/8] ARM: shmobile: R-Car: Add PCIe clocks and DT nodes
Message-Id: <1402652242-16604-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These patches add PCIe support to the R-Car H2/M2 devices and enable it on the
Koelsch board. They depend on the following commits in Linus's master branch:
	c25da4778803b41e11fd82dd5576c35c09b5f0e0
	290c1fb35860540223bef1be021944d02232889d
	7869fc6e295cbb1f80e30555bebbc795abb5b9a7

v3:
 - By default, disable the PCIe bus clock & enable it on the board.
 - Add PCIe to the Henninger board

v2:
 - Changed PCIe controller names,etc from pcie to pciec
 - Corrected MTSP bit ordering
 - Use a default PCIe bus clock in the device's dtsi


Phil Edworthy (8):
  ARM: shmobile: r8a7790: Add PCIEC clock device tree node
  ARM: shmobile: r8a7790: Add default PCIe bus clock
  ARM: shmobile: r8a7790: Add PCIe Controller device node
  ARM: shmobile: r8a7791: Add PCIEC clock device tree node
  ARM: shmobile: r8a7791: Add default PCIe bus clock
  ARM: shmobile: r8a7791: Add PCIe Controller device node
  ARM: shmobile: koelsch: Enable PCIe Controller & PCIe bus clock
  ARM: shmobile: henninger: Enable PCIe Controller & PCIe bus clock

 arch/arm/boot/dts/r8a7790.dtsi            | 40 +++++++++++++++++++++++++++---
 arch/arm/boot/dts/r8a7791-henninger.dts   |  8 ++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts     |  8 ++++++
 arch/arm/boot/dts/r8a7791.dtsi            | 41 ++++++++++++++++++++++++++++---
 include/dt-bindings/clock/r8a7790-clock.h |  1 +
 include/dt-bindings/clock/r8a7791-clock.h |  1 +
 6 files changed, 93 insertions(+), 6 deletions(-)

-- 
2.0.0

