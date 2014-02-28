From: Patrick Titiano <ptitiano@baylibre.com>
Date: Fri, 28 Feb 2014 13:10:02 +0000
Subject: [PATCH 0/2] thermal: rcar-thermal: minor fixes
Message-Id: <1393593004-16285-1-git-send-email-ptitiano@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: magnus.damm@gmail.com, kuninori.morimoto.gx@renesas.com, eduardo.valentin@ti.com
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Patrick Titiano <ptitiano@baylibre.com>

Hi,
Here are 2 minor updates to the rcar-thermal driver.

First patch removes an unecessary mask applied in a if statement.
Because the same mask was already applied in the preceding statement,
the second one can be removed.

Second patch avoids updating the thermal zone in case an IRQ was triggered but
the temperature didn't effectively change.
Note this is not a driver issue.
Below is a captured debug trace illustrating the purpose of this patch:
out of 8 thermal zone updates, only 2 are actually necessary.

[   41.120000] rcar_thermal_work(): cctemp%000
[   41.120000] rcar_thermal_work(): new_ctemp0000
[   41.120000] rcar_thermal_work(): temp is now 30000C, update thermal zone
[   58.990000] rcar_thermal_work(): cctemp0000
[   58.990000] rcar_thermal_work(): nctemp0000
[   58.990000] rcar_thermal_work(): same temp, do not update thermal zone
[   59.290000] rcar_thermal_work(): cctemp0000
[   59.290000] rcar_thermal_work(): nctemp0000
[   59.290000] rcar_thermal_work(): same temp, do not update thermal zone
[   59.590000] rcar_thermal_work(): cctemp0000
[   59.590000] rcar_thermal_work(): nctemp0000
[   59.590000] rcar_thermal_work(): same temp, do not update thermal zone
[   59.890000] rcar_thermal_work(): cctemp0000
[   59.890000] rcar_thermal_work(): nctemp0000
[   59.890000] rcar_thermal_work(): same temp, do not update thermal zone
[   60.190000] rcar_thermal_work(): cctemp0000
[   60.190000] rcar_thermal_work(): nctemp0000
[   60.190000] rcar_thermal_work(): same temp, do not update thermal zone
[   60.490000] rcar_thermal_work(): cctemp0000
[   60.490000] rcar_thermal_work(): nctemp0000
[   60.490000] rcar_thermal_work(): same temp, do not update thermal zone
[   60.790000] rcar_thermal_work(): cctemp0000
[   60.790000] rcar_thermal_work(): nctemp5000
[   60.790000] rcar_thermal_work(): temp is now 35000C, update thermal zone

I suspect this may be due to sensor sampling accuracy / fluctuation,
but no formal proof.

Patrick Titiano (2):
  thermal: rcar-thermal: fix same mask applied twice
  thermal: rcar-thermal: update thermal zone only when temperature
    changes

 drivers/thermal/rcar_thermal.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
1.8.3.2

