From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 20 Aug 2009 23:44:04 +0000
Subject: Re: [PATCH] usb: add support R8A66597 peripheral controller driver
Message-Id: <20090820234404.GB31542@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4A8B86BB.1020605@renesas.com>
In-Reply-To: <4A8B86BB.1020605@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 20, 2009 at 04:01:06PM +0900, Yoshihiro Shimoda wrote:
> Subject: [PATCH] usb: r8a66597-udc: implement the set_wedge method
> 
> fix the problem that MSC Tests of USBCV detects some warnings.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> ---
>  drivers/usb/gadget/r8a66597-udc.c |   28 ++++++++++++++++++++++++++--
>  drivers/usb/gadget/r8a66597-udc.h |    1 +
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
Applied, thanks.
