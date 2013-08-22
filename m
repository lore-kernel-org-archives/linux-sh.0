From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 22 Aug 2013 17:56:55 +0000
Subject: [PATCH 0/2] Renesas VSP1 fixes
Message-Id: <1377194217-24235-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello,

Here's two fixes for the Renesas VSP1 driver. The first one reports the platform
device name through the media device bus_info field, allowing applications to
differentiate between VSP1 instances. The second one gets rid of a crash related
to missing clocks for the VSPR and VSPS instances.

I'd like to get those patches in v3.12-rc1 if possible.

Laurent Pinchart (2):
  v4l: vsp1: Initialize media device bus_info field
  v4l: vsp1: Add support for RT clock

 drivers/media/platform/vsp1/vsp1.h     |  1 +
 drivers/media/platform/vsp1/vsp1_drv.c | 42 ++++++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 5 deletions(-)

-- 
Regards,

Laurent Pinchart

