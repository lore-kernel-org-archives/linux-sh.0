From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 29 May 2014 01:24:26 +0000
Subject: Re: [PATCH v2 2/3] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <53868C4A.5070003@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5385C71D.5060509@renesas.com> <20140528202849.GA14248@kroah.com>
In-Reply-To: <20140528202849.GA14248-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: "mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi,

(2014/05/29 5:28), Greg Kroah-Hartman wrote:
> On Wed, May 28, 2014 at 08:23:09PM +0900, Yoshihiro Shimoda wrote:
>> The R-Car H2 and M2 SoCs come with an xHCI controller that requires
>> some specific initializations related to the firmware downloading and
>> some specific registers. This patch adds the support for this special
>> configuration as an xHCI quirk executed during probe and start.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>  drivers/usb/host/Kconfig     |    8 +++
>>  drivers/usb/host/Makefile    |    3 +
>>  drivers/usb/host/xhci-plat.c |   18 +++++
>>  drivers/usb/host/xhci-rcar.c |  160 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/usb/host/xhci-rcar.h |   27 +++++++
>>  5 files changed, 216 insertions(+)
>>  create mode 100644 drivers/usb/host/xhci-rcar.c
>>  create mode 100644 drivers/usb/host/xhci-rcar.h
> 
> This doesn't apply cleanly to my tree, can you please refresh it and
> resend?

Sure. Actually, this patch depends on the folloing additional patch:
http://marc.info/?l=linux-usb&m0025742005303&w=2

And, the additional patch needs to fix some things.
So, I will fix it and submit these patches.

Best regards,
Yoshihiro Shimoda

> thanks,
> 
> greg k-h
> 

-- 
Yoshihiro Shimoda
EC No.
