From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 17 Jul 2008 22:41:21 +0000
Subject: Re: [PATCH] sh: Add SuperH Mobile MSTPCR bits to clock framework
Message-Id: <20080717224121.GA17674@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080717095615.19566.83528.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080717095615.19566.83528.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 17, 2008 at 06:56:15PM +0900, Magnus Damm wrote:
> +#define DECLARE_MSTPCRN(regnr, bitnr, bitstr)		\
> +{							\
> +	.name = "mstp" __stringify(regnr) bitstr,	\
> +	.arch_flags = bitnr,				\
> +	.ops = &sh7722_mstpcr ## regnr ## _clk_ops,	\
> +}
> +
> +#define DECLARE_MSTPCR(regnr) \
> +	DECLARE_MSTPCRN(regnr, 31, "31"), \

This looks a bit clumsy. Why can't you __stringify bitnr and paste that
against the stringified regnr? You may not be able to use the helper
macros directly, but you can certainly abuse the pre-processor in such a
way.
