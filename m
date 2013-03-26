From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Mar 2013 13:49:39 +0000
Subject: [PATCH 00/13 v2] sh-pfc: Initial r8a73a4 PFC support
Message-Id: <20130326134939.31366.42030.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh-pfc: Initial r8a73a4 PFC support (V2)

[PATCH 01/13] sh-pfc: Add r8a73a4 pinmux support
[PATCH 02/13] sh-pfc: r8a73a4: Support sparse GPIO numbers
[PATCH 03/13 v2] sh-pfc: r8a73a4: GPIO IRQ support
[PATCH 04/13] sh-pfc: r8a73a4: Add bias (pull-up/down) pinconf support
[PATCH 05/13] sh-pfc: r8a73a4: Add SCIF pin groups and functions
[PATCH 06/13] sh-pfc: r8a73a4: Add IRQC pin groups and functions
[PATCH 07/13] sh-pfc: r8a73a4: Remove SCIF function GPIOS
[PATCH 08/13] sh-pfc: r8a73a4: Remove IRQC function GPIOS
[PATCH 09/13] ARM: shmobile: r8a73a4: Remove SCIF function GPIOs
[PATCH 10/13] ARM: shmobile: r8a73a4: Remove IRQC function GPIOs
[PATCH 11/13] sh-pfc: r8a73a4: Remove function GPIOs
[PATCH 12/13] ARM: shmobile: r8a73a4: Remove all GPIO enums
[PATCH 13/13] sh-pfc: r8a73a4: Remove unused GPIO bias data

This series is V2 of initial PFC support for the r8a73a4 SoC.
The patches add a regular old-style GPIO function controller
and makes it partially converted over to PINCTRL for SCIF
and IRQC that are tied up on the APE6EVM board. The final
patches remove the GPIO function support, so when new drivers
for r8a73a4 are added then PINCTRL support has to be included.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-next-20130321 in renesas.git
 Requires "r8a73a4.h" provided by
  [PATCH 00/04] ARM: shmobile: r8a73a4 SoC support V3

 arch/arm/mach-shmobile/include/mach/r8a73a4.h | 1838 +++++-----
 drivers/pinctrl/sh-pfc/Kconfig                |    5 
 drivers/pinctrl/sh-pfc/Makefile               |    1 
 drivers/pinctrl/sh-pfc/core.c                 |    3 
 drivers/pinctrl/sh-pfc/core.h                 |    1 
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c          | 4592 +++++++++++++++++++------
 6 files changed, 4519 insertions(+), 1921 deletions(-)
