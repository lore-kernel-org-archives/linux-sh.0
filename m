From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 25 Jan 2013 10:13:13 +0000
Subject: Re: [PATCH v2 0/8] Use gpio_request_one() in SH Mobile board code
Message-Id: <Pine.LNX.4.64.1301251112280.17518@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1359029795-7871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1359029795-7871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent

On Thu, 24 Jan 2013, Laurent Pinchart wrote:

> Hello,
> 
> Here are the second version of the gpio_request_one() patches for all SH Mobile
> board files.
> 
> Compared to v1 the patches have been rebased on top of "[PATCH v4 00/81] SH pin
> control and GPIO rework", as the previous base isn't ready for mainline yet.
> The patches are otherwise unchanged.
> 
> Simon, with the appropriate acks I think this series could go to v3.9. If you
> would like a pull request, on which of your branches should I rebase the
> patches ? I've tried to rebase them on top of your current next branch and they
> apply fine, so picking them up from the mailing list shouldn't be an issue
> either.
> 
> Laurent Pinchart (8):

All look good to me:

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

>   ARM: shmobile: ag5evm: Use gpio_request_one()
>   ARM: shmobile: ap4evb: Use gpio_request_one()
>   ARM: shmobile: armadillo800eva: Use gpio_request_one()
>   ARM: shmobile: armadillo800eva: Use gpio_set_value() to set GPIO
>     value
>   ARM: shmobile: bonito: Use gpio_request_one()
>   ARM: shmobile: kota2: Use gpio_request_one()
>   ARM: shmobile: kzm9g: Use gpio_request_one()
>   ARM: shmobile: mackerel: Use gpio_request_one()
> 
>  arch/arm/mach-shmobile/board-ag5evm.c          | 22 ++++-------
>  arch/arm/mach-shmobile/board-ap4evb.c          | 33 +++++-----------
>  arch/arm/mach-shmobile/board-armadillo800eva.c | 52 ++++++++++----------------
>  arch/arm/mach-shmobile/board-bonito.c          |  7 ++--
>  arch/arm/mach-shmobile/board-kota2.c           |  9 ++---
>  arch/arm/mach-shmobile/board-kzm9g.c           | 18 +++------
>  arch/arm/mach-shmobile/board-mackerel.c        | 16 +++-----
>  7 files changed, 54 insertions(+), 103 deletions(-)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
