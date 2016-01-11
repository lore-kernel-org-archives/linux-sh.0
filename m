From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 11 Jan 2016 04:07:41 +0000
Subject: [PATCH 0/3] VSP1: Add support for tri-planar memory formats
Message-Id: <1452485264-11328-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello,

This small patch series implement support for tri-planar (YUV) memory formats
in the VSP1 driver.

The first patch in the series cleans up the YUV and YVU 4:2:0 tri-planar
documentation that is unnecessarily split in two files. The second patch then
documents the YUV/YVU 4:2:2 and 4:4:4 tri-planar formats, and the third patch
finally adds support for them in the VSP1 driver.

The series is based on top of my mid-December VSP1 pull request for v4.5 that
hasn't made it to linuxtv master yet. If the request can't be pulled for v4.5
I'll reissue it for v4.6 with this series included.

Laurent Pinchart (3):
  v4l: Merge the YUV and YVU 4:2:0 tri-planar non-contiguous formats
    docs
  v4l: Add YUV 4:2:2 and YUV 4:4:4 tri-planar non-contiguous formats
  v4l: vsp1: Add tri-planar memory formats support

 Documentation/DocBook/media/v4l/pixfmt-yuv420m.xml |  26 +--
 Documentation/DocBook/media/v4l/pixfmt-yuv422m.xml | 166 +++++++++++++++++++
 Documentation/DocBook/media/v4l/pixfmt-yuv444m.xml | 177 +++++++++++++++++++++
 Documentation/DocBook/media/v4l/pixfmt-yvu420m.xml | 154 ------------------
 Documentation/DocBook/media/v4l/pixfmt.xml         |   3 +-
 drivers/media/platform/vsp1/vsp1_pipe.c            |  20 +++
 drivers/media/v4l2-core/v4l2-ioctl.c               |   4 +
 include/uapi/linux/videodev2.h                     |   4 +
 8 files changed, 390 insertions(+), 164 deletions(-)
 create mode 100644 Documentation/DocBook/media/v4l/pixfmt-yuv422m.xml
 create mode 100644 Documentation/DocBook/media/v4l/pixfmt-yuv444m.xml
 delete mode 100644 Documentation/DocBook/media/v4l/pixfmt-yvu420m.xml

-- 
Regards,

Laurent Pinchart

