From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 27 Sep 2013 00:10:58 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: only enable used I2C interfaces in DT on all Renesas boards
Message-Id: <CANqRtoRNMOsRxN9qERungFxmw=e4v83Uy4JFxSMBj9Ldu8WNOQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309261259490.11968@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1309261259490.11968-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

On Thu, Sep 26, 2013 at 4:06 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Currently all I2C interfaces in all *.dtsi files for various Renesas SoCs
> are enabled by default. Switch them all off and only enable populated I2C
> interfaces in board-specific *.dts files.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Excellent, thank you!

/ magnus
