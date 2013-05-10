From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 10 May 2013 08:05:17 +0000
Subject: [PATCH 0/2] ARM: shmobile: lager: enable Ether
Message-Id: <1368173119-27345-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

this short series enables the on-board ethernet
of the r8a7790 SoC for on lager baord.

It is based on the renesas-next-20130509 tag of my renesas tree.

It has a run-time dependency on
"sh_eth: add support for r8a7790 SoC"

Simon Horman (2):
  ARM: shmobile: r8a7790: add Ether support
  ARM: shmobile: lager: enable Ether

 arch/arm/boot/dts/r8a7790-lager.dts           |  2 +-
 arch/arm/mach-shmobile/board-lager.c          | 26 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c        |  6 +++++-
 arch/arm/mach-shmobile/include/mach/r8a7790.h |  3 +++
 arch/arm/mach-shmobile/setup-r8a7790.c        | 15 +++++++++++++++
 5 files changed, 50 insertions(+), 2 deletions(-)

-- 
1.8.2.1

