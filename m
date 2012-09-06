From: Simon Horman <horms@verge.net.au>
Date: Thu, 06 Sep 2012 03:12:47 +0000
Subject: Renesas tree branch changes
Message-Id: <20120906031247.GA2934@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

in order to more closely align my renesas tree[1] with the arm-soc[2] tree
I have re-arranged the branches as follows.

* Renamed branches

  - ag5evm -> cleanup
  - soc-core -> dt
  - kzm9g -> soc
  - armadillo800eva -> armadillo800eva-fixes
    - This was merged into the fixes branch of the arm-soc tree
    - In future changes of this nature will be added to the fixes branch

* Split branches

  - marzen
    + "ARM: shmobile: marzen: enable thermal sensor"
      - Moved to boards branch
    + "ARM: shmobile: marzen: fixup regulator id for smsc911x"
      - Moved to boards branch
    + "ARM: mach-shmobile: marzen: defconfig update"
      - Renamed "ARM: shmobile: marzen: defconfig update"
      - Moved to defconfig branch
    + "marzen: add SDHI0 support"
      - Renamed "ARM: shmobile: marzen: add SDHI0 support"
      - Non-defconfig portion moved into boards branch
      - defconfig portion rolled into "ARM: shmobile: marzen: defconfig update"
    + "r8a7779: add SDHI clock support"
      - Moved to soc branch

* Unchanged branches

  - fixes

* Removed branches

  - r8a7740
    + The only patch in the branch needs further work
      "ARM: shmobile: r8a7740: add USB24 clock explain and sample code"

  - kzm9g-gpio
    + This needs to be rebased as its current base, the devel branch of
      git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
      turns out to be unstable (= rebase has occurred).
    + There was one patch in this branch
      "ARM: shmobile: kzm9g: use gpio-keys instead of gpio-keys-polled"


[1] git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
[2] git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git





