From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 24 Feb 2014 09:56:18 +0000
Subject: Re: [PATCH v2] pinctrl: sh-pfc: r8a7790: Add QSPI pin groups
Message-Id: <CACRpkdbT3SX1J6zs0HhPVnjjRXeB8Um0nHsV4UgD_Qakkw=Jxw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392037257-20607-1-git-send-email-geert+renesas@linux-m68k.org>
In-Reply-To: <1392037257-20607-1-git-send-email-geert+renesas@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Feb 10, 2014 at 2:00 PM, Geert Uytterhoeven
<geert+renesas@linux-m68k.org> wrote:

> A QSPI function set consists of 3 groups:
>   - qspi_ctrl (2 control wires)
>   - qspi_data2 (2 data wires, for Single/Dual SPI)
>   - qspi_data4 (4 data wires, for Quad SPI)
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v2: Insert line at correct position in pinmux_functions[]

Patch applied, sorry for the delay.

Yours,
Linus Walleij
