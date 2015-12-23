From: Rob Herring <robh@kernel.org>
Date: Wed, 23 Dec 2015 00:47:46 +0000
Subject: Re: [PATCH v3] usb: gadget: renesas_usb3: add support for Renesas USB3.0 peripheral controller
Message-Id: <20151223004746.GA27730@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1450690804-3672-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1450690804-3672-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Dec 21, 2015 at 06:40:04PM +0900, Yoshihiro Shimoda wrote:
> R-Car H3 has USB3.0 peripheral controllers. This controller's has the
> following features:
>  - Supports super, high and full speed
>  - Contains 30 pipes for bulk or interrupt transfer
>  - Contains dedicated DMA controller
> 
> This driver doesn't support the dedicated DMAC for now.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  This patch is based on the latest Felipe's usb.git / testing/next branch.
>  (commit id = e9284de9fae69f1d5e57a4817bfc36dc5f3adf71)
> 
>  Changes from v2:
>   - Fix compatible string order to "<chip>-<peripheral>".
> 
>  Changes from v1:
>   - fix build error in i386 environment if COMPILE_TEST=y
>   - merge the header file code into the .c file
>   - revise the device tree document about "clocks"
>   - remove prototype declarations
>   - use udelay(1) instead of ndelay(1) in usb3_wait()
>   - remove empty function "usb3_init_phy()"
>   - use module_platform_driver()
>   - remove bit fields member in some structures
> 
> 
>  .../devicetree/bindings/usb/renesas_usb3.txt       |   23 +

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

