From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 29 May 2014 17:17:42 +0000
Subject: Re: [PATCH v3 1/2] usb: host: xhci-plat: add optional PHY support
Message-Id: <53876BB6.3040304@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53868E18.7090805@renesas.com>
In-Reply-To: <53868E18.7090805@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "mathias.nyman@intel.com" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hello.

On 05/29/2014 05:32 AM, Yoshihiro Shimoda wrote:

> From: Gregory CLEMENT <gregory.clement@free-electrons.com>

> This commit extends the xhci-plat so that it can optionally be passed
> a reference to a PHY through the Device Tree. It will be useful for
> the Armada 375 SoCs. If no PHY is provided then the behavior of the
> driver is unchanged.

> As for the clock, to achieve this, it adds a 'struct phy *' member in
> xhci_hcd. While only used for now in xhci-plat, here again, it might
> be used by other drivers in the future.

> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>   drivers/usb/host/xhci-plat.c |   27 ++++++++++++++++++++++++++-
>   drivers/usb/host/xhci.h      |    2 ++
>   2 files changed, 28 insertions(+), 1 deletion(-)

    I've already posted a patch adding generic PHY support to all USB HCDs 
about 1.5 months ago, which should make this patch unneeded.

WBR, Sergei

