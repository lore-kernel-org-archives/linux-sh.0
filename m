From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Aug 2011 03:09:50 +0000
Subject: Re: [PATCH 2/4] mmc: tmio: Provide separate interrupt handlers
Message-Id: <CANqRtoTprsGo4yAMtfLGXjd+KQffM5f9rNnXXMFWxg-aL3nyBA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
	<1313716221-20136-3-git-send-email-horms@verge.net.au>
In-Reply-To: <1313716221-20136-3-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Fri, Aug 19, 2011 at 10:10 AM, Simon Horman <horms@verge.net.au> wrote:
> Provide separate interrupt handlers which may be used by platforms where
> SDHI has three interrupt sources.
>
> This patch also removes the commented-out handling of CRC and other error=
s.
>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
>
> ---

> +irqreturn_t tmio_mmc_irq(int irq, void *devid)
> +{
> + =A0 =A0 =A0 struct tmio_mmc_host *host =3D devid;
> + =A0 =A0 =A0 unsigned int ireg, status;
> +
> + =A0 =A0 =A0 pr_debug("MMC IRQ begin\n");
> +
> + =A0 =A0 =A0 tmio_mmc_card_irq_status(host, &ireg, &status);
> + =A0 =A0 =A0 if (__tmio_mmc_card_detect_irq(host, ireg, status))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 if (__tmio_mmc_sdcard_irq(host, ireg, status))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> +
> + =A0 =A0 =A0 tmio_mmc_sdio_irq(irq, devid);
>
> -out:
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
> =A0EXPORT_SYMBOL(tmio_mmc_irq);

Is there any particular reason for returning early in this interrupt
handler? By returning early I mean the "if ... return IRQ_HANDLED"
cases above.

I realize the old ISR code in the driver does just this, so if the
goal is to stay compatible then I guess we should keep this behavior.
From my point of view it usually makes more sense to try to handle all
events that may be associated with the IRQ.

Thanks,

/ magnus
