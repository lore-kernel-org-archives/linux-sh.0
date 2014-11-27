From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 27 Nov 2014 15:19:11 +0000
Subject: [PATCH 0/2] Fix legacy boards compilation breakage with DU
Message-Id: <1417101553-5233-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>

Hello,

The DU driver has lost support for platform data, resulting in a compilation
breakage for the legacy Marzen and Lager board files that managed to keep
under the radar until now.

As the multiplatform boards should be used instead, drop support for DU in the
legacy Marzen and Lager boards.

Simon, this is required to fix a compilation breakage in the drm-next branch.
I'm sorry for not catching it earlier :-/ How would you like this to go in ?
Could the patches be applied to the DRM tree ? They seem to apply cleanly to
both drm-next and your latest devel branch.

Laurent Pinchart (2):
  ARM: shmobile: lager: Remove DU platform device
  ARM: shmobile: marzen: Remove DU platform device

 arch/arm/mach-shmobile/board-lager.c  | 58 -----------------------------------
 arch/arm/mach-shmobile/board-marzen.c | 58 -----------------------------------
 2 files changed, 116 deletions(-)

-- 
Regards,

Laurent Pinchart

