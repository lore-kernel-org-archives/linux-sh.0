From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 08 Apr 2014 21:30:50 +0000
Subject: Re: [PATCH] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <53446A8A.5050001@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404090102.03074.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201404090102.03074.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, kishon@ti.com
Cc: linux-sh@vger.kernel.org, magnus.damm@gmail.com, linux-doc@vger.kernel.org, rdunlap@infradead.org, grant.likely@linaro.org

Hello.

On 04/09/2014 01:02 AM, Sergei Shtylyov wrote:

> This PHY, though formally being a part of Renesas USBHS controller, contains the
> UGCTRL2 register that controls multiplexing of the USB ports (Renesas calls them
> channels) to the different USB controllers: channel 0 can be connected to either
> PCI EHCI/OHCI or USBHS controllers, channel 2 can be connected to PCI EHCI/OHCI
> or xHCI controllers.

> This is a new driver for this USB PHY currently already supported under drivers/
> usb/phy/. The reason for writing the new driver was the requirement that the
> multiplexing of USB channels to the controller be dynamic, depending on what
> USB drivers are loaded,  rather than static as provided by the old driver.	
> The infrastructure provided by drivers/phy/phy-core.c seems to fit that purpose
> ideally. The new driver only supports device tree probing for now.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

    Oops, I forgot to rebase it against Kishon's linux-phy.git repo's next 
branch. I will re-send shortly.

WBR, Sergei

