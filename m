From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 24 Jul 2014 15:27:02 +0000
Subject: [PATCH 0/3] Renesas IPMMU-VMSA fixes
Message-Id: <1406215625-13982-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org

Hello,

This series fixes small issues with the ipmmu-vmsa driver. Please see
individual patches for details.

If not too late, I'd like these fixes to be merged in v3.17 (after proper
review of course, or, in the worst case, after lack of review).

Laurent Pinchart (3):
  iommu/ipmmu-vmsa: Cleanup failures of ARM mapping creation or
    attachment
  iommu/ipmmu-vmsa: Flush P[UM]D entry before freeing the child page
    table
  iommu/ipmmu-vmsa: Invalidate TLB after unmapping

 drivers/iommu/ipmmu-vmsa.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

-- 
Regards,

Laurent Pinchart

