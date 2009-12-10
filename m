From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 10 Dec 2009 17:35:01 +0000
Subject: [PATCH 0/3 v2] sh: fix dma driver
Message-Id: <Pine.LNX.4.64.0912101826010.4487@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, linux-sh@vger.kernel.org

Further testing with preempt enabled revealed more problems with 
insufficient locking and improper descriptor state management. Therefore 
I'm resubmitting the

sh: fix DMA driver's descriptor chaining and cookie assignment

patch. At the same time I swapped it with stylistic changes, to put the 
complex stuff in the end. Also added a minor patch fixing comment in 
dmaengine.h. Patches

sh: DMA driver has to specify its alignment requirements
dmaengine: fix dmatest to verify minimum transfer length and test buffer size
sh: dmaengine support for sh7724

are not changed, so, not resubmitted

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
