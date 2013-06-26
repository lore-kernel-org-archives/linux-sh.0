From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 26 Jun 2013 08:40:38 +0000
Subject: [PATCH v2 0/2] ARM: shmobile: r8a7790: add thermal driver support
Message-Id: <1372236040-16737-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This short series enables the thermal driver on the r8a7790 SoC
and thus the lager board.

It is based on renesas-next-20130620

Simon Horman (2):
  ARM: shmobile: r8a7790: add thermal driver support
  ARM: shmobile: r8a73a4: add clocks for thermal

 arch/arm/mach-shmobile/clock-r8a7790.c |  4 ++++
 arch/arm/mach-shmobile/setup-r8a7790.c | 12 ++++++++++++
 2 files changed, 16 insertions(+)

-- 
1.8.2.1

