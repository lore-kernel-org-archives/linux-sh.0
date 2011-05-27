From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 27 May 2011 09:51:01 +0000
Subject: Re: [PATCH/RFC] mmc: sh_mmcif: maximize power saving
Message-Id: <BANLkTinaDmLCvPB4_2konsomPYJhNFXzhg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1105261524120.9307@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1105261524120.9307@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>

Hi Guennadi,

On Thu, May 26, 2011 at 10:33 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> This patch uses runtime PM to allow the system to power down the MMC
> controller, when the MMC closk is switched off.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> Patches have been submitted earlier for SDHCI to accomplish something
> similar, but they have complicated dependencies upon other different
> subsystems, especially on PCI. MMCIF is easier - it only exists in
> different SoCs, so, this change should also be easier to review, verify
> and test.

Nice to see improved Power Management for the MMCIF driver!

> @@ -901,8 +902,16 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, s=
truct mmc_ios *ios)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (ios->clock)
> + =A0 =A0 =A0 if (ios->clock) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!host->power) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p->set_pwr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->set_pwr(=
host->pd, ios->power_mode);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(&host->=
pd->dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->power =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sh_mmcif_sync_reset(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sh_mmcif_clock_control(host, ios->clock);

You seem to be resetting the MMCIF block regardless if the power has
been cut or not. This may work well, but perhaps your code can be
improved to not reset when only clocks have been stopped? Resetting
when not needed will only result in unnecessary overhead. I believe
the Runtime PM suspend/resume callbacks can be used for determining if
the power has been cut or not.

Please make a V2 on top of Rafael's power domain control code later
when 2.6.40-rc has been released.

Thanks!

/ magnus
