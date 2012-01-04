From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 04 Jan 2012 14:34:12 +0000
Subject: [PATCH 0/2] dma: shdma: clear buffers on reset
Message-Id: <Pine.LNX.4.64.1201041528570.30506@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Magnus Damm <magnus.damm@gmail.com>

This patch set fixes a runtime PM problem on shdma, whereby it fails to 
recover after the power domain has been switched off.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
