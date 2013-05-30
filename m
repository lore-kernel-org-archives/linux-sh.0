From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Thu, 30 May 2013 15:08:39 +0000
Subject: [PATCH v2 0/5] HSCIF support
Message-Id: <1369926524-3425-1-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This is the same as v1, except the alphabetical order of the pin
groups/functions has been restored.

CU
Uli

Ulrich Hecht (5):
  serial: sh-sci: HSCIF support
  ARM: shmobile: r8a7790: HSCIF support
  sh-pfc: r8a7790: add HSCIF pin groups
  ARM: shmobile: r8a7790: don't use external clock for SCIFs
  ARM: shmobile: lager: map HSCIF0/1 to unused pins

 arch/arm/mach-shmobile/board-lager.c   |    4 +
 arch/arm/mach-shmobile/clock-r8a7790.c |    6 +-
 arch/arm/mach-shmobile/setup-r8a7790.c |   16 ++-
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c   |  211 +++++++++++++++++++++++++++++---
 drivers/tty/serial/sh-sci.c            |  102 +++++++++++++--
 include/linux/serial_sci.h             |   12 +-
 include/uapi/linux/serial_core.h       |    3 +
 7 files changed, 325 insertions(+), 29 deletions(-)

-- 
1.7.10.4

