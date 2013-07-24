From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 24 Jul 2013 08:56:06 +0000
Subject: [PATCH v5 0/3] ARM: shmobile: lager: enable Ether
Message-Id: <1374656169-9241-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms+renesas@verge.net.au>

this short series enables the on-board ethernet
of the r8a7790 SoC for on lager board.

It has a run-time dependency on
"sh_eth: add support for r8a7790 SoC"

It has been built on top of renesas-next-20130724v2.

Simon Horman (3):
  ARM: shmobile: r8a7790: clocks for Ether support
  ARM: shmobile: lager: enable Ether
  ARM: shmobile: lager: enable nfsroot in DTS

 arch/arm/boot/dts/r8a7790-lager.dts    |  2 +-
 arch/arm/mach-shmobile/board-lager.c   | 30 ++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c |  4 ++++
 3 files changed, 35 insertions(+), 1 deletion(-)

-- 
1.8.2.1

