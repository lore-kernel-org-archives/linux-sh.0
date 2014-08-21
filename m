From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 21 Aug 2014 13:07:44 +0000
Subject: Re: [PATCH v3] usb: hcd: add generic PHY support
Message-Id: <53F5EF20.3090805@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <538891DC.605@renesas.com>
In-Reply-To: <538891DC.605@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 08/21/2014 04:44 PM, Vivek Gautam wrote:

>>>   From Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>>     Should be "From:".

>>> Add the generic PHY support, analogous to the USB PHY support. Intended it
>>> to be
>>> used with the PCI EHCI/OHCI drivers and the xHCI platform driver.

>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>> ---
>>> This patch is against the 'usb-next' branch of Greg KH's 'usb.git' repo.
>>> (commit id = 70d2f61fc7559df3d5be32a9d01efdb9ee1b11d8)

>>     I was pondering on reposting this patch, along with the R8A779x device
>> tree changes using it as Greg KH requested to see the users of this patch...

> Are we planning a repost of this patch,

    Yes, I'm planning this since Greg has lost v4.

WBR, Sergei

