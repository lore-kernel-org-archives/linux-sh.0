From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 25 Feb 2011 03:19:01 +0000
Subject: Re: [PATCH] usb: add EHCI and OHCI support for SH7757
Message-Id: <20110225031901.GA3847@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4D660C04.9070800@renesas.com>
In-Reply-To: <4D660C04.9070800@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 24, 2011 at 06:47:10PM +0900, Yoshihiro Shimoda wrote:
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  about v2:
>   - fix the condition for other CPU in ehci-hcd.c.
> 
And how exactly are you enabling this when the 7757 Kconfig entry doesn't
select either of USB_ARCH_HAS_OHCI or USB_ARCH_HAS_EHCI?
