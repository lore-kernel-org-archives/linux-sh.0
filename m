From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 16 Nov 2011 21:05:27 +0000
Subject: Re: [PATCH 3/3] ARM: mach-shmobile: sh7372 A4R support (v4)
Message-Id: <Pine.LNX.4.64.1111162201330.7421@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <201110200012.43840.rjw@sisk.pl> <Pine.LNX.4.64.1111021132240.19054@axis700.grange>
 <CANqRtoS5KTws7rDoHkxrq8DP+js5xq=YF3zQG4MYmmjHEtv5NA@mail.gmail.com>
 <201111030017.00780.rjw@sisk.pl>
In-Reply-To: <201111030017.00780.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Hi all

3.2-rc2 halts on ap4evb after

[    0.085937] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.085937] msgmni has been set to 246
[    0.085937] io scheduler noop registered (default)

(normally the following would be printed out afterwards:

[    0.398437] sh-mobile-hdmi sh-mobile-hdmi: Detected HDMI controller 0x0:0x0
[    0.406250] sh_mobile_meram sh_mobile_meram.0: sh_mobile_meram initialized.
[    0.421875] Console: switching to colour frame buffer device 160x45
[    0.429687] graphics fb0: registered sh_mobile_lcdc_fb/mainlcd as 1280x720 16bpp.
[    0.437500] graphics fb1: registered sh_mobile_lcdc_fb/mainlcd as 544x961 16bpp.

) and git bisect pointed out at this commit as a culprit. Indeed, 
reverting it fixes the hanger. I'll send my .config off-list.

Thanks
Guennadi

On Thu, 3 Nov 2011, Rafael J. Wysocki wrote:

> On Wednesday, November 02, 2011, Magnus Damm wrote:
> > On Wed, Nov 2, 2011 at 11:38 AM, Guennadi Liakhovetski
> > <g.liakhovetski@gmx.de> wrote:
> > > On Thu, 20 Oct 2011, Rafael J. Wysocki wrote:
> > >
> > >> From: Magnus Damm <damm@opensource.se>
> > >>
> > >> This change adds support for the sh7372 A4R power domain.
> > >
> > > This version still breaks I2C (#0) on mackerel. Tested with your
> > > sh7372-test branch of Oct 18th plus these four patches:
> > >
> > > 6b29305a PM / Domains: Add default power off governor function (v2)
> > > 3d578ae PM / Domains: Add device stop governor function (v2)
> > > 6c2cd02 ARM: mach-shmobile: sh7372 A4R support (v4)
> > > 9da11f4 ARM: mach-shmobile: sh7372 A3SP support (v4)
> > 
> > Exactly how does it break IIC0?
> 
> It causes some initialization issues to happen.  I get the following
> messages on every boot:
> 
> i2c-sh_mobile i2c-sh_mobile.0: Transfer request timed out
> i2c-sh_mobile i2c-sh_mobile.0: Polling timed out
> 
> three times in a row (there's a delay too).
> 
> The A4R patch is the source of that.
> 
> > Does the same happen with the code base for upcoming 3.2-rc1 from
> > latest linux git?
> 
> Yes, it does, AFAICT.
> 
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
