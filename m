From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 13 Nov 2015 16:22:21 +0000
Subject: [PATCH 0/2] fix Lager earlycon
Message-Id: <1447431743-16376-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This makes earlycon work on the Lager board:

1. It amends the SCI earlycon patch by Sato-san slightly to preserve the
other bits in SCSCR when asserting RE and TE.

2. It switches the serial console back to SCIF0, because that's what the
boot loader uses, and we rely on it to set up the port for us...

I have yet to check to what extent other boards/SoCs are affected by this.

CU
Uli


Ulrich Hecht (2):
  sh-sci: Add CONFIG_SERIAL_EARLYCON support
  ARM: shmobile: r8a7790: switch console back to scif0

 arch/arm/boot/dts/r8a7790-lager.dts | 14 ++++----
 drivers/tty/serial/Kconfig          |  6 ++++
 drivers/tty/serial/sh-sci.c         | 71 +++++++++++++++++++++++++++++++++++--
 3 files changed, 81 insertions(+), 10 deletions(-)

-- 
2.6.1

