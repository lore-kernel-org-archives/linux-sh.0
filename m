From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Mar 2013 15:46:31 +0000
Subject: [ANNOUNCE] Renesas branch refresh
Message-Id: <20130313154630.GB2755@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I would like to announce that I have pushed fresh branches to
the renesas tree on kernel.org which for the basis of what I intend
to request arm-soc to pull for v3.10.

The new/rebased branches are as follows:

* next-for-v3.10

  A merge of fixes, defconfig, soc, pinmux and boards.
  I have not named this next at this time primarily because
  it includes the pinmux branch which is based on a branch of
  Linus Walleij's linux-pinctrl tree and I would like his approval
  to use that in linux-next and request it to be pulled into arm-soc first.

* fixes

  Critical fixes targeted at inclusion in v3.9.
  Based on v3.9-rc1.

* defconfig

  defconfig changes.
  Based on v3.9-rc2.

* soc

  SoC changes.
  Based on v3.9-rc2.

* pinmux

  pinmux changes, a.k.a Laurent's work
  Based on pinmux-base, a merge of: fixes and the devel branch of
  Linus Walleij's linux-pinctrl tree on kernel.org

* boards

  Branch for board changes.
  Based on boards-base, a merge of the pinmux and soc branches.


Old/unmodified branches. Not targeted at inclusion in arm-soc at this time.

* next

  This is present-in linux-next
  It is based on v3.8-rc3.
  I intend to replace it with next-for-v3.10 in the near future.

* topic/*

  These are based on v3.8-rc3.
  The only ones that still seem relevant are:
  * topic/intc-of
  * topic/r-car-du-drm
  * topic/sh_eth
  I intend the rebase the branches listed immediately above and
  remove the rest. I do not believe there is any need for
  topic/all+next at this point and I plan to remove it too.


Deleted branches:

* boards3: Rebased and renamed boards
* soc5: Rebased and renamed soc
* pfc: Included in v3.9-rc2
* boards-kzm9g-reference: Merged into soc and boards branches
