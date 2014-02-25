From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 25 Feb 2014 08:09:55 +0000
Subject: Re: [PATCH V5 0/4] ARM: shmobile: koelsch: Add USB support
Message-Id: <CANqRtoSPpwzHjcVS0_fgT9_gf-dSFWfmf=yXs3roVVAoV6J4vw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393234204-24096-1-git-send-email-vladimir.barinov@cogentembedded.com>
In-Reply-To: <1393234204-24096-1-git-send-email-vladimir.barinov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio <linux-gpio@vger.kernel.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Alexandre Courbot <gnurou@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Valentine Barshak <valentine.barshak@cogentembedded.com>

On Mon, Feb 24, 2014 at 6:30 PM,  <vladimir.barinov@cogentembedded.com> wrote:
> From: Valentine Barshak <valentine.barshak@cogentembedded.com>
>
> These patch series add the USBHS and PCI USB support to Koelsch board
>
> Changes in V5:
> * changed "From" filed to original author
> * removed commits dependency, since verified them are in
> * get rid from PCI USB on usb0
> * moved MAX3355E ID pin check in usbhs probe
> * removed CONFIG_USB_RENESAS_USBHS_HCD as not used yet

This version of the series looks good to me.

Acked-by: Magnus Damm <damm@opensource.se>

Thanks.

/ magnus
