From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 12 Sep 2013 13:51:01 +0000
Subject: Re: [PATCH 0/3] Lager i2c bus support
Message-Id: <Pine.LNX.4.64.1309121545410.7038@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1378813194-19493-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1378813194-19493-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon

On Tue, 10 Sep 2013, Guennadi Liakhovetski wrote:

> Hi Ulrich
> 
> On Tue, 10 Sep 2013, Ulrich Hecht wrote:
> 
> > This is the i2c part of the previously posted HDMI encoder RFC. The
> > following suggestions have been applied:
> > 
> > - keep platform device out of SoC setup
> > - use device ID to trigger H2-specific behavior in i2c driver
> >   instead of platform data
> > - minor adjustments for style
> > - subjects cleared up
> > 
> > (The pinmux patch has been adopted by Laurent and thus omitted here.)
> > 
> > CU
> > Uli
> > 
> > 
> > Nguyen Viet Dung (2):
> >   i2c: rcar: support R-Car H2 in i2c bus driver
> >   ARM: shmobile: r8a7790: add the I2C bus clock
> > 
> > Ulrich Hecht (1):
> >   ARM: shmobile: r8a7790: lager: i2c support
> 
> Some of this patches will conflict with this my series
> 
> http://thread.gmane.org/gmane.linux.kernel/1558455
> 
> Most conflicts won't be hard to resolve, you only add I2C busses 1 and 2, 
> whereas I'm more interested in bus #3 (DVFS) on r8a7790. But there are 
> also some other differences: if these my patches
> 
> http://thread.gmane.org/gmane.linux.ports.sh.devel/26975
> 
> get accepted, then the clock scheme for I2C on H2 will change a bit, e.g. 
> the peripheral_clock won't be needed. And I really think that should be 
> the right way to go. Let's wait for some comments.

What is your preferred way to resolve this? We can choose one of the 
following:

1. merge the two i2c clock patches into one - feel free to take my code 
into "ARM: shmobile: r8a7790: add the I2C bus clock" from this series

2. port one of the patches on top of the other one - if this series isn't 
going to be modified again, I can port my patch on top of it.

Thanks
Guennadi

> >  arch/arm/mach-shmobile/board-lager.c   | 60 ++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-shmobile/clock-r8a7790.c | 11 +++++++
> >  drivers/i2c/busses/i2c-rcar.c          | 35 ++++++++++++++++++--
> >  3 files changed, 104 insertions(+), 2 deletions(-)
> > 
> > -- 
> > 1.8.1.4

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
