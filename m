From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 05 Aug 2014 00:11:16 +0000
Subject: Re: [PATCH v2 0/2] usb: renesas_usbhs: Add device tree support for R-Car H2 and M2
Message-Id: <8738dbpzhf.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53DF64C8.4050906@renesas.com>
In-Reply-To: <53DF64C8.4050906-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>


Hi

> This driver supports other SoCs, but they need boards/Soc depend code.
> So, this patch adds device tree support for R-Car H2 and M2 initially.
> 
> Changes from v1:
>  - Change an optional property name from "buswait_bwait" to "buswait" in
>    patch 1.
>  - Add the prefix "renesas," to "buswait" and "enable-gpio" in patch 1.
>  - Modify the usbhs_parse_dt() to remove the check of some
>    of_device_is_compatible() in patch 2.
> 
> Yoshihiro Shimoda (2):
>   usb: renesas_usbhs: Add device tree bindings documentation
>   usb: renesas_usbhs: Add device tree support for R-Car H2 and M2
> 
>  .../devicetree/bindings/usb/renesas_usbhs.txt      |   24 +++++++++++
>  drivers/usb/renesas_usbhs/common.c                 |   44 ++++++++++++++++++++
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/renesas_usbhs.txt

For all patches

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
