From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Jan 2009 15:13:34 +0000
Subject: [PATCH 000/013] sh-sci: platform device, clock and console changes
Message-Id: <20090121151334.29269.55519.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh-sci: platform device, clock and console changes

[PATCH 001/013] sh-sci: add platform device private data
[PATCH 002/013] sh-sci: allow single port platform devices
[PATCH 003/013] sh-sci: remove early_sci_setup()
[PATCH 004/013] sh-sci: rework serial console support
[PATCH 005/013] sh-sci: replace sci_init_ports()
[PATCH 006/013] sh-sci: ioremap() in a single place 
[PATCH 007/013] sh-sci: improve clock framework support
[PATCH 008/013] sh-sci: use to_sci_port() if possible
[PATCH 009/013] sh-sci: convert sh2 cpu to single port devices
[PATCH 010/013] sh-sci: convert sh2a cpus to single port devices
[PATCH 011/013] sh-sci: convert sh3 cpus to single port devices
[PATCH 012/013] sh-sci: convert sh4 cpus to single port devices
[PATCH 013/013] sh-sci: sh4a single port devices and clock support

These patches modify the sh-sci driver / SuperH arch as follows:
- make one platform device per port
- rework console code
- improve clock framework support for SuperH Mobile processors
- various cleanups

I have a few more patches on top of this that implements early
printk support using early platform devices.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Compile tested on all processors below.
 Run-time tested on Migo-R and ap325.

 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |   64 ++-
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |   22 -
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |  168 ++++++---
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |   85 +++-
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |   85 +++-
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  |   43 +-
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  |   72 ++--
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  |   42 +-
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  |   42 +-
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |   22 -
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  |   51 +-
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  |   84 +++-
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   89 +++-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   23 -
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   66 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |  133 +++++--
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |   64 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |   43 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |  128 ++++---
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |   85 +++-
 drivers/serial/sh-sci.c                |  571 +++++++++++++++++---------------
 include/linux/serial_sci.h             |    3 
 22 files changed, 1225 insertions(+), 760 deletions(-)
