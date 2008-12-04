From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Dec 2008 08:59:46 +0000
Subject: [PATCH 00/06] sh: sh7343 and se7343 patches
Message-Id: <20081204085946.25773.64257.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh7343 and se7343 patches:

[PATCH 01/06] sh: sh7343 scif configuration update
[PATCH 02/06] sh: fix number of interrupts on se7343
[PATCH 03/06] sh: add st16c2550 devices to se7343
[PATCH 04/06] sh: add isp1161 usb host device to se7343
[PATCH 05/06] sh: remove ioport cruft and smc91x from se7343
[PATCH 06/06] sh: update se7343 defconfig

This patchset simply updates the sh7343 processor code a bit and
modifies the se7343 board support code to include the external usb
host controller chip and on-board uarts. The out-of-date ioport
code gets removed while at it - including some old support for
unknown-ne2000-pcmcia-card, cf-over-pcmcia and a mysterical smc91x
that once must have been on a special daughterboard.

Now with the USB host controller in place we get network connection
using an ethernet-over-usb adapter (yay) but we're still unfortunately
stuck loading the kernel over the serial gdbstub which makes kernel
development too slow to be practical.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-se/7343/Makefile   |    2 
 arch/sh/boards/mach-se/7343/io.c       |  273 ----------------------------
 arch/sh/boards/mach-se/7343/setup.c    |  126 ++++++++-----
 arch/sh/configs/se7343_defconfig       |  303 ++++++++++++++++++++++++++++----
 arch/sh/include/mach-se/mach/se7343.h  |    9 
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   19 +-
 6 files changed, 376 insertions(+), 356 deletions(-)
