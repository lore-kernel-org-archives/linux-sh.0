From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sat, 21 Jan 2012 16:15:07 +0000
Subject: Re: [PATCH v4 6/6] dmaengine: shdma: add support for SUDMAC
Message-Id: <Pine.LNX.4.64.1201211711550.16722@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0D3A10.7000708@renesas.com>
In-Reply-To: <4F0D3A10.7000708@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Shimoda-san

On Fri, 20 Jan 2012, Shimoda, Yoshihiro wrote:

> I will study the dma-simple driver, and I will implement the SUDMAC driver
> using this.

Great, thanks!

> By the way, when I applied the "dma: shdma: convert to the simple DMA library" patch,
> I couldn't apply it. (Many "Hunk #nn FAILED" output...)
> So, would you tell me your using kernel commit?
> I used today's "torbalds/linux.git" and "slave-dma.git".

I think, the easiest for you would be to pull from

git://github.com/lyakh/linux.git

and use the "shmobile" branch, that already includes all my patches, that 
you need. In fact, you only need a couple of them, so, you can also drop 
all my mmc patches, that you don't need.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
