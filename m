From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Dec 2015 01:19:53 +0000
Subject: [PATCH 8/8 v5] thermal: trip_point_temp_store() calls thermal_zone_device_update()
Message-Id: <871taoqzn3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1u8qzsy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d1u8qzsy.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

trip_point_temp_store() updates trip temperature. It should call
thermal_zone_device_update() immediately.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v4 -> v5

 - implemented on thermal_core.c

 drivers/thermal/thermal_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d9e525c..768fb10 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -676,8 +676,12 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	ret = tz->ops->set_trip_temp(tz, trip, temperature);
+	if (ret)
+		return ret;
 
-	return ret ? ret : count;
+	thermal_zone_device_update(tz);
+
+	return count;
 }
 
 static ssize_t
-- 
1.9.1

