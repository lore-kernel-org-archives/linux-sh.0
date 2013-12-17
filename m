From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 17 Dec 2013 17:18:48 +0000
Subject: [PATCH 0/2] SH Mobile IOMMU fixes
Message-Id: <1387300730-28783-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Nguyen Viet Dung <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

These two small patches fix bugs in the SH Mobile IOMMU driver that result in
crashes at runtime. Given that the bugs have been present in the driver since
v3.9 there's no urgency to push the fixes to v3.13.

Laurent Pinchart (2):
  iommu/shmobile: Allocate archdata with kzalloc()
  iommu/shmobile: Turn the flush_lock mutex into a spinlock

 drivers/iommu/shmobile-iommu.c |  3 +--
 drivers/iommu/shmobile-ipmmu.c | 10 +++++-----
 drivers/iommu/shmobile-ipmmu.h |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

-- 
Regards,

Laurent Pinchart

