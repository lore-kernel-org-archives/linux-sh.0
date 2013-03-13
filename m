From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 13 Mar 2013 12:58:37 +0000
Subject: Re: [PATCH 00/03] gpio: Renesas R-Car GPIO driver update
Message-Id: <1670937.hEFtzrbkf6@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20130313113203.30133.49539.sendpatchset@w520>
In-Reply-To: <20130313113203.30133.49539.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linus.walleij@linaro.org, grant.likely@secretlab.ca, horms@verge.net.au

Hi Magnus,

Thanks for the patches.

On Wednesday 13 March 2013 20:32:03 Magnus Damm wrote:
> gpio: Renesas R-Car GPIO driver update
> 
> [PATCH 01/03] gpio: Renesas R-Car GPIO driver V2
> [PATCH 02/03] gpio: rcar: Use IRQCHIP_SET_TYPE_MASKED
> [PATCH 03/03] gpio: rcar: Make use of devm functions
> 
> This series updates the R-Car GPIO driver with various
> changes kindly suggested by Laurent Pinchart.
> 
> Patch [01/03] is a drop in replacement for V1 of the R-Car
> GPIO driver. The flag in patch [02/03] is kept out of [01/03]
> to avoid changing the behaviour of the driver between V1 and V2.
> Also, devm support in [03/03] is kept out of [01/03] to make
> sure back porting goes as smooth as possible.

As I mentioned in a previous e-mail, all the devm_* functions used in 03/03 
have been available since 2.6.30. Do you really need to port that driver to 
older kernels ?

Regarding 02/03, do you plan to squash it with 01/03 for the mainline 
submission ?

-- 
Regards,

Laurent Pinchart

