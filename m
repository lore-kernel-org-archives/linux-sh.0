From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 09 Aug 2013 14:26:34 +0000
Subject: my outstanding patches for 3.12
Message-Id: <Pine.LNX.4.64.1308091531040.937@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Hi Vinod

There are still a number of DMA patches from me for 3.12, that still 
aren't in next. I think, the easiest way to get them all is to look for 
instructions in patch 0/0 from this series:

http://thread.gmane.org/gmane.linux.ports.sh.devel/26161

Otherwise, unless I'm missing anything, here's the list of single patches 
with their respective patchwork IDs - it includes two more patches, not 
mentiones at the above link:

DMA: shdma: fix CHCLR register address calculation
pw ID: 2813531

DMA: shdma: switch to managed resource allocation
pw ID: 2813591

DMA: shdma: switch all __iomem pointers to void
pw ID: 2813611

DMA: shdma: support the new CHCLR register layout
pw ID: 2825593

DMA: shdma: make a pointer const
pw ID: 2837949

DMA: sudmac: fix compiler warning
pw ID: 2837890

DMA: shdma: move two macros to a header
pw ID: 2831934

DMA: shdma: switch DT mode to use configuration data from a match table
pw ID: 2837974

DMA: shdma: remove private and unused defines from a global header
pw ID: 2837962

DMA: shdma: add a header with common for ARM SoCs defines
pw ID: 2837964

DMA: shdma: add r8a73a4 DMAC data to the device ID table
pw ID: 2837967

As I mentioned in a separate mail, I'm mostly offline for the next two 
weeks, hopefully, there won't be problems with these patches.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
