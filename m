From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 24 Nov 2015 02:16:03 +0000
Subject: [PATCH v2 0/2] ARM: shmobile: alt: Correct pfc
Message-Id: <1448331365-21388-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

22b160713cb6 ("ARM: shmobile: alt: Add pfc pins to DT") introduced pfc pins
to the alt device tree but did not reference them. This patch set addresses
that and other deficiencies in that patch.

Written and tested against renesas-next-20151118-v4.4-rc1

Changes in v2:
* Corrected commit referenced in changelogs

Simon Horman (2):
  ARM: shmobile: alt: Correct scif2 pfc
  ARM: shmobile: alt: Correct ether pfc

 arch/arm/boot/dts/r8a7794-alt.dts | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.1.4

