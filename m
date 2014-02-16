From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 16 Feb 2014 09:40:53 +0000
Subject: [PATCH 0/5] enable i2c on koelsch-dt (and cleanup lager)
Message-Id: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This series adds all rcar cores to the r8a7791 dtsi and enables bus 2 on the
koelsch board. Functionality was tested with reading/writing to an eeprom. Some
rcar driver issues have been observed, but they are independent from the dt
binding provided here. On the way, some cleanups were found which apply to
r8a7790 as well, yet those are only compile tested since I don't have HW access
to the lager board (yet).

The series is based on tag 'renesas-devel-v3.14-rc2-20140213' and can be found here
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/r8a7791-i2c

Please review/apply.


Wolfram Sang (5):
  ARM: shmobile: r8a7791: remove superfluous interrupt-parents
  ARM: shmobile: r8a7791: add i2c master nodes to dtsi
  ARM: shmobile: r8a7791: add i2c2 bus to koelsch dt
  ARM: shmobile: r8a7790: remove superfluous interrupt-parents
  ARM: shmobile: r8a7790: add i2c aliases to dtsi

 arch/arm/boot/dts/r8a7790.dtsi        |  38 +++----------
 arch/arm/boot/dts/r8a7791-koelsch.dts |  19 +++++++
 arch/arm/boot/dts/r8a7791.dtsi        | 100 +++++++++++++++++++++++-----------
 3 files changed, 95 insertions(+), 62 deletions(-)

-- 
1.8.5.1

