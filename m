From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 17 Apr 2014 10:18:21 +0000
Subject: [GIT PULL FOR v3.16] SH-Mobile IPMMU miscellaneous cleanups
Message-Id: <2764209.oq6GXMERSj@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1396482562-1851-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396482562-1851-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Joerg,

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git iommu/for-v3.16

for you to fetch changes up to b11762f8431b3a5cf1c156876e79efab7d7f80c4:

  iommu/shmobile: Use devm_ioremap_resource() (2014-04-17 12:16:12 +0200)

The patches have been sitting on the linux-sh and iommu mailing lists for more 
than two weeks, I think they should be ripe now.

----------------------------------------------------------------
Laurent Pinchart (2):
      iommu/shmobile: Don't ignore the ipmmu_iommu_init() return value
      iommu/shmobile: Use devm_ioremap_resource()

 drivers/iommu/shmobile-ipmmu.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

-- 
Regards,

Laurent Pinchart

