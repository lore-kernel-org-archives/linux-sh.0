From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 28 Jan 2010 08:24:04 +0000
Subject: Re: [PATCH 1/4 v4] ASoC: add a WM8978 codec driver
Message-Id: <Pine.LNX.4.64.1001280854040.4356@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001271846020.5073@axis700.grange>
	<20100127201755.GA11601@rakim.wolfsonmicro.main>
In-Reply-To: <20100127201755.GA11601@rakim.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Paul Mundt <lethal@linux-sh.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Dan Williams <dan.j.williams@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Wed, 27 Jan 2010, Mark Brown wrote:

> On Wed, Jan 27, 2010 at 06:56:23PM +0100, Guennadi Liakhovetski wrote:
> 
> > The WM8978 codec from Wolfson Microelectronics is very similar to wm8974, 
> > but
> > is stereo and also has some differences in pin configuration and internal
> > signal routing. This driver is based on wm8974 and takes the differences 
> > into
> > account.
> 
> I suspect something funny with word wrapping :)
> 
> There's a few more fairly small issues below but I'll apply the patch
> as-is, please send incremental patches to fix these things.

Great, thanks! Now, the SIU driver itself depends on some other patches, 
some of which are still not in any public tree. Specifically, these ones:

http://thread.gmane.org/gmane.linux.ports.sh.devel/7129

are needed to compile the DMA driver. Dan, Iwamatsu-san, what's the status 
of those patches?

Also a remark to patches 3 and 4 from this series

http://thread.gmane.org/gmane.linux.ports.sh.devel/7171

logically, they depend on patches 1, 2a, and 2b, and they affect the 
arch/sh directory. So, maybe Paul can just ack them and then we can pull 
them via the ALSA tree?

I'll try to make incremental patches for the codec in the meantime.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
