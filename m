From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 08 Apr 2013 02:08:34 +0000
Subject: [PATCH 00/02] sh-pfc: Initial r8a7790 PFC support
Message-Id: <20130408020834.29957.24249.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh-pfc: Initial r8a7790 PFC support

[PATCH 01/02] ARM: shmobile: Add second I/O range for r8a7790 PFC
[PATCH 02/02] sh-pfc: Initial r8a7790 PFC support

This mini-series contains initial support for the r8a7790 PFC.
Incremental future changes will move over to PINCTRL.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-next-20130405v2 in renesas.git

 arch/arm/mach-shmobile/include/mach/r8a7790.h |  383 ++
 arch/arm/mach-shmobile/setup-r8a7790.c        |    1 
 drivers/pinctrl/sh-pfc/Kconfig                |    5 
 drivers/pinctrl/sh-pfc/Makefile               |    1 
 drivers/pinctrl/sh-pfc/core.c                 |    3 
 drivers/pinctrl/sh-pfc/core.h                 |    1 
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c          | 3238 +++++++++++++++++++++++++
 7 files changed, 3632 insertions(+)
