From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 26 Sep 2013 09:57:50 +0000
Subject: Re: [PATCH/RFC v4] ARM: shmobile: armadillo800eva-reference: add SDHI and MMCIF interfaces
Message-Id: <Pine.LNX.4.64.1309261152220.11968@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus

On Thu, 26 Sep 2013, Magnus Damm wrote:

> On Mon, Sep 23, 2013 at 8:38 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Add SDHI0, SDHI1 and MMCIF interfaces to armadillo800eva-reference with
> > regulators and pin configurations.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> >
> > v4:
> >
> > 1. now that PFC pinctrl is usable with DT, we can use proper regulators
> > and pin configurations on armadillo800eva
> 
> Good, thanks for your efforts.
> 
> > 2. corrected SDHI compatibility strings
> 
> Ok, thanks.
> 
> > 3. RFC because I don't know how to enable choosing between CON14 and CON8.
> > In .c version this is done by reading GPIO 6. To do the same in DT mode
> > we'd probably have to use some run-time DT patching, which isn't possible
> > yet, AFAICS.
> 
> Regarding run time checking, this seems to me that it is something
> that cannot be supported by DT at this time. Because of that, would it
> be possible to reduce the scope of this patch to only cover the MMC
> device that is unrelated to GPIO 6?
> 
> I propose that the other two devices should be handled my platform
> device code until DT can do runtime switching or when we can use
> pinctrl together with bind/unbind to select which MMC device to use.

Yes, this is another possibility. But in an earlier email I proposed 
another solution, which could work, if my assumption about the use of the 
same pin configuration in both cases is correct. I'll try to flip the 
switch and test if I can detect the WLAN module (if it is mounted on my 
board). I'll report back later.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
