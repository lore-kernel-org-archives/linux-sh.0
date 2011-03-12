From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 12 Mar 2011 16:10:35 +0000
Subject: Re: [PATCH 1/4 v2] mmc: mn57xx: only access registers above 0xff, if available
Message-Id: <AANLkTi=CwkzwvDy+CTzJBni-OtZUMEtmceNr+-xpuVOK@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1103110854050.23675@axis700.grange>
	<Pine.LNX.4.64.1103110900080.23675@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1103110900080.23675@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

On Fri, Mar 11, 2011 at 5:09 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Not all mn57xx / tmio implementations have registers above oxff.
> Accessing them on thise platforms is dangerous. In some cases it leads
> to address wrapping to addresses below 0x100, which corrupts random
> unrelated registers.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> v2:

> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c

Nice, it looks like this patch should apply on your earlier broken out
patch set...

> + =A0 =A0 =A0 if (resource_size(res) > 0x100) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL,=
 0x0000);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(10);
> + =A0 =A0 =A0 }

... but now since you've separated the tmio specific code from the
SDHI implementation, why don't you just make all the offsets above
0x100 stay in the tmio code, and let the SDHI only access below 0xff?

Thanks,

/ magnus
