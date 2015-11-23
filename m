From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 23 Nov 2015 07:16:42 +0000
Subject: [PATCH 0/2] ARM: shmobile: alt: Correct pfc
Message-Id: <1448263004-14548-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

0c9400fab882 ("Merge branch 'heads/dt-for-v4.5' into next") introduced
pfc pins to the alt device tree but did not reference them. This patch
set addresses that and other deficiencies in that patch.

Written and tested against renesas-next-20151118-v4.4-rc1

Simon Horman (2):
  ARM: shmobile: alt: Correct scif2 pfc
  ARM: shmobile: alt: Correct ether pfc

 arch/arm/boot/dts/r8a7794-alt.dts | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.1.4

