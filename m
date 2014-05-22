From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 May 2014 09:19:33 +0000
Subject: Re: [PATCH 03/03] staging: board: kzm9d: Board staging support for emxx_udc
Message-Id: <CAMuHMdWyCN7UJ89xjpAj-X7rTHo_r0U6XJJwMOxGnXAeeYZXHQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140522085339.26279.83340.sendpatchset@w520>
	<20140522085409.26279.64965.sendpatchset@w520>
In-Reply-To: <20140522085409.26279.64965.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, Linux-sh list <linux-sh@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Olof Johansson <olof@lixom.net>

Hi Magnus,

On Thu, May 22, 2014 at 10:54 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Add staging board support for the KZM9D board and add
> an emxx_udc platform device to allow in-tree continous
> development of the driver on the KZM9D board.
>
> When DT bindings are ready for the emxx_udc driver then
> the platform device in the KZM9D staging board code can
> easily be removed. Until then we use platform devices
> to continously improve the driver and integration code.

Nice!

>  drivers/staging/Kconfig        |    2 ++
>  drivers/staging/Makefile       |    1 +
>  drivers/staging/board/Kconfig  |    7 +++++++
>  drivers/staging/board/Makefile |    1 +
>  drivers/staging/board/board.h  |   17 +++++++++++++++++
>  drivers/staging/board/kzm9d.c  |   18 ++++++++++++++++++
>  6 files changed, 46 insertions(+)

As you're adding infrastructure and a first user, I think this should
be split in two patches:
  - Introduction of drivers/staging/board infrastructure,
  - Addition of kzm9d board support.

> --- /dev/null
> +++ work/drivers/staging/board/Kconfig  2014-05-22 15:31:58.000000000 +0900
> @@ -0,0 +1,7 @@
> +config STAGING_BOARD
> +       boolean "Staging Board Support"
> +       help
> +         Select to enable per-board staging support code.
> +
> +         If in doubt, say N here.
> +

No board-specific Kconfig symbols, so the actual individual board
support itself is
always compiled-in (but see below)?

> --- /dev/null
> +++ work/drivers/staging/board/Makefile 2014-05-22 15:31:58.000000000 +0900
> @@ -0,0 +1 @@
> +obj-$(CONFIG_ARCH_SHMOBILE_MULTI)      += kzm9d.o

Ah, it's included in all shmobile multi-platform kernels.

What about testing for CONFIG_ARCH_EMEV2 instead of
CONFIG_ARCH_SHMOBILE_MULTI?
Or adding a KZM9D-specific Kconfig symbol to .../board/Kconfig?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
