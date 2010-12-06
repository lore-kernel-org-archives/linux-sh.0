From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Dec 2010 00:12:43 +0000
Subject: [patch 0/3] mmc, ARM: Add zboot from MMC support for SuperH Mobile ARM
Message-Id: <20101206001243.949375995@vergenet.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This short series allows a ROM-able zImage to be written to MMC and for
SuperH Mobile ARM to boot directly from the MMCIF hardware block.

The first two patches make minor preparatory changes to the MMCIF code.
The last patch contains the code to load from the MMCIF hardware block.

