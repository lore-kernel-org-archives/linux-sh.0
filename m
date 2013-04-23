From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 23 Apr 2013 01:25:22 +0000
Subject: Re: [PATCH 01/37] sh-pfc: r8a7740: Add SCIF pin groups and functions
Message-Id: <87haiy598g.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1366671618-8796-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366671618-8796-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

Thank you for your hard work

> +/* - SCIFA0 ----------------------------------------------------------------- */
> +static const unsigned int scifa0_data_pins[] = {
> +	/* RXD, TXD */
> +	197, 198,
> +};

I guess these numbers mean PORT197, PORT198,
but,this kind of "direct numbering" is difficult to read/understand
for non-expert people IMO.
But, it is easy to understand that it is "GPIO PORT something" if there is ...

#define SH_GPIO_PORT(nr)	(nr)

This is just my opinion, and I'm not sure other people.

Best regards
---
Kuninori Morimoto
