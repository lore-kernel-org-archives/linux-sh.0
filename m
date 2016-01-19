From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 19 Jan 2016 16:20:55 +0000
Subject: [RFC 0/6] mmc: sdhi: add basic r8a7795 support
Message-Id: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

So, I started working on the SDHI part. Since Dirk seems to be working on the
clocks already (thanks!), I evaluated the patches for the mmc-subsystem and
refactored the subset which gets the basic functionality run. A few cleanups
were applied, too. The patches are RFC because I want to check one more issue
(restore clock settings after software reset) and also I need to do Gen2
regression testing. However, release early, I wanted to show you what I am
hacking on here. A branch for testing (with Dirk's clock patches and DTS
additions can be found here):

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/v8-sdhi-nodma

Further testing much appreciated. It works fine on my Salvator using SD cards
on both, SDHI0 and SDHI3. Simple testing, though, no stress testing yet.

Thanks,

   Wolfram


Shinobu Uehara (1):
  mmc: sdhi: Add EXT_ACC register busy check

Wolfram Sang (5):
  mmc: sdhi: error message on ENOMEM is superfluous
  mmc: tmio: add flag to reduce delay after changing clock status
  mmc: tmio: remove stale comments
  mmc: sdhi: use faster clock handling on RCar Gen2
  mmc: sdhi: Add r8a7795 support

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |  1 +
 drivers/mmc/host/Kconfig                           |  2 +-
 drivers/mmc/host/sh_mobile_sdhi.c                  | 54 +++++++++++++++-------
 drivers/mmc/host/tmio_mmc_pio.c                    |  7 +--
 include/linux/mfd/tmio.h                           |  4 ++
 5 files changed, 45 insertions(+), 23 deletions(-)

-- 
2.1.4

