From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 17 Dec 2012 08:44:10 +0000
Subject: Re: [PATCH 05/10] ARM: shmobile: Add DT table of INTC for sh7372
Message-Id: <Pine.LNX.4.64.1212170941400.24007@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1355562224-29448-1-git-send-email-horms+renesas@verge.net.au>
 <1355562224-29448-6-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1355562224-29448-6-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon

On Sat, 15 Dec 2012, Simon Horman wrote:

> From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> 
> Cc: Magnus Damm <damm@opensource.se>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

What happened to intcs support? Why has it been dropped? Without it many 
important devices cannot be set up from DT, e.g. I2C #0.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
