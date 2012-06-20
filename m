From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 17:10:29 +0000
Subject: [PATCH 0/7 v4] mmc: tmio: clock and PM updates
Message-Id: <1340212236-647-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

This patch series is a respin of the sub-series 3/6 from 
http://thread.gmane.org/gmane.linux.kernel.mmc/14624/focus633
of which the first patch has been superseded by "mmc: tmio: Don't access 
hardware registers after stopping clocks"
http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg14696.html
This series also requires "mmc: add a function to get a regulator, 
supplying card's Vdd"
http://www.spinics.net/lists/linux-sh/msg12007.html

Patch 4 of this series also contributes to part 3 of the scheme, described 
in http://thread.gmane.org/gmane.linux.ports.sh.devel/15544

Thanks
Guennadi

Guennadi Liakhovetski (7):
  mmc: tmio: don't needlessly enable interrupts during probing
  mmc: tmio: add callbacks to enable-update and disable the interface
    clock
  mmc: sdhi: implement tmio-mmc clock enable-update and disable
    callbacks
  mmc: tmio: add regulator support
  mmc: sdhi: do not install dummy callbacks
  mmc: tmio: use MMC opcode defines instead of numbers
  mmc: tmio: remove a duplicated comment line

 drivers/mmc/host/sh_mobile_sdhi.c |   38 +++++++++++---
 drivers/mmc/host/tmio_mmc_pio.c   |  101 ++++++++++++++++++++++++++++---------
 include/linux/mfd/tmio.h          |    3 +
 3 files changed, 108 insertions(+), 34 deletions(-)

-- 
1.7.2.5

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
