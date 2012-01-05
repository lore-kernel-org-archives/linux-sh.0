From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Jan 2012 05:31:58 +0000
Subject: Re: [PATCH 1/2] usb: renesas_usbhs: add IRQ resource decoding for IRQF_SHARED
Message-Id: <87vcoqiuk7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F05318D.6070505@renesas.com>
In-Reply-To: <4F05318D.6070505@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Shimoda-san

Thank you for your patch.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/usb/renesas_usbhs/common.c |   11 ++++++-----
>  drivers/usb/renesas_usbhs/common.h |    1 +
>  drivers/usb/renesas_usbhs/mod.c    |    2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)

Can you please add the reason why this IRQF_SHARED is needed on renesas_usbhs ?

Best regards
---
Kuninori Morimoto
