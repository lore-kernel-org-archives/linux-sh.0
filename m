From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 18 Mar 2013 18:26:36 +0000
Subject: [PATCH/RFC 0/2] ARM: shmobile: switchable regulators for SDHI
Message-Id: <Pine.LNX.4.64.1303181922240.4980@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi

The following two patches implement power switching for all SDHI ports on 
armadillo800eva and kzm9g. They don't fix any bugs or implement any 
long-wanted functionality, still, they might be useful to save a bit of 
power and to serve as examples for other boards. Feel free to take them or 
to drop them.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
