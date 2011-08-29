From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 29 Aug 2011 08:23:29 +0000
Subject: Re: [PATCH 5/7] fbdev: sh_mipi_dsi: add extra dcs settings for platform
Message-Id: <CANqRtoTZLMySPK7zTkDJq8d8KGwBx1HnxQpux3UqN7ubMx4XPw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vctmt9t1.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vctmt9t1.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Aug 25, 2011 at 1:05 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> some platform needs extra MIPI dcs to use.
> this patch add support it.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> =A0drivers/video/sh_mipi_dsi.c | =A0 24 +++++++++++++++++++++++-
> =A0include/video/sh_mipi_dsi.h | =A0 13 +++++++++++++
> =A02 files changed, 36 insertions(+), 1 deletions(-)

[snip]

> --- a/include/video/sh_mipi_dsi.h
> +++ b/include/video/sh_mipi_dsi.h
> @@ -32,12 +32,25 @@ struct sh_mobile_lcdc_chan_cfg;
> =A0#define SH_MIPI_DSI_HFPBM =A0 =A0 =A0(1 << 2)
> =A0#define SH_MIPI_DSI_BL2E =A0 =A0 =A0 (1 << 3)
>
> +/*
> + * x000ccpp
> + *
> + * x : 1 use sh_mipi_dcs()
> + * =A0 =A0 0 use sh_mipi_dcs_param()
> + * cc : cmd
> + * pp : param
> + */
> +#define SH_MIPI_DCS(cmd) =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x10000000 | (cmd =
& 0xFF) << 8)
> +#define SH_MIPI_DCS_PARAM(cmd, param) =A0((cmd & 0xFF) << 8 | (param & 0=
xFF))
> +
> =A0struct sh_mipi_dsi_info {
> =A0 =A0 =A0 =A0enum sh_mipi_dsi_data_fmt =A0 =A0 =A0 data_format;
> =A0 =A0 =A0 =A0struct sh_mobile_lcdc_chan_cfg =A0*lcd_chan;
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags;
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 clksrc;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vsynw_=
offset;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 *extra_array;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 extra_array_len;
> =A0};
>
> =A0#endif

Hi Morimoto-san,

Thanks for adding support for MIPI-DSI on the Kota2 board. If I
understand correctly then this patch allows us to use board-specific
code to setup the MIPI-DSI panel. And this is needed on the Kota2
board.

I do however wonder if this array is the best approach to adding board
specific code. My personal take would be to use something like the SYS
bus support for the LCDC, see callbacks in struct
sh_mobile_lcdc_sys_bus_ops located in
include/video/sh_mobile_lcdc.h and board/panel code like
arch/sh/boards/mach-migor/lcd_qvga.c.

Also, if your board/panel specific code is dealing with backlight on
MIPI-DSI, perhaps there is a chance this is generic enough to be
broken out and reused somehow.

Maybe Paul and/or Guennadi has some ideas about this too.

Thanks,

/ magnus
