From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 26 Aug 2014 09:33:12 +0000
Subject: Re: [RESEND PATCH V2] devicetree: Dialog Semiconductor consolidate existing vendor prefixes to stand
Message-Id: <20140826093312.GI9574@lee--X1>
List-Id: <linux-sh.vger.kernel.org>
References: <201408221446.s7MEkNVF001775@swsrvapps-01.diasemi.com>
In-Reply-To: <201408221446.s7MEkNVF001775@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, 22 Aug 2014, Opensource [Steve Twiss] wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> This patch series updates the device tree vendor prefix for
> Dialog Semiconductor.
>=20
> Various methods are currently used throughout the kernel: 'diasemi',
> 'dialog' and 'dlg'. Others have also been suggested.
>=20
> This patch set aims to consolidate the usage of the vendor prefix to
> use a common standard. The prefix 'dlg' is used.
>=20
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Shawn Guo <shawn.guo@freescale.com>
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ---

[...]

> Hi Lee,
>=20
> This is a resend according to requests for e-mail reformatting and removal
> of '[]' in From: and Signed-off-by: tags. There are no patch alterations
> from RFC V2.
>=20
> I have got the Ack for the two remaining files r8a7790-lager.dts and
> r8a7791-koelsch.dts because of the previous request for SHMobile to Ack
> their part of the patch.
> - http://www.spinics.net/lists/arm-kernel/msg349289.html
> - https://lkml.org/lkml/2014/6/11/273
>=20
> I think this is it. But, if I am missing anything or there are problems, =
can
> I get a quick explanation in the reply so I can fix it and move forwards
> please?
>=20
> In full:
> Acked-by the following people so far:

When you say "so far", does that mean you're missing Acks still?

If you have the full-set I will apply this and send out the necessary
pull-request(s).

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
