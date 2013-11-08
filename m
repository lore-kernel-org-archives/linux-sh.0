From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 08 Nov 2013 06:27:08 +0000
Subject: Re: [PATCH V2 2/2] dt: Document sata_rcar bindings
Message-Id: <874n7nquh4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383854642-21660-1-git-send-email-valentine.barshak@cogentembedded.com>
	<1383854642-21660-3-git-send-email-valentine.barshak@cogentembedded.com>
	<7820946.JfD46VSKC7@avalon>
In-Reply-To: <7820946.JfD46VSKC7@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>


Hi Laurent, Simon

One question

> > +- interrupts		: must consist of one interrupt specifier.
> > +
> > +Example:
> > +
> > +sata: sata@fc600000 {
> > +	compatible = "renesas,sata-r8a7779";
> > +	reg = <0xfc600000 0x2000>;
> > +	interrupt-parent = <&gic>;
> > +	interrupts = <0 100 0x4>;
> 
> Please use IRQ_TYPE_LEVEL_HIGH instead of 0x4.

Now, our many SoC codes are using 0x4 in "interrupts".
Do you think we should use IRQ_TYPE_LEVEL_HIGH ?

Best regards
---
Kuninori Morimoto
