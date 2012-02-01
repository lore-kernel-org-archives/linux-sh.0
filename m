From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 01 Feb 2012 12:48:23 +0000
Subject: Re: [REGRESSION] current Linus tree doesn't suspend on sh7372 (mackerel)
Message-Id: <Pine.LNX.4.64.1202011345550.24739@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rafael

On Wed, 1 Feb 2012, Rafael J. Wysocki wrote:

> Hi,
> 
> On Tuesday, January 31, 2012, Guennadi Liakhovetski wrote:
> > Hi
> > 
> > Current Linus' tree doesn't suspend on mackerel for me (will send .config 
> > and the command line off-list).
> 
> You seem to have MTD enabled in your .config and there's a known suspend
> regression in MTD.  Can you please check if the attached patch helps?

Yes, it does, thanks! Or it does at least partially - if MERAM is enabled 
the fb content is destroyed after resume, which is a separate problem, 
apparently.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
