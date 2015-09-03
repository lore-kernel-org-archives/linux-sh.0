From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 03 Sep 2015 00:25:56 +0000
Subject: Re: [PATCH 0/9] sh-pfc: modify PINMUX_IPSR_MSEL() and r8a7795 support
Message-Id: <23650612.PHpdfx055U@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87wpw9jn3i.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wpw9jn3i.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Morimoto-san,

Thank you for the patches.

On Wednesday 02 September 2015 07:33:21 Kuninori Morimoto wrote:
> Hi LinusW, Laurent
> 
> These are new version of r8a7795 PFC support.
> This time it includes PINMUX_IPSR_MSEL() modify patch too.
> 
> r8a7795 needs 1) 8) 9)
> 2) - 7) are cleanup patches, but not related to r8a7795

For patches 1-7 and patch 9,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> This time r8a7795 PFC driver is using many macros.
> I took precedence "readable code" more than "80 character".
> These macro are same as "datasheet" style. So, I believe review is easy.
> 
> Kuninori Morimoto (9):
>       1) sh-pfc: modify PINMUX_IPSR_MSEL() macro order
>       2) sh-pfc: pfc-sh7734: use PINMUX_IPSR_MSEL()
>       3) sh-pfc: pfc-r8a7794: use PINMUX_IPSR_MSEL()
>       4) sh-pfc: pfc-r8a7791: use PINMUX_IPSR_MSEL()
>       5) sh-pfc: pfc-r8a7790: use PINMUX_IPSR_MSEL()
>       6) sh-pfc: pfc-r8a7779: use PINMUX_IPSR_MSEL()
>       7) sh-pfc: remove unused PINMUX_IPSR_MODSEL_DATA()
>       8) sh-pfc: Initial R8A7795 PFC support
>       9) sh-pfc: r8a7795: add SCIFx support

-- 
Regards,

Laurent Pinchart

