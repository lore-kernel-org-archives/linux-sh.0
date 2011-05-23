From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 23 May 2011 06:49:49 +0000
Subject: Re: [PATCH 2/6 v2] sh_mobile_meram: MERAM framework for LCDC
Message-Id: <20110523064949.GI5206@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1305717011-20742-3-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1305717011-20742-3-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 18, 2011 at 08:10:07PM +0900, Damian Hobson-Garcia wrote:
> +/*
> + * mark the specified ICB as used
> + */
> +
> +static inline void meram_mark(struct sh_mobile_meram_priv *priv,
> +			      struct sh_mobile_meram_icb *new)
> +{
> +	int n;
> +
> +	if (new->marker_icb < 0 || new->cache_icb < 0)
> +		return;
> +
> +	__set_bit(new->marker_icb, &priv->used_icb);
> +	__set_bit(new->cache_icb, &priv->used_icb);
> +
A minor nit, but you may wish to document the fact that the _mark/unmark
calls expect the caller to be holding &priv->lock in order to make it
obvious why the __xxx_bit() accessors are safe. Given that the MERAM
stuff applies to SMP parts too, someone could be in for a nasty surprise
with regards to write visibility without the explicit barrier otherwise.

You can do this in a follow-up patch though given that the current patch
at least gets the utilization sufficiently correct.
