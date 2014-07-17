From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Jul 2014 01:00:57 +0000
Subject: Re: [PATCH 05/11] mmc: tmio: Fix DMA source address
Message-Id: <8738e0g5o8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1405464321-4723-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<87r41mkrpl.wl%kuninori.morimoto.gx@renesas.com>
	<3064066.cLMrQSJucc@avalon>
In-Reply-To: <3064066.cLMrQSJucc@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>


Hi Laurent

> > Unfortunately, this patch breaks compatibility.
> > This "+ 0x2000" is required only from Renesas R-Car.
> > I alreay sent this fixup patch before (not accepted yet, and I will re-send
> > v2 patch soon)
> > 
> > https://www.mail-archive.com/linux-mmc@vger.kernel.org/msg26776.html
> 
> I've applied your patch locally, thank you. You can add my Acked-by line to 
> v2. When do you plan to push it to mainline ?

Thank you.
I think v2 will be posted in next week.
