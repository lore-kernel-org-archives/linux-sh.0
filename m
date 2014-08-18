From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 18 Aug 2014 22:34:59 +0000
Subject: Re: [PATCH v4] usb: hcd: add generic PHY support
Message-Id: <53F27F93.60202@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201407230217.56283.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201407230217.56283.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 07/23/2014 02:17 AM, Sergei Shtylyov wrote:

> Add the generic PHY support, analogous to the USB PHY support. Intended it to be
> used with the PCI EHCI/OHCI drivers and the xHCI platform driver.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

> ---
> This patch is against the 'usb-next' branch of Greg KH's 'usb.git' repo.

> The USB PHY driver patch with which this patch is intended to be used, has been
> just posted, along with the platform PHY device tree patches; the patches that
> link the PCI EHCI/OHCI  devices to the PHY device will follow shortly.

    Greg, may I ask what elase are you waiting for with this patch. I don't 
see it in 3.17-rc1 and nobody has commented on this version. I've posted to 
linux-usb all my patches that need this one, and there are patch series from 
other people now depending on this patch...

WBR, Sergei

