From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 02 Dec 2013 01:29:43 +0000
Subject: Re: [PATCH 2/4] sh-pfc: r8a7790: Add Audio pin support
Message-Id: <87k3foca63.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mwkn52sx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mwkn52sx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> On Thursday 28 November 2013 19:01:37 Kuninori Morimoto wrote:
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> I've applied the patch to my tree and will send a pull request to Linus 
> Walleij for v3.14.
> 
> Please see below for one small comment.
(snip)
> > +static const unsigned int audio_clkout_d_mux[] = {
> > +	AUDIO_CLKOUT_D_MARK,
> > +};
> > +
> 
> The file has no blank line after all the other groups, I've thus removed this 
> blank line. Please let me know if you're fine with that.

Thank you.
I have no objection about it.


Best regards
---
Kuninori Morimoto
