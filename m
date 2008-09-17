From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 17 Sep 2008 14:57:32 +0000
Subject: Re: [PATCH] mtd: sh_flctl: add support for Renesas SuperH FLCTL
Message-Id: <20080917145731.GA31104@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48C62D1E.7020906@renesas.com>
In-Reply-To: <48C62D1E.7020906@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Cc: linux-mtd@lists.infradead.org, dwmw2@infradead.org, linux-sh@vger.kernel.org

On Tue, Sep 09, 2008 at 05:00:30PM +0900, Yoshihiro Shimoda wrote:
> Several Renesas SuperH CPU has FLCTL. The FLCTL support NAND Flash.
> This driver support SH7723.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

> +	flctl->reg = ioremap(res->start, res->end - res->start);
> +	if (flctl->reg = NULL) {
> +		printk(KERN_ERR "%s: ioremap error.\n", __func__);
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
You have an off-by-1 here, this wants to be res->end - res->start + 1.

Other than that, it looks ok to me at first glance.

Acked-by: Paul Mundt <lethal@linux-sh.org>
