From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 06 Jun 2008 05:44:07 +0000
Subject: Re: [PATCH] usb: r8a66597-hcd: Add support for SH7723 USB host
Message-Id: <20080606054407.GB29591@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4847DA2C.3040606@renesas.com>
In-Reply-To: <4847DA2C.3040606@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 05, 2008 at 09:21:00PM +0900, Yoshihiro Shimoda wrote:
> R8A66597 is similar to SH7723 USB 2.0 Host/Function module.
> In addition, the USB of SH7366 is compatible with SH7723.
> It can support SH7723 USB host by changing Kconfig.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

Greg, if you don't have any issues with this I'll just take it in my tree
with the platform patch.
