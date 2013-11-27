From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Nov 2013 23:14:50 +0000
Subject: [PATCH 00/04] ARM: shmobile: Use SoC suffix for INTC compat string
Message-Id: <20131127231450.29081.98054.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

ARM: shmobile: Use SoC suffix for INTC compat string

[PATCH 01/04] ARM: shmobile: Use sh73a0 suffix for INTC compat string
[PATCH 02/04] ARM: shmobile: Use r8a7740 suffix for INTC compat string
[PATCH 03/04] ARM: shmobile: Use r8a7778 suffix for INTC compat string
[PATCH 04/04] ARM: shmobile: Use r8a7779 suffix for INTC compat string

Update the DTS for INTC irqpin devices to include the SoC in the compat string.

Both IRQC and INTC irqpin need documentation for the DT bindings, and this
will happen in incremental patches.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.13-rc1-20131125

 arch/arm/boot/dts/r8a7740.dtsi |    8 ++++----
 arch/arm/boot/dts/r8a7778.dtsi |    2 +-
 arch/arm/boot/dts/r8a7779.dtsi |    2 +-
 arch/arm/boot/dts/sh73a0.dtsi  |    8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)
