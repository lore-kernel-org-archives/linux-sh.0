From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 23 May 2014 23:32:21 +0000
Subject: Re: [PATCH v2] usb: hcd: add generic PHY support
Message-Id: <537FDA85.3090803@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404100132.39469.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201404100132.39469.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/10/2014 01:32 AM, Sergei Shtylyov wrote:

> Add the generic PHY support, analogous to the USB PHY support. Intended it to be
> used with the PCI EHCI/OHCI drivers and the xHCI platform driver.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
> This patch is against the 'usb-next' branch of Greg KH's 'usb.git' repo.

> Changes in version 2:
> - renamed the new 'phy' field of 'struct usb_phy' to 'gen_phy';
> - resolved rejects due to removal of the first patch in the series.

    Is anyone going to apply this for 3.16? Time's running out...

WBR, Sergei

