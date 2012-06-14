From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Jun 2012 11:12:33 +0000
Subject: Re: [PATCH] mmc: tmio: Don't access hardware registers after stopping clocks
Message-Id: <CANqRtoQdzq5VHqBo1WQUYimVAYsGM6+XmE5r1Aoadm_HpY=eMA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1339505838-8831-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1339505838-8831-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hey Laurent,

[CC Rafael]

On Tue, Jun 12, 2012 at 9:57 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> The tmio_mmc_set_ios() function configures the MMC power, clock and bus
> width. When the MMC controller gets powered off, runtime PM switches the
> MSTP clock off. Writing to to CTL_SD_MEM_CARD_OPT register afterwards
> fails and prints an error message to the kernel log.
>
> As configuring the bus width is pointless when the interface gets
> powered down, skip the operation when power is off.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

First of all, thanks for reporting this issue and coming up with a fix!

Can you please explain a bit more about when this triggers? Is this
related to suspend-to-ram perhaps? Which hardware platform? Is
CONFIG_PM_RUNTIME=3Dy set?

I suspect that this may be a side effect of the current PM code used
on the A1 SoC (which is hooked up on the armadillo board).

In short, the A1 SoC does not yet make use of PM domains, but AP4 and
the mackerel board (sh7372 based) is using PM domains. This difference
may result in different state of clocks at suspend-to-ram timing. So
the SDHI driver may work just fine on the mackerel board, but not on
the armadillo board. If that's the case then perhaps we shouldn't fix
the driver, but instead look at the platform level.

> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_=
pio.c
> index 9a7996a..de1226d 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -816,13 +816,15 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, =
struct mmc_ios *ios)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmio_mmc_clk_stop(host);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 switch (ios->bus_width) {
> - =A0 =A0 =A0 case MMC_BUS_WIDTH_1:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, =
0x80e0);
> - =A0 =A0 =A0 break;
> - =A0 =A0 =A0 case MMC_BUS_WIDTH_4:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, =
0x00e0);
> - =A0 =A0 =A0 break;
> + =A0 =A0 =A0 if (host->power) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (ios->bus_width) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BUS_WIDTH_1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16(host, CTL_S=
D_MEM_CARD_OPT, 0x80e0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BUS_WIDTH_4:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16(host, CTL_S=
D_MEM_CARD_OPT, 0x00e0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Let things settle. delay taken from winCE driver */
> --
> 1.7.3.4

Is it possible that you get here through tmio_mmc_host_suspend() and
mmc_suspend_host()?

Just guessing. =3D)

Thanks,

/ magnus
