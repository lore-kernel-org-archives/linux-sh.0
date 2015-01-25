From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 25 Jan 2015 16:05:50 +0000
Subject: Re: [PATCH v3] sh-pfc: Add emev2 pinmux support
Message-Id: <2863690.d7fDhTIo9u@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1564701.sT8vso17XV@avalon> <1422193792-15970-1-git-send-email-niso@kth.se>
In-Reply-To: <1422193792-15970-1-git-send-email-niso@kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niso@kth.se>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com

Hi Niklas,

Thank you for the patch.

On Sunday 25 January 2015 14:49:52 Niklas S=F6derlund wrote:
> Add PFC support for the EMMA Mobile EV2 SoC including pin groups for
> on-chip devices.
>=20
> Signed-off-by: Niklas S=F6derlund <niso@kth.se>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    1 +
>  drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
>  drivers/pinctrl/sh-pfc/Makefile                    |    1 +
>  drivers/pinctrl/sh-pfc/core.c                      |    9 +
>  drivers/pinctrl/sh-pfc/core.h                      |    1 +
>  drivers/pinctrl/sh-pfc/pfc-emev2.c                 | 1711 ++++++++++++++=
+++
>  6 files changed, 1728 insertions(+)
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-emev2.c

--=20
Regards,

Laurent Pinchart

