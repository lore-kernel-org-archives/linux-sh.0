From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 09 Dec 2011 23:42:44 +0000
Subject: [RFC][PATCH 0/4] PM / shmobile: Use PM QoS latency constraints in touchscreen driver
Message-Id: <201112100042.45168.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-sh list <linux-sh@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, LKML <linux-kernel@vger.kernel.org>

Hi,

The following series of patches updates the SH7372 PM domain's so that
A4R doesn't need to be turned on during system sleep, drops the SH7372's
PM domains stay_on flag and makes the touchscreen add a PM QoS constraint
on its I2C controller to prevent the A4R domain containing it from being
turned off (due to power management) when the touchscreen is active.

Comments welcome!

Thanks,
Rafael

