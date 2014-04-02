From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 02 Apr 2014 23:49:19 +0000
Subject: [PATCH 0/3] SH-Mobile IPMMU miscellaneous cleanups
Message-Id: <1396482562-1851-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org

Hello,

These three patches are small cleanups for the SH-Mobile IPMMU driver. Nothing
special here, please see individual patches for details.

I plan to send a pull request in a couple of days.

Laurent Pinchart (2):
  iommu/shmobile: Don't ignore the ipmmu_iommu_init() return value
  iommu/shmobile: Use devm_ioremap_resource()

Paul Bolle (1):
  iommu/shmobile: Depend on ARCH_SHMOBILE

 drivers/iommu/Kconfig          |  2 +-
 drivers/iommu/shmobile-ipmmu.c | 20 +++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

-- 
Regards,

Laurent Pinchart

