From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 24 Oct 2012 10:49:50 +0000
Subject: [Q] "console=" command line ignored?
Message-Id: <Pine.LNX.4.64.1210241226060.31768@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, linux-sh@vger.kernel.org

Hi

I cannot seem to force selection of a serial console by specifying 
"console=ttySC0..." on the command line with modern (yesterday's "next") 
kernels. The kernel insists on

console [tty0] enabled

The reason might also well be, that the respective "sh-sci" driver is 
only registered later. I'll try to look at this in more detail - since 
when this is broken and how the registration order looked before. This is 
just a first heads-up in case someone has a solution immediately at hand.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
