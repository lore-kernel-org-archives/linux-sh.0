From: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
Date: Thu, 01 Oct 2015 12:03:30 +0000
Subject: [PATCH 0/2] media: platform: rcar_jpu: code cleanup and release function changes
Message-Id: <1443701012-20730-1-git-send-email-mikhail.ulyanov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hverkuil@xs4all.nl, horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, mchehab@osg.samsung.com
Cc: laurent.pinchart@ideasonboard.com, j.anaszewski@samsung.com, kamil@wypas.org, sergei.shtylyov@cogentembedded.com, devicetree@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>

This series of patches includes improvements and code cleanup for rcar_jpu driver.

Mikhail Ulyanov (2):
  V4L2: platform: rcar_jpu: remove redundant code
  V4L2: platform: rcar_jpu: switch off clock on release later

 drivers/media/platform/rcar_jpu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
2.5.1

