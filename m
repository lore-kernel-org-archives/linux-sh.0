From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 28 May 2013 12:22:03 +0000
Subject: [PATCH 0/5] HSCIF support
Message-Id: <1369743728-26084-1-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This set implements HSCIF support for the r8a7790. Since the Lager board
doesn't actually have these wired up -- except HSCIF1, but those pins are
needed for the serial console -- it has not received real-world testing. 
The timing seems to work out, however, and the HSCIF is virtually identical
to the SCIF anyway as far as the features actually used by the driver are
concerned, so not all that much can go wrong.

The set also contains a patch that switches the SCIFs to the internal clock. 
While the Lager board does have an external clock and it seems to work with
SCIF0, it does not seem to do anything for SCIF1 or the HSCIFs, and the
internal clock works just fine for all interfaces.

Comments are welcome.

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
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c   |  181 ++++++++++++++++++++++++++++++++
 drivers/tty/serial/sh-sci.c            |  102 ++++++++++++++++--
 include/linux/serial_sci.h             |   12 ++-
 include/uapi/linux/serial_core.h       |    3 +
 7 files changed, 310 insertions(+), 14 deletions(-)

-- 
1.7.10.4

