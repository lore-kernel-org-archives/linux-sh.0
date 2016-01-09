From: Rob Herring <robh@kernel.org>
Date: Sat, 09 Jan 2016 22:33:07 +0000
Subject: Re: [PATCH] phy: rcar-gen3-usb2: remove HSUSB registers handling
Message-Id: <20160109223307.GA14530@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1452158204-5236-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1452158204-5236-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: kishon@ti.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, Jan 07, 2016 at 06:16:44PM +0900, Yoshihiro Shimoda wrote:
> Since the related driver (CPG/MSSR driver) only manages the first module
> clock, this driver should not handle the HSUSB registers. So, this patch
> removes the HSUSB registers handling.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  This patch is based on the linux-phy / next branch.
>  (commit id = 9955a7835bf376e12482583958b2661f501b868b)
> 
>  .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 15 ++--

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/phy/phy-rcar-gen3-usb2.c                   | 83 +++-------------------
>  2 files changed, 15 insertions(+), 83 deletions(-)


