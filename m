From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 29 Oct 2013 22:23:15 +0000
Subject: Re: [PATCH 08/19] mmc: sdhi: Enable the driver on all ARM platforms
Message-Id: <2104528.1psQi38nVt@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <172884142.S8DiPq9kQF@avalon> <52701EE8.4040302@cogentembedded.com>
In-Reply-To: <52701EE8.4040302@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Sergei,

On Tuesday 29 October 2013 23:47:36 Sergei Shtylyov wrote:
> On 10/29/2013 04:15 PM, Laurent Pinchart wrote:
> >>>>> Renesas ARM platforms are transitioning from single-platform to
> >>>>> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> >>>>> driver available on all ARM platforms to enable it on both
> >>>>> ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI and increase build testing
> >>>>> coverage.
> >>>>>=20
> >>>>> Cc: Chris Ball <cjb@laptop.org>
> >>>>> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> >>>>> Cc: Ian Molton <ian@mnementh.co.uk>
> >>>>> Cc: linux-mmc@vger.kernel.org
> >>>>> Signed-off-by: Laurent Pinchart
> >>>>> <laurent.pinchart+renesas@ideasonboard.com>
> >>=20
> >> [...]
> >>=20
> >>>>> diff --git a/drivers/mmc/host/tmio_mmc_dma.c
> >>>>> b/drivers/mmc/host/tmio_mmc_dma.c index 65edb4a..535bc35 100644
> >>>>> --- a/drivers/mmc/host/tmio_mmc_dma.c
> >>>>> +++ b/drivers/mmc/host/tmio_mmc_dma.c
> >>>>> @@ -28,7 +28,7 @@ void tmio_mmc_enable_dma(struct tmio_mmc_host *ho=
st,
> >>>>> bool enable)>
> >>>>>=20
> >>>>>    	if (!host->chan_tx || !host->chan_rx)
> >>>>>    =09
> >>>>>    		return;
> >>>>>=20
> >>>>> -#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
> >>>>> +#if defined(CONFIG_SUPERH) || defined(CONFIG_ARM)
> >>>>=20
> >>>> I'm not sure about this one. In principle DMA so far is only used on
> >>>> SDHI with TMIO. But this #if was for a theoretical case, when a TMIO
> >>>> MMC IP inside an MFD is also used with DMA. Bus since I had no
> >>>> indormation about whether the CTL_DMA_ENABLE register was SDHI speci=
fic
> >>>> or not, I put it under an #if for the time being. In any case, I don=
't
> >>>> think making it #ifdef CONFIG_ARM makes much sense. We can either
> >>>> remove the #if completely, or keep it to limit the scope of this wri=
te
> >>>> to sh-mobile arches.
> >>>=20
> >>> SUPERH || ARCH_SHMOBILE covers all the platforms this driver currently
> >>> builds on. Now that we're adding ARCH_SHMOBILE_MULTI the #if needs to
> >>> cover that case as well. I'm fine with limiting the CTL_DMA_ENABLE wr=
ite
> >>> to SUPERH only (which would modify the driver's behaviour)
> >>=20
> >> I'm afraid that would break the driver's ability to work in DMA mode on
> >> SH-Mobile SoCs.
> >=20
> > So can you confirm that writing the CTL_DMA_ENABLE register is required=
 on
> > all Renesas ARM SoCs (including SH-Mobile, R-Mobile and R-Car) ?
>=20
> I can't actually say anything about all SH-Mobile and R-Mobile SoCs, only
> about the R-Car SoCs: though the datasheets don't contain the SDHI regist=
er
> info, from my experience the register exists on R8A777x (I had to fix up =
the
> broken PIO fallback in the SDHI driver).

OK.

> >>> or enabling it unconditionally, but I don't think adding a
> >>> defined(CONFIG_ARCH_SHMOBILE_MULTI) to the above #if makes sense, unl=
ess
> >>> there's a plan to add support for DMA for non-SH (including both SUPE=
RH
> >>> and ARCH_SHMOBILE) platforms.
> >>=20
> >> Not only the plan -- I have already posted the patches to do it for
> >> R8A777x, and Simon has queued them for 3.13.
> >=20
> > Could you please point me to those patches ?
>=20
> https://git.kernel.org/cgit/linux/kernel/git/horms/renesas.git/commit/?h=
=3Dnex
> t&id=1Eb6b5a0e55bfcfb0852b7d0f9442841ff807345
> https://git.kernel.org/cgit/linux/kernel/git/horms/renesas.git/commit/?h=
=3Dne
> xt&id=A43e5bd76a4a3df58167d85e8020a1c9e566ad75
> https://git.kernel.org/cgit/linux/kernel/git/horms/renesas.git/commit/?h=
=3Dne
> xt&id]6aa3435275a5308684f90c17424b055ef7f572
> https://git.kernel.org/cgit/linux/kernel/git/horms/renesas.git/commit/?h=
=3Dne
> xt&id=E6a8b11b82fdeaa78dad52552f945b772ee1a5c9

But that's still an ARCH_SHMOBILE platform. Guennadi's point, if I understo=
od=20
it correctly, was that whether the CTL_DMA_ENABLE register is part of the=20
standard TMIO controller, or is Renesas-specific, is unknown. As we have no=
=20
current or planned TMIO DMA users other than SUPERH and ARCH_SHMOBILE this =
is=20
impossible to test. That is why the code is conditionally compiled.

We could either get rid of the #if completely and always write to the=20
register, or add ARCH_SHMOBILE_MULTI to the condition. I now agree that add=
ing=20
ARM as a dependency makes no sense. Given that this will break on=20
multiplatform kernels anyway, I'm enclined to write to the CTL_DMA_ENABLE=20
register unconditionally. I'll update the patch accordingly.

--=20
Regards,

Laurent Pinchart

