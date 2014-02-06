From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 Feb 2014 12:06:33 +0000
Subject: Re: [PATCH 1/3] mmc: tmio-mmc: add DMA SG synchronisation
Message-Id: <Pine.LNX.4.64.1402061304001.1264@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1401311237080.3234@axis700.grange>
 <Pine.LNX.4.64.1401311248320.3234@axis700.grange> <52F3798C.4040906@codethink.co.uk>
In-Reply-To: <52F3798C.4040906@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Ben

On Thu, 6 Feb 2014, Ben Dooks wrote:

> On 31/01/14 11:54, Guennadi Liakhovetski wrote:
> > According to the DMA API data has to be synchronised before starting
> > a DMA transfer to device and after completing a DMA transfer from device.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> I've got 1/3 and 2/3, but not 3/3 ?

Unfortunately that thread didn't make it to the ALKML - all patches 
bounced, so, they only arrived to sh and mmc. (A day before and a couple 
of hours later posting to ALKML worked just fine, just that one time...). 
You can view the whole thread here
http://thread.gmane.org/gmane.linux.kernel.mmc/24969/focus$972

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
