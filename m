From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 26 Jun 2014 00:18:19 +0000
Subject: Re: [PATCH v6 1/1] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <53AB66CB.7010401@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <539AEC8F.4030003@renesas.com>	<20140613142525.GE8319@saruman.home> <CANqRtoRy=mzosq4F-PF9_HRWK8pV66TmV1u-0cSLELAGtkfbsg@mail.gmail.com>
In-Reply-To: <CANqRtoRy=mzosq4F-PF9_HRWK8pV66TmV1u-0cSLELAGtkfbsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, Felipe Balbi <balbi@ti.com>
Cc: "mathias.nyman@intel.com" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Felipe,

(2014/06/18 14:15), Magnus Damm wrote:
> Hi Felipe,
> 
> On Fri, Jun 13, 2014 at 11:25 PM, Felipe Balbi <balbi@ti.com> wrote:
>> Hi,
>>
>> On Fri, Jun 13, 2014 at 09:20:31PM +0900, Yoshihiro Shimoda wrote:
< snip >
>>> +/* This function needs to initialize a "phy" of usb before */
>>
>> initializing a PHY looks like something that the PHY layer should do.
>> Why don't you write a PHY driver and teach xhci-core about PHYs ? Then,
>> more people would benefit.
> 
> Could you please clarify what you would like Shimoda-san to do?
>
> Like Ben and Shimoda-san mentioned, there is already a PHY driver
> developed for this SoC. The PHY driver is however shared in various
> ways. For example, on one particular SoC the same PHY driver is
> interfacing to a total of 3 different variants of USB controllers
> where XHCI is one of them. And to make things even more complicated,
> depending on SoC variant the XHCI hardware may or may not be available
> - but the PHY portion is more or less the same.
> 
> Putting the firmware loader in the XHCI driver like this at least
> keeps it together with the rest of the XHCI stuff and also makes it
> possible to easily access the XHCI I/O register window for firmware
> loading. Moving the firmware loading to the PHY driver however
> complicates the situation when it comes to Kconfig handling of XHCI
> and PHY driver and also forces the PHY driver to access the XHCI
> hardware I/O registers for firmware loading...

Do you have any comment about Magnus's comment?

Best regards,
Yoshihiro Shimoda

> Cheers,
> 
> / magnus
> 
