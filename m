From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 27 May 2014 21:53:02 +0000
Subject: Re: [PATCH v2] usb: hcd: add generic PHY support
Message-Id: <5385093E.3060503@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404100132.39469.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201404100132.39469.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 05/28/2014 01:13 AM, Greg KH wrote:

>>> Add the generic PHY support, analogous to the USB PHY support. Intended it to be
>>> used with the PCI EHCI/OHCI drivers and the xHCI platform driver.

>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>>> ---
>>> This patch is against the 'usb-next' branch of Greg KH's 'usb.git' repo.

>>> Changes in version 2:
>>> - renamed the new 'phy' field of 'struct usb_phy' to 'gen_phy';
>>> - resolved rejects due to removal of the first patch in the series.

>>     Is anyone going to apply this for 3.16? Time's running out...

> As I don't see any patches that need this patch, I'm not likely to apply
> it, sorry.  We don't add infrastructure without users...

> Feel free to resend it when you have some code that needs it.

    I certainly have the code that needs this to work but it's rather DTS 
files than the actual code, so I didn't CC linux-usb. :-)
    Unless you want to see the generic PHY driver, of course. I can CC 
linux-usb next time I repost it; however, this patch relies on the generic PHY 
framework itself rather than on a particular driver.

> thanks,

> greg k-h

WBR, Sergei

