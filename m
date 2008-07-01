From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Tue, 01 Jul 2008 08:17:49 +0000
Subject: Re: [PATCH v3] video: sh7760fb: SH7760/SH7763 LCDC framebuffer
Message-Id: <20080701081748.GA5499@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4869DC13.30604@renesas.com> <20080701080006.GB4726@linux-sh.org>
In-Reply-To: <20080701080006.GB4726@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>, linux-fbdev <Linux-fbdev-devel@lists.sourceforge.net>, Linux-sh <linux-sh@vger.kernel.org>Nobuh

Hello Paul, Iwamatsu-san,

On Tue, Jul 01, 2008 at 05:00:06PM +0900, Paul Mundt wrote:
> On Tue, Jul 01, 2008 at 04:26:11PM +0900, Nobuhiro Iwamatsu wrote:
> > +static void sh7760fb_wait_vsync(struct fb_info *info)
> > +{
> > +	struct sh7760fb_par *par = info->par;
> > +
> > +	if (par->pd->novsync)
> > +		return;
> > +}
> > +
> This doesn't do anything, and you never use ->novsync for anything
> anywhere else either. I'd suggest killing both of them off until such a
> time that you plan to do something with it.

I'm working on reimplementing it. I'll submit a patch when it's ready.

 
> > +	/* poll for access grant */
> > +	tmo = 100;
> > +	while (!(ioread16(par->base + LDPALCR) & (1 << 4)) && (--tmo))
> > +		msleep(0);
> > +
> Err.. you are sleeping for 0ms? Just use cpu_relax() here instead if you
> don't have an explicit timing requirement.

I put the msleep here to prevent gcc from removing the loop.


Best regards,
	Manuel Lauss
