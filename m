From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Nov 2013 08:27:36 +0000
Subject: [PATCH 00/04] ARM: shmobile: r7s72100 and Genmai GPIO / PINCTRL support
Message-Id: <20131127082736.20015.21303.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

ARM: shmobile: r7s72100 and Genmai GPIO / PINCTRL support

[PATCH 01/04] ARM: shmobile: r7s72100 GPIO and PINCTRL device nodes
[PATCH 02/04] ARM: shmobile: Genmai LED1 and LED2 support
[PATCH 03/04] ARM: shmobile: Genmai I2C-over-GPIO support
[PATCH 04/04] ARM: shmobile: Genmai SCIF2 PINCTRL configuration

Add various device nodes to the r7s72100 SoC and the Genmai board,
nothing special just basic support for LEDs and I2C-over-GPIO.

Patch 4/4 depends on the r7s72100 PINCTRL pin grouping, but 1-3
depends on the GPIO driver.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.13-rc1-20131125 and
 [PATCH] pinctrl: sh-pfc: Initial r7s72100 support
 [PATCH v3] gpio: Renesas RZ GPIO driver V3 

 The following patches are needed for 4/4:
 [PATCH 00/03] pinctrl: sh-pfc: r7s72100 SCIF2 support
 [PATCH 01/03] pinctrl: sh-pfc: r7s72100 SCIF2 port3 support
 [PATCH 02/03] pinctrl: sh-pfc: r7s72100 SCIF2 macro conversion
 [PATCH 03/03] pinctrl: sh-pfc: r7s72100 SCIF2 port4, 6 and 8 support

 arch/arm/boot/dts/r7s72100-genmai-reference.dts |   41 +++++-
 arch/arm/boot/dts/r7s72100.dtsi                 |  154 +++++++++++++++++++++++
 2 files changed, 194 insertions(+), 1 deletion(-)
