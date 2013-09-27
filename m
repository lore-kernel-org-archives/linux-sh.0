From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 27 Sep 2013 07:57:30 +0000
Subject: Re: [PATCH v5] ARM: shmobile: armadillo800eva-reference: add SDHI and MMCIF interfaces
Message-Id: <Pine.LNX.4.64.1309270924190.23205@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309261931340.11968@axis700.grange>
 <5211142.rSOJTFTEIy@avalon>
In-Reply-To: <5211142.rSOJTFTEIy@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 27 Sep 2013, Laurent Pinchart wrote:

[snip]

> > +	sdhi0: sdhi@e6850000 {
> > +		compatible = "renesas,sdhi-r8a7740";
> > +		reg = <0xe6850000 0x100>;
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <0 117 4
> 
> board-armadillo800eva.c doesn't use IRQ 117 for SDHI0. It includes a comment 
> that mentions "no SH_MOBILE_SDHI_IRQ_CARD_DETECT here". Should it be fixed in 
> the board file ?

No, it shouldn't. On shmobile in .c mode devices like MMC hosts are 
specified in board files and thus are board-specific. In armadillo800eva 
the CD line on SDHI0 in the .c mode is used as a GPIO, that's why we don't 
need to provide the SDHI own CD interrupt.

In DT mode SDHI nodes are specified in an SoC-common .dtsi file, so, we 
put all resources there, including the CD interrupt. But on 
armadillo800eva a different pin is used for CD and as long as we didn't 
have GPIO support in DT we had to use polling here. Now, however, we can 
specify a CD GPIO. Let me post an updated patch.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
