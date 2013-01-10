From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 10 Jan 2013 12:04:37 +0000
Subject: Re: [PATCH v2 2/2] spi: bitbang: convert to using core message queue
Message-Id: <Pine.LNX.4.64.1301101304210.24058@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1301091502020.13376@axis700.grange>
	<Pine.LNX.4.64.1301091507120.13376@axis700.grange>
	<Pine.LNX.4.64.1301091535490.13376@axis700.grange>
	<CACRpkdbsbXTM47TYTjF9sJQaMRetTbHm0Xri-=2kWsdK14AYPw@mail.gmail.com>
In-Reply-To: <CACRpkdbsbXTM47TYTjF9sJQaMRetTbHm0Xri-=2kWsdK14AYPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 10 Jan 2013, Linus Walleij wrote:

> On Wed, Jan 9, 2013 at 3:44 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> 
> > [   79.968000] mmc0: new SD card on SPI
> > [   79.976000] mmcblk0: mmc0:0000 SU02G 1.84 GiB
> > [   80.024000]  mmcblk0: p1
> > [   80.132000] mmcblk0: error -38 sending status command, retrying
> > [   80.136000] mmcblk0: error -38 sending status command, retrying
> > [   80.140000] mmcblk0: error -38 sending status command, aborting
> > [   81.028000] mmc0: SPI card removed
> > [   81.572000] mmc0: error -110 whilst initialising SD card
> 
> The queue mechanism has not changed.
> 
> This *could* be the card itself. So it doesn't appear before the patch?

No.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
