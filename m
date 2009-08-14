From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 14 Aug 2009 10:48:08 +0000
Subject: [PATCH 00/05] PM: Runtime PM v16 for SuperH Mobile V3
Message-Id: <20090814104808.32396.50021.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

PM: Runtime PM v16 for SuperH Mobile V3

[PATCH 01/05] sh: Runtime PM for SuperH Mobile platform bus devices
[PATCH 02/05] i2c: Runtime PM for SuperH Mobile I2C
[PATCH 03/05] video: Runtime PM for SuperH Mobile LCDC
[PATCH 04/05] v4l2: Runtime PM for SuperH Mobile CEU
[PATCH 05/05] uio: Runtime PM for UIO devices

This is the SuperH Mobile platform bus Runtime PM implementation V3.
Included is a SuperH Mobile specific Runtime PM implementation and
some driver changes. The code has been tested with "Software Standby"
mode on sh7722 and a multimedia playback workload exercising drivers
for fbdev, uio, v4l2 and i2c.

Apply on top of Rafael's linux-next patches and
"PM: Introduce core framework for run-time PM of I/O devices (rev. 16)"
"PM: Runtime PM v15 - Platform Device Bus Support"

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/device.h               |    9 
 arch/sh/include/asm/hwblk.h                |    4 
 arch/sh/kernel/cpu/shmobile/Makefile       |    1 
 arch/sh/kernel/cpu/shmobile/pm_runtime.c   |  304 ++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-sh_mobile.c         |   39 +++
 drivers/media/video/sh_mobile_ceu_camera.c |   41 ++-
 drivers/uio/uio_pdrv_genirq.c              |   54 ++++
 drivers/video/sh_mobile_lcdcfb.c           |  154 ++++++++++----
 8 files changed, 542 insertions(+), 64 deletions(-)
