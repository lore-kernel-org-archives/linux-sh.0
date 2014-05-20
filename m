From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 20 May 2014 09:34:52 +0000
Subject: Re: [PATCH 2/3] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <537B21BC.7040701@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5379D805.3070002@renesas.com> <CANqRtoQ7k8auQzrE-YA=W+9_eOZ1iT20=RKoqQxOqyofD+Jk=g@mail.gmail.com>
In-Reply-To: <CANqRtoQ7k8auQzrE-YA=W+9_eOZ1iT20=RKoqQxOqyofD+Jk=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Magnus-san,

(2014/05/19 19:21), Magnus Damm wrote:
> Hi Shimoda-san,
> 
> Thanks for your patches, I did however find one typo below:
> 
> On Mon, May 19, 2014 at 7:08 PM, Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
< snip >
>>  static int xhci_plat_start(struct usb_hcd *hcd)
>>  {
>> +       struct device_node *of_node = hcd->self.controller->of_node;
>> +
>> +       if (of_device_is_compatible(of_node, "renesas,r8a7790-xhci") ||
>> +           of_device_is_compatible(of_node, "renesas,r8a7790-xhci"))
>> +               xhci_rcar_start(hcd);
>> +
> 
> This is most likely a typo - I believe this is supposed to be r8a7790
> and r8a7791?

Thank you for the review! Yes, this is a typo... I will correct this.

Best regards,
Yoshihiro Shimoda

> Cheers,
> 
> / magnus
> 

-- 
Yoshihiro Shimoda
EC No.
