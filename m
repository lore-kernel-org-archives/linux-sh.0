From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 21 Jun 2011 08:46:50 +0000
Subject: Re: [PATCH] sh: fix compile error using sh7757lcr_defconfig
Message-Id: <20110621084649.GF7920@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4E00504D.90901@renesas.com>
In-Reply-To: <4E00504D.90901@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 21, 2011 at 05:03:25PM +0900, Yoshihiro Shimoda wrote:
> Fix the complie error in ehci-hcd.c because it needs an additional
> configuration.
> 
>   CC      drivers/usb/host/ehci-hcd.o
> drivers/usb/host/ehci-hcd.c:1288:2: error: #error "missing bus glue for ehci-hcd"
> make[3]: *** [drivers/usb/host/ehci-hcd.o] Error 1
> make[2]: *** [drivers/usb/host] Error 2
> make[1]: *** [drivers/usb] Error 2
> make: *** [drivers] Error 2
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On Tue, Jun 21, 2011 at 05:28:27PM +0900, Yoshihiro Shimoda wrote:
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   50 ++++++++++++++++++++++++++++++++
>  1 files changed, 50 insertions(+), 0 deletions(-)
> 

Both applied, thanks.
