From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Dec 2015 05:30:00 +0000
Subject: [PATCH 8/8 v4] thermal: of-thermal: of_thermal_set_trip_temp() call thermal_zone_device_update()
Message-Id: <87io495x3c.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vb895x9d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vb895x9d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

of_thermal_set_trip_temp() updates trip temperature. It should call
thermal_zone_device_update() immediately.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4

 - no change

 drivers/thermal/of-thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 42b7d42..a1dd7b1 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -334,6 +334,8 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 	/* thermal framework should take care of data->mask & (1 << trip) */
 	data->trips[trip].temperature = temp;
 
+	thermal_zone_device_update(tz);
+
 	return 0;
 }
 
-- 
1.9.1

