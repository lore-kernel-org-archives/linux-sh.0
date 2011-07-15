From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Jul 2011 10:58:43 +0000
Subject: [PATCH 0/2] use both-edge GPIO interrupt for SDHI0 on mackerel
Message-Id: <Pine.LNX.4.64.1107151254300.22613@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1107140123070.30737@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1107140123070.30737@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>

As correctly pointed out by Magnus, IRQ-capable GPIOs on sh7372 can 
produce interrupts on both edges. These patches extend the intc driver and 
use this for SDHI0 hotplug detection on mackerel.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
