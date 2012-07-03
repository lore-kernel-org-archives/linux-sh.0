From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 03 Jul 2012 10:18:24 +0000
Subject: Boot regression on Mackerel with current mainline
Message-Id: <201207031218.24797.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

We seem to have a functional regression on Mackerel with 3.5-rc5 which
seems to be related to SDHI.  Namely, the SDHI driver appears to wait forever
for the devices to appear and commenting out all of the sdhi devices in the
board file works around the problem.

I can investigate some more later today if need be.

Thanks,
Rafael
