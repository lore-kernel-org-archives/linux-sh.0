From: Phil Edworthy <PHIL.EDWORTHY@renesas.com>
Date: Fri, 10 Dec 2010 10:26:23 +0000
Subject: VEU, BEU & VPU userspace drivers
Message-Id: <AB12B32E73474741A2C5361C433A44DE0264BB2E@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

New userspace drivers for the VEU, BEU & VPU found on the SH-MobileR2R
(SH7724) device are available.

The drivers have been modified to allow any userspace buffer to be passed to
them. If the buffer cannot be directly accessed by the hardware (e.g. it was
not allocated using UIOMux), then the drivers will allocate a suitable
buffer and copy the data.


UIOMux (libuiomux 1.5.0)
A conflict manager for system resources, including UIO devices.
https://oss.renesas.com/modules/document/?libuiomux

VEU Driver (libshveu 1.5.2)
Hardware accelerated scale, rotate & colorspace conversion.
https://oss.renesas.com/modules/document/?libshveu

BEU Driver (libshbeu 1.0.2)
Hardware accelerated overlay, alpha blending & colorspace conversion.
https://oss.renesas.com/modules/document/?libshbeu

VPU Driver (libshcodecs 1.4.0)
Hardware accelerated video decode and encode (requires additional libraries
provided by Renesas).
https://oss.renesas.com/modules/document/?libshcodecs

GStreamer plugins (gst-sh-mobile 0.10.2)
Hardware accelerated GStreamer elements exposing the functionality of the
above libraries.
https://oss.renesas.com/modules/document/?GStreamer


All of the above packages are available under the terms of the GNU LGPL. 

These packages have been developed and tested using the MS7724 development
board, using Buildroot to create the root file system (see
http://wiki.github.com/pedwo/buildroot).

Renesas Electronics Europe
Dec 2010
