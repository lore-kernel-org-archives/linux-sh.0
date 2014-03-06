From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 06 Mar 2014 18:01:18 +0000
Subject: Renesas RCar device-tree USB series
Message-Id: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is a new series covering enabling the RCar series of SoCs USB
with device-tree based booting. It has been tested on the R8A7790
Lager board.

Improvements from the previous series include:
	
	- mapping usb to the relevant phy by dt
	- better use of existing pci of functions

Note, there is still an issue with the second gigabyte of memory on
the Lager, which with current kernels causes the system to abort on
startup. This series will only work if the top memory area is disabled.

