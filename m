From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Date: Fri, 02 Mar 2018 16:35:41 +0000
Subject: [PATCH 5/5] media: MAINTAINERS: Add entry for Aptina MT9T112
Message-Id: <1520008541-3961-6-git-send-email-jacopo+renesas@jmondi.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1520008541-3961-1-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1520008541-3961-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi, mchehab@kernel.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Add entry for Aptina/Micron MT9T112 camera sensor. The driver is
currently orphaned.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 91ed6ad..1d8be25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9385,6 +9385,13 @@ S:	Maintained
 F:	drivers/media/i2c/mt9t001.c
 F:	include/media/i2c/mt9t001.h
 
+MT9T112 APTINA CAMERA SENSOR
+L:	linux-media@vger.kernel.org
+T:	git git://linuxtv.org/media_tree.git
+S:	Orphan
+F:	drivers/media/i2c/mt9t112.c
+F:	include/media/i2c/mt9t112.h
+
 MT9V032 APTINA CAMERA SENSOR
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	linux-media@vger.kernel.org
-- 
2.7.4

