From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 16 Dec 2011 00:10:08 +0000
Subject: [Update][PATCH 0/5] PM / shmobile: Use PM QoS latency constraints in touchscreen driver on SH7372
Message-Id: <201112160110.09124.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201112100042.45168.rjw@sisk.pl>
In-Reply-To: <201112100042.45168.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-sh list <linux-sh@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, LKML <linux-kernel@vger.kernel.org>

Hi,

I have reworked the patchset slightly.

On Saturday, December 10, 2011, Rafael J. Wysocki wrote:
> 
> The following series of patches updates the SH7372 PM domain's so that
> A4R doesn't need to be turned on during system sleep, drops the SH7372's
> PM domains stay_on flag and makes the touchscreen add a PM QoS constraint
> on its I2C controller to prevent the A4R domain containing it from being
> turned off (due to power management) when the touchscreen is active.

The first two patches are unchaged (apart from the Magnus' ACKs), as well
as the third one.  The fourth one, though, has been split as suggested by
Guennadi and the touchscreen part has been simplified slightly.

[1/5] - Don't include SH7372's INTCS in syscore suspend/resume.
[2/5] - Remove the stay_on flag from SH7372's PM domains.
[3/5] - Introduce dev_pm_qos_add_ancestor_request().
[4/5] - Make st1232 use device PM QoS constraints.
[5/5] - Allow the A4R domain to be turned off and on at runtime.

Thanks,
Rafael

