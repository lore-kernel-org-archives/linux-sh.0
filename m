From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 06 Mar 2015 10:34:23 +0000
Subject: Re: [PATCH v3] sh-pfc: add R8A7794 PFC support
Message-Id: <CACRpkdbjhyhci_O8ecCTM3du+k8NRTyw026mie5OTorXJO1P+Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2084538.pWCX8EzoLe@wasted.cogentembedded.com>
In-Reply-To: <2084538.pWCX8EzoLe@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Sun, Feb 22, 2015 at 10:33 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:

> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>
> Add PFC support for  the  R8A7794 SoC  including pin groups for some on-chip
> devices such as ETH, I2C, INTC, MSIOF, QSPI, [H]SCIF...
>
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> [Sergei: squashed together several patches, fixed the MLB_CLK typo, added IRQ4..
> IRQ9 pin groups,  fixed IRQn comments, added ETH B pin group names, removed
> stray new line and fixed typos in the  comments in the pinmux_config_regs[]
> initializer, removed the platform device ID, took into account limited number of
> signals in the GPIO1/5/6 controllers, added reasonable and removed unreasonable
> copyrights, modified the bindings document, renamed, added changelog.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> Changes in version 3:

This v3 applied with Laurent's ACK.

Yours,
Linus Walleij
