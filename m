From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 15 Jan 2016 02:44:14 +0000
Subject: [PATCH v2 0/2] ARM: shmobile: r8a779[01]: use GIC_* defines
Message-Id: <1452825856-16230-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

this short series uses GIC_* defines in the r8a779[01] device trees as
appropriate.

I plan to post follow up patches to update the device trees for
other Renesas SoCs depending on the success of this series.

Based on renesas-devel-20160111-v4.4

Changes since v1:
* Use GIC_* define in a few places that were missed in v1


Simon Horman (2):
  ARM: shmobile: r8a7790: use GIC_* defines
  ARM: shmobile: r8a7791: use GIC_* defines

 arch/arm/boot/dts/r8a7790.dtsi | 368 +++++++++++++++++++--------------------
 arch/arm/boot/dts/r8a7791.dtsi | 386 ++++++++++++++++++++---------------------
 2 files changed, 377 insertions(+), 377 deletions(-)

-- 
2.1.4

