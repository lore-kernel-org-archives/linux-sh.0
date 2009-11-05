From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Nov 2009 14:34:47 +0000
Subject: [PATCH 00/05][RFC] sh: Early serial console rework V2
Message-Id: <20091105143447.9902.4608.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: Early serial console rework V2

[PATCH 01/05] sh-sci: disable callback typo fix
[PATCH 02/05] Driver Core: Early platform driver buffer
[PATCH 03/05] sh-sci: Extend sh-sci driver with early console
[PATCH 04/05] sh: Break out SH7724 serial ports
[PATCH 05/05] sh: Remove old early serial console code

These patches move the early serial console code into the sh-sci
driver. Apart from removing duplicated code, this also allows for
a wider range of supported ports - SCI, SCIF and SCIFA should now
be supported. The rework allows us to select the early serial console
port with the kernel command line. As an example, to enable early
serial console on KFR2R09, simply add the following to the kernel
command line: "earlyprintk=sh-sci.1,115200".

If the SuperH specific bits look OK then I'll break out serial port
data for other processors as well and submit the driver core bits to
LKML.

Tested on sh7724 / KFR2R09.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/Kconfig.debug                  |   21 ----
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  145 +++++++++++++++++++++---------
 arch/sh/kernel/early_printk.c          |  153 --------------------------------
 arch/sh/kernel/setup.c                 |    5 +
 drivers/base/platform.c                |   29 ++++--
 drivers/serial/sh-sci.c                |   58 ++++++++++--
 include/linux/platform_device.h        |   20 +++-
 7 files changed, 193 insertions(+), 238 deletions(-)
