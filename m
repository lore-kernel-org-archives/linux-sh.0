From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 05 Jul 2012 13:54:30 +0000
Subject: Re: [PATCH 2/7 v2] ASoC: siu: don't use DMA device for channel filtering
Message-Id: <Pine.LNX.4.64.1207051549010.30191@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1341484183-10757-1-git-send-email-g.liakhovetski@gmx.de>
 <1341484183-10757-3-git-send-email-g.liakhovetski@gmx.de>
 <20120705120826.GU4111@opensource.wolfsonmicro.com>
In-Reply-To: <20120705120826.GU4111@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 5 Jul 2012, Mark Brown wrote:

> On Thu, Jul 05, 2012 at 12:29:38PM +0200, Guennadi Liakhovetski wrote:
> > DMA channels are filtered based on slave IDs, no need to additionally filter
> > on DMA device.
> 
> This doesn't apply, please regenerate against current code.

Sure, as I mentioned in my description mail: "This patch series goes on 
top of my earlier patches to split shdma.c." And that patch series, also 
available at

git://github.com/lyakh/linux.git shdma-base

contains this patch:

commit 553d9459a90e9cc6997da2c34bb637794d6a4ac5
    ASoC: siu: prepare for conversion to the shdma base library

Sorry, I should have mentioned, that various DMA slave drivers also have 
dependencies in that series.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
