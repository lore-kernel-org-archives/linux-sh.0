From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 08 Sep 2014 11:17:13 +0000
Subject: Re: [PATCH v2] tmio_mmc_pio: prevent endless loop in tmio_mmc_set_clock()
Message-Id: <CAPDyKFr8voHFgn5_yNpvJT6L3Dj--kjq7dy8qrc-uUg_r7278g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2535223.qa7H57Aml3@wasted.cogentembedded.com>
In-Reply-To: <2535223.qa7H57Aml3@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ian Molton <ian.molton@codethink.co.uk>, Chris Ball <chris@printf.net>, Linux-sh list <linux-sh@vger.kernel.org>

On 5 September 2014 23:42, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> I spent a couple of days with the driver just hanging due to me forgetting to
> specify the external crystal frequency,  so that clk_get_rate() returned 0 and
> thus the loop in tmio_mmc_set_clock() never ended. I don't think that's an
> acceptable behavior, so I suggest that the minimum frequency is checked for 0
> in tmio_mmc_host_probe().
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> The patch is against Ulf Hansson's 'mmc.git' repo's 'fixes' branch.

Hi Sergei,

Could you please base it towards "next" instead, it doesn't apply. If
you think this is important to go stable, I suggest you to add a
stable tag for it.

Kind regards
Uffe

>
> Changes in version 2:
> - fixed grammar in the changelog.
>
>  drivers/mmc/host/tmio_mmc_pio.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> Index: mmc/drivers/mmc/host/tmio_mmc_pio.c
> =================================> --- mmc.orig/drivers/mmc/host/tmio_mmc_pio.c
> +++ mmc/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1044,6 +1044,15 @@ int tmio_mmc_host_probe(struct tmio_mmc_
>         }
>
>         /*
> +        * Check the sanity of mmc->f_min to prevent tmio_mmc_set_clock() from
> +        * looping forever...
> +        */
> +       if (mmc->f_min = 0) {
> +               ret = -EINVAL;
> +               goto pm_disable;
> +       }
> +
> +       /*
>          * There are 4 different scenarios for the card detection:
>          *  1) an external gpio irq handles the cd (best for power savings)
>          *  2) internal sdhi irq handles the cd
>
