From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 25 Jul 2013 12:59:52 +0000
Subject: [PATCH v3 2/5] v4l: Fix V4L2_MBUS_FMT_YUV10_1X30 media bus pixel code value
Message-Id: <1374757213-20194-3-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1374757213-20194-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1374757213-20194-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@iki.fi>, Katsuya MATSUBARA <matsu@igel.co.jp>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The V4L2_MBUS_FMT_YUV10_1X30 code is documented as being equal to
0x2014, while the v4l2-mediabus.h header defines it as 0x2016. Fix the
documentation.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 Documentation/DocBook/media/v4l/subdev-formats.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/DocBook/media/v4l/subdev-formats.xml b/Documentation/DocBook/media/v4l/subdev-formats.xml
index adc6198..0c2b1f2 100644
--- a/Documentation/DocBook/media/v4l/subdev-formats.xml
+++ b/Documentation/DocBook/media/v4l/subdev-formats.xml
@@ -2574,7 +2574,7 @@
 	    </row>
 	    <row id="V4L2-MBUS-FMT-YUV10-1X30">
 	      <entry>V4L2_MBUS_FMT_YUV10_1X30</entry>
-	      <entry>0x2014</entry>
+	      <entry>0x2016</entry>
 	      <entry></entry>
 	      <entry>y<subscript>9</subscript></entry>
 	      <entry>y<subscript>8</subscript></entry>
-- 
1.8.1.5

