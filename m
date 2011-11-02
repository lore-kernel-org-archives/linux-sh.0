From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 02 Nov 2011 20:52:40 +0000
Subject: Re: [PATCH 3/3] ARM: mach-shmobile: sh7372 A4R support (v4)
Message-Id: <Pine.LNX.4.64.1111022131460.19054@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <201110200012.43840.rjw@sisk.pl> <201110200015.06277.rjw@sisk.pl>
 <Pine.LNX.4.64.1111021132240.19054@axis700.grange>
 <CANqRtoS5KTws7rDoHkxrq8DP+js5xq=YF3zQG4MYmmjHEtv5NA@mail.gmail.com>
In-Reply-To: <CANqRtoS5KTws7rDoHkxrq8DP+js5xq=YF3zQG4MYmmjHEtv5NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Hi Magnus

On Wed, 2 Nov 2011, Magnus Damm wrote:

> On Wed, Nov 2, 2011 at 11:38 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On Thu, 20 Oct 2011, Rafael J. Wysocki wrote:
> >
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> This change adds support for the sh7372 A4R power domain.
> >
> > This version still breaks I2C (#0) on mackerel. Tested with your
> > sh7372-test branch of Oct 18th plus these four patches:
> >
> > 6b29305a PM / Domains: Add default power off governor function (v2)
> > 3d578ae PM / Domains: Add device stop governor function (v2)
> > 6c2cd02 ARM: mach-shmobile: sh7372 A4R support (v4)
> > 9da11f4 ARM: mach-shmobile: sh7372 A3SP support (v4)
> 
> Exactly how does it break IIC0?

We discussed it a couple of weeks ago, remember? Here's a quote:

> > > 3. I2C #0 doesn't work (last worked with some 3.1-rc7 based kernel). It is
> > > needed for the keypad, without which I don't know how the board can be
> > > woken up
> > 
> > That's odd. It worked fine when I tested with Morimoto-san earlier
> > today. Are we using the same code?
> 
> I hope so. I'm using what Rafael suggested in his mail:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git sh7372-test
> 
> HEAD currently at commit
> 
> commit 2b7a2158042fbed2dc0c677d24efc2d3c8680186
> Author: Magnus Damm <damm@opensource.se>
> Date:   Sun Oct 16 23:35:59 2011 +0200
> 
>     ARM: mach-shmobile: sh7372 A4R support (v3)
> 
> I2C works with HEAD^

Of course, now testing with v4 of A3SP and A4R patches. As for "exactly 
how":

i2c-sh_mobile i2c-sh_mobile.0: I2C adapter 0 with bus speed 100000 Hz
i2c-sh_mobile i2c-sh_mobile.1: I2C adapter 1 with bus speed 100000 Hz
Linux video capture interface: v2.00
soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver attached to camera 0
sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver detached from camera 0
sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver attached to camera 0
sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver detached from camera 0
i2c-sh_mobile i2c-sh_mobile.0: Transfer request timed out
i2c-sh_mobile i2c-sh_mobile.0: Polling timed out
tca6416-keypad 0-0020: tca6416_read_reg failed, reg: 1, error: -5
tca6416-keypad: probe of 0-0020 failed with error -5

So, seems just not to be enabled.

> Does the same happen with the code base for upcoming 3.2-rc1 from
> latest linux git?

Good question:

linux-2.6/arch/arm/kernel/entry-armv.S: Assembler messages:
linux-2.6/arch/arm/kernel/entry-armv.S:501: Error: backward ref to unknown label "2:"
linux-2.6/arch/arm/kernel/entry-armv.S:502: Error: backward ref to unknown label "3:"
make[2]: *** [arch/arm/kernel/entry-armv.o] Error 1

So, no, it doesn't;-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
