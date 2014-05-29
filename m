From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 29 May 2014 01:24:04 +0000
Subject: Re: [PATCH v2 2/3] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <53868C34.9000309@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5385C71D.5060509@renesas.com> <20140528202607.GA7537@kroah.com>
In-Reply-To: <20140528202607.GA7537@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "mathias.nyman@intel.com" <mathias.nyman@intel.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi,

(2014/05/29 5:26), Greg Kroah-Hartman wrote:
> On Wed, May 28, 2014 at 08:23:09PM +0900, Yoshihiro Shimoda wrote:
< snip >
>> +#define FIRMWARE_NAME		"r8a779x_usb3_v1.dlmem"
> 
> Shouldn't you also add a:
> 	MODULE_FIRMWARE(FIRMWARE_NAME);
> line to this file so that the automatic tools can pick it up properly?

Thank you for the point! I will add it.

Best regards,
Yoshihiro Shimoda

> thanks,
> 
> greg k-h
> 

-- 
Yoshihiro Shimoda
EC No.
