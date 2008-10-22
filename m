From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 22 Oct 2008 10:03:43 +0000
Subject: Re: [PATCH] sh: add support FLCTL for ap325rxa board
Message-Id: <20081022100343.GA13815@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48C63126.5060008@renesas.com>
In-Reply-To: <48C63126.5060008@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 22, 2008 at 06:45:14PM +0900, Yoshihiro Shimoda wrote:
> Paul Mundt wrote:
> >> +	/* FLCTL */
> >> +	ctrl_outw(0, PORT_PUCR);
> >> +	ctrl_outw(0, PORT_PVCR);
> >> +	ctrl_outw(0, PORT_PSELC);
> >> +	ctrl_outw(0, PORT_HIZCRC);
> >> +	ctrl_outw(0xFFFF, PORT_DRVCRA);
> >> +	ctrl_outw(0xFFFF, PORT_DRVCRB);
> >> +	ctrl_outw((ctrl_inw(PORT_PXCR) & 0x3fff) | 0x4000, PORT_PXCR);
> >> +	ctrl_outb(0x80, PORT_PXDR);
> >>  }
> >>
> >>  static struct sh_machine_vector mv_ap325rxa __initmv = {
> > 
> > I checked this part in with your original patch, but have since rewrote
> > it to grab all of the FLCTL pins through the new pinmux code. Please make
> > sure that it still works for you.
> 
> I checked that FLCTL worked correctly using today's sh-2.6.git.
> 
Great, thanks for testing!
