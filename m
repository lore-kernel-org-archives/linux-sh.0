From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 19 Sep 2014 18:46:29 +0000
Subject: Re: [PATCH v4] tmio_mmc_pio: prevent endless loop in tmio_mmc_set_clock()
Message-Id: <CAPDyKFpZnkkDbUHX3HmcGK7+7NEnUU526RADFO+O1xS6mzUhnQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <10228473.uOqbQ0oioV@wasted.cogentembedded.com>
In-Reply-To: <10228473.uOqbQ0oioV@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ian Molton <ian.molton@codethink.co.uk>, Chris Ball <chris@printf.net>, Linux-sh list <linux-sh@vger.kernel.org>

On 18 September 2014 21:33, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> I spent a couple of days with the driver just hanging due to me forgetting to
> specify the external crystal frequency,  so that clk_get_rate() returned 0 and
> thus the loop in tmio_mmc_set_clock() never ended. I don't think that's an
> acceptable behavior, so I suggest that the minimum frequency is checked for 0
> in tmio_mmc_host_probe().
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Ian Molton <ian.molton@codethink.co.uk>
> Cc: stable@vger.kernel.org

Thanks! Applied for next with a smaller change - adding a "mmc" prefix
for the commit message subject.

Kind regards
Uffe

>
> ---
> The patch is against Ulf Hansson's 'mmc.git' repo's 'next' branch.
>
> Changes in version 4:
> - rebased to the 'next' branch, resolving reject;
> - added Ian Molton's ACK.
>
> Changes in version 3:
> - added Cc: stable.
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
> @@ -1091,6 +1091,15 @@ int tmio_mmc_host_probe(struct tmio_mmc_
>         }
>
>         /*
> +        * Check the sanity of mmc->f_min to prevent tmio_mmc_set_clock() from
> +        * looping forever...
> +        */
> +       if (mmc->f_min = 0) {
> +               ret = -EINVAL;
> +               goto host_free;
> +       }
> +
> +       /*
>          * While using internal tmio hardware logic for card detection, we need
>          * to ensure it stays powered for it to work.
>          */
>
