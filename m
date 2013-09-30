From: Simon Horman <horms@verge.net.au>
Date: Mon, 30 Sep 2013 23:53:06 +0000
Subject: Re: [PATCH v2 0/5] ARM: shmobile: CPUFreq support on Lager
Message-Id: <20130930235306.GB13399@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1380216060-14506-1-git-send-email-g.liakhovetski@gmx.de>
 <Pine.LNX.4.64.1309301719460.16868@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1309301719460.16868@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-kernel@vger.kernel.org

Hi Guennadi,

On Mon, Sep 30, 2013 at 05:25:42PM +0200, Guennadi Liakhovetski wrote:
> Hi Simon,
> 
> Just a quick check of the status of this patch series:
> 
> On Thu, 26 Sep 2013, Guennadi Liakhovetski wrote:
> 
> > On Lager a da9210 regulator is used to supply DVFS power to the SoC. This
> > patch series adds I2C and Z-clock support on r8a7790 and CPUFreq support
> > for the Lager board. Please note, that patch 4/4 is an RFC as explained
> > inline.
> > 
> > Developed on top of today's
> > 
> >     git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git    devel
> > 
> > plus i2c-rcar patches from my earlier patch series
> > 
> > [PATCH v2 0/5] i2c: rcar: Device Tree support and clock improvements
> > 
> > and the "sh-pfc: r8a7790: Add I2C pin groups and functions" patch from
> > Ulrich Hecht.
> > 
> > All changes since v1 are noted in respective patches. They all are trivial,
> > still as soon as test hardware is available, it would be good to run-time
> > test this version too.
> > 
> > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > 
> > Guennadi Liakhovetski (5):
> >   pinctrl: sh-pfc: r8a7790: add pin definitions for the I2C3 interface
> 
> Laurent has taken this one.
> 
> >   ARM: shmobile: r8a7790: add I2C clocks and aliases for the DT mode
> >   ARM: shmobile: r8a7790: add I2C DT nodes
> 
> You've applied the above two too, thanks.
> 
> >   ARM: shmobile: r8a7790: add CPUFreq clock support
> 
> Do I see it right, that you're waiting for a review for the above one?

Yes, sorry for not being clearer.
I would like a review of this.

> >   ARM: shmobile: lager: (DEVEL) add CPUFreq support
> 
> Once a review of #4/5 is posted, I can split the above patch into two to 
> separate shmobile and DT parts, as requested by Sergei. Is that about what 
> you're expecting too?

Again, sorry for not being clearer. Yes, I agree with Sergei.
I would like the patch split into a DT patch and a board patch.
