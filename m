From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 24 May 2011 10:23:55 +0000
Subject: [PATCH 0/3] Make DMA slave ID 0 invalid to simplify platform data
Message-Id: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Currently platforms, using the SDHI TMIO driver, have to specify negative 
DMA slave IDs to force PIO mode. If default 0 is left, the driver 
recognises it as a valid DMA slave ID and tries to acquire channels. This 
fails then, because the driver cannot allocate two channels with the same 
ID, but it would be better to just make 0 an invalid ID to prevent this.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
