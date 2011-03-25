From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 25 Mar 2011 14:19:50 +0000
Subject: Re: outstanding tmio patches
Message-Id: <Pine.LNX.4.64.1103251518290.22824@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1103231505450.6836@axis700.grange>
 <m3k4folztx.fsf@pullcord.laptop.org> <m3mxkjl2nr.fsf@pullcord.laptop.org>
In-Reply-To: <m3mxkjl2nr.fsf@pullcord.laptop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Ball <cjb@laptop.org>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Mundt <lethal@linux-sh.org>

On Fri, 25 Mar 2011, Chris Ball wrote:

> Hi Guennadi,
> 
> On Thu, Mar 24 2011, Chris Ball wrote:
> >> [1/2] mmc: tmio: Improve DMA stability on sh-mobile
> >> [2/2] mmc: tmio: use PIO for short transfers
> 
> Thanks, these two are applied now.
> 
> >> [1/6,v2] mmc: tmio: split core functionality, DMA and MFD glue
> 
> But now we have a merge conflict here, since we just changed the
> codebase that this patch moves around.

Hm, strange, now all patches should be correct - if the correct versions 
are taken. Let's do it easier: I've uploaded all 15 patches (14 mine and 1 
from Simon) as a quilt series to

http://download.open-technology.de/tmio-for-2.6.39/

Please, just try those.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
