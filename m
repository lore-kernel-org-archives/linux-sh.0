From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 18 Mar 2013 14:50:29 +0000
Subject: [PATCH 00/02] sh-pfc: Initial r8a73a4 PFC support
Message-Id: <20130318145029.26761.15477.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh-pfc: Initial r8a73a4 PFC support

[PATCH 01/02] sh-pfc: Add r8a73a4 pinmux support
[PATCH 02/02] sh-pfc: Add r8a73a4 GPIO IRQ support

This series is V1 of initial PFC support for the r8a73a4 SoC.
Nothing out of the ordinary, just similar but different tables
to describe the pinmux hardware and GPIOs on r8a73a4.

The header in the mach directory is still used, and in the future
this will be removed when fully using PINCTRL. Until then a common
location is needed so this series simply follows what other SoCs
do. Because of this there is a dependency on the r8a73a4 SoC code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against "next" renesas.git 811689afc214564c4a5f238ecf4d8bdc0e52b615
 Requires "r8a73a4.h" provided by
  [PATCH 00/04] ARM: shmobile: r8a73a4 SoC support V2

 arch/arm/mach-shmobile/include/mach/r8a73a4.h |  918 +++++++
 drivers/pinctrl/sh-pfc/Kconfig                |    5 
 drivers/pinctrl/sh-pfc/Makefile               |    1 
 drivers/pinctrl/sh-pfc/core.c                 |    3 
 drivers/pinctrl/sh-pfc/core.h                 |    1 
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c          | 2889 +++++++++++++++++++++++++
 6 files changed, 3817 insertions(+)
