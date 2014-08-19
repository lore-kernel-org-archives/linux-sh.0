From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Tue, 19 Aug 2014 06:59:18 +0000
Subject: Re: [PATCH v5] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <53F2F2F6.8050908@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201407222327.15179.sergei.shtylyov@cogentembedded.com> <53F27D23.3040002@cogentembedded.com>
In-Reply-To: <53F27D23.3040002@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, grant.likely@linaro.org, devicetree@vger.kernel.org
Cc: rdunlap@infradead.org, linux-doc@vger.kernel.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org



On Tuesday 19 August 2014 03:54 AM, Sergei Shtylyov wrote:
> Hello.
> 
> On 07/22/2014 11:27 PM, Sergei Shtylyov wrote:
> 
>> This PHY, though formally being a part of Renesas USBHS controller, contains the
>> UGCTRL2 register that controls multiplexing of the USB ports (Renesas calls them
>> channels) to the different USB controllers: channel 0 can be connected to either
>> PCI EHCI/OHCI or USBHS controllers, channel 2 can be connected to PCI EHCI/OHCI
>> or xHCI controllers.
> 
>> This is a new driver for this USB PHY currently already supported under drivers/
>> usb/phy/. The reason for writing the new driver was the requirement that the
>> multiplexing  of USB channels to the controller be dynamic, depending on what
>> USB drivers  are loaded,  rather than static as provided by the old driver. The
>> infrastructure provided by drivers/phy/phy-core.c  seems to fit that purpose
>> ideally. The new driver only  supports device tree probing  for now.
> 
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
>> ---
>> The patch is against the 'next' branch of Kishon's 'linux-phy.git' repo.
> 
>    Kishon, may I ask what was the problem with this patch? I don't see it in
> 3.17-rc1 and you've never replied though nearly a month has passed...

It was too late to make it to 3.17.
Overall this patch looks much better. will take a closer look in a day.

Thanks
Kishon
> 
> WBR, Sergei
> 
