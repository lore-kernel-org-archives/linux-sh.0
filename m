From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 Apr 2014 14:10:25 +0000
Subject: [PATCH v2 00/05] ARM: shmobile: Lager and Koelsch USB prototype patches
Message-Id: <20140408141025.10063.85072.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Lager and Koelsch USB prototype patches

[PATCH v2 01/05] gpio: rcar: Per-controller gpios property prototype
[PATCH v2 02/05] ARM: shmobile: lager: DT reference USB platform devices
[PATCH v2 03/05] ARM: shmobile: lager: DT reference USB pinmux setup 
[PATCH v2 04/05] ARM: shmobile: koelsch: DT reference USB platform devices
[PATCH v2 05/05] ARM: shmobile: koelsch: DT reference USB pinmux setup

These patches enable USB functionality for the DT reference
board support for Lager and Koelsch. With these in place it is
possible to use a single kernel binary with CCF and MULTIPLATFORM
on Lager or Koelsch and use USB Host or USB Function even though
DT bindings are not yet developed for such device drivers.

This is intended as a short term prototype to show that USB
can be used on R-Car Gen2 hardware such as Lager and Koelsch
even though DT bindings are not yet in place.

With these patches device drivers for USBHS, USB PCI (Host 2.0)
and USB PHY are supported. USB Host 3.0 support is still missing.

USB0 is routed to USBHS via the PHY and USB1 is fixed USB Host 2.0,
while USB2 is current assigned to USB Host 2.0 but may be changed
to USB Host 3.0 when that driver is available upstream.

Based on the legacy Lager and Koelsch board code written by Valentine
and Vladimir, but slightly reworked to include clock workarounds and
DT-style GPIO handling. The first patch in this series is a prototype
to allow board code written in C to access GPIOs on controllers
described via DT.

Not for upstream merge.

Changes since V1:
 - Use Signed-off-by instead of Not-Yet-Signed-off-by
 - Adjust board name in patch titles
 - Updated text to include comment about USB PCI, USB PHY, USBHS and USB 3.0.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-v3.14-20140403

 The Koelsch code has a run time dependency on:
 [PATCH] ARM: shmobile: r8a7791: Add EHCI MSTP clock

 arch/arm/boot/dts/r8a7790-lager.dts              |   18 +
 arch/arm/boot/dts/r8a7791-koelsch.dts            |   12 +
 arch/arm/mach-shmobile/board-koelsch-reference.c |  184 +++++++++++++++++++
 arch/arm/mach-shmobile/board-lager-reference.c   |  211 ++++++++++++++++++++++
 drivers/gpio/gpio-rcar.c                         |   23 ++
 5 files changed, 446 insertions(+), 2 deletions(-)
