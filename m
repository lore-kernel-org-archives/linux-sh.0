From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niso@kth.se>
Date: Fri, 09 Jan 2015 10:22:06 +0000
Subject: Re: [PATCH 0/4] sh-pfc: Add emev2 pinmux support
Message-Id: <20150109102206.GB30143@bigcity.berto.se>
List-Id: <linux-sh.vger.kernel.org>
References: <1418414497-23741-1-git-send-email-niso@kth.se>
In-Reply-To: <1418414497-23741-1-git-send-email-niso-UNjuZkX4dYU@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

Hi Linus and Laurent,

I know we are coming out of the holiday season so here is a humble ping
on this patchset.

* Niklas S=F6derlund <niso@kth.se> [2014-12-12 21:01:33 +0100]:

> Greetings,
>
> This patchset introduces pinmux support for the EMMA Mobile EV2 board to
> the sh-pfc pin-controller driver. Devicetree bindings for gpio and the
> populated serial connector are also defined in 3/4 and 4/4.
>
> Comments are welcome!
>
> Regards
> // Niklas
>
> Niklas S=F6derlund (4):
>   sh-pfc: add macro to define pinmux without function
>   sh-pfc: Add emev2 pinmux support
>   ARM: shmobile: emev2: Add PFC information to emev2.dtsi
>   ARM: shmobile: emev2-kzm9d: Add PFC information for uart1
>
>  .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    1 +
>  arch/arm/boot/dts/emev2-kzm9d.dts                  |   13 +
>  arch/arm/boot/dts/emev2.dtsi                       |   11 +
>  drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
>  drivers/pinctrl/sh-pfc/Makefile                    |    1 +
>  drivers/pinctrl/sh-pfc/core.c                      |    9 +
>  drivers/pinctrl/sh-pfc/core.h                      |    1 +
>  drivers/pinctrl/sh-pfc/pfc-emev2.c                 | 1915 ++++++++++++++=
++++++
>  drivers/pinctrl/sh-pfc/sh_pfc.h                    |    2 +
>  9 files changed, 1958 insertions(+)
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-emev2.c
>
> --
> 2.1.3
>
