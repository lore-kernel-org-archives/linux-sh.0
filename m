From: Simon Horman <horms@verge.net.au>
Date: Thu, 18 Apr 2013 13:14:54 +0000
Subject: Re: [PATCH v2 6/6] ARM: shmobile: Armadillo800EVA: Reference DT implementation
Message-Id: <20130418131454.GB20929@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1366194847-9879-6-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1366194847-9879-6-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 17, 2013 at 12:34:06PM +0200, Bastian Hecht wrote:
> Provide alternate board code for the Armadillo800EVA to demonstrate how
> DT may be used given the current state of driver device tree support.
> This is intended to act as a reference for mach-shmobile developers.
> 
> This a rather bare bone version with the following devices supported:
> 
>  - GIC
>  - irqpins
>  - i2c0/1
>  - touchscreen
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
> v2:
> 
>  - Removed the GPIO request for IRQ10 (the mux defaults to right port)
>  - Added a TODO to the reset GPIO request. We can move that as soon as
>   we got the PFC in the device tree.
>  - Removed the .dtsi part that is now in 5/6
> 
>  arch/arm/boot/dts/Makefile                         |    1 +
>  .../boot/dts/r8a7740-armadillo800eva-reference.dts |   45 +++++
>  arch/arm/mach-shmobile/Kconfig                     |   14 ++
>  arch/arm/mach-shmobile/Makefile                    |    1 +
>  .../board-armadillo800eva-reference.c              |  213 ++++++++++++++++++++
>  5 files changed, 274 insertions(+)
>  create mode 100644 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
>  create mode 100644 arch/arm/mach-shmobile/board-armadillo800eva-reference.c

Thanks, queued-up for v3.11 in the boards-armadillo800eva branch.
