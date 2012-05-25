From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 25 May 2012 06:52:51 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: add missing GPIO IRQ configuration on mackerel
Message-Id: <Pine.LNX.4.64.1205250843290.13353@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <u7hovvdt9.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u7hovvdt9.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 25 May 2012, Magnus Damm wrote:

> Hi Guennadi,
> 
> On Thu, May 24, 2012 at 10:18 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > SDHI0 card-detect GPIO IRQ on mackarel currently works, because it is the
> > default configuration of IRQ26. However, we should not rely on this and
> > should configure the function explicitly.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> This looks like a regression fix. Can you please point out which
> commit that caused this?

No, I don't think it is one. My original commit, that added the SDHI0 
card-detect GPIO IRQ feature was already missing the configuration call:

commit 4bff4a7ee4b9e487a1bc1d31082e77b6a381418a
Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date:   Wed May 11 16:51:20 2011 +0000

    ARM: arch-shmobile: support SDHI card detection on mackerel, using a GPIO

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
