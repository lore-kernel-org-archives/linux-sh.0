From: Simon Horman <horms@verge.net.au>
Date: Thu, 18 Apr 2013 13:14:31 +0000
Subject: Re: [PATCH v2 5/6] ARM: shmobile: r8a7740: Prepare for reference DT setup
Message-Id: <20130418131429.GA20929@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1366194847-9879-5-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1366194847-9879-5-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 17, 2013 at 12:34:05PM +0200, Bastian Hecht wrote:
> We need three steps to prepare for the new Armadillo reference DT board code:
>  - Split the device list into r8a7740_early_devices used by the old platform
>    data setup (board-armadillo.c) and r8a7740_devices_dt used by both
>    setup variants.
>  - Introduce new r8a7740_init_delay() to be more flexible about calling
>    shmobile_setup_delay().
>  - For the generic r8a7740 support, we switch to device tree setup for
>    the GIC, the irqpin devices and the I2C controllers.
> 
> This is slightly similar to commit 3b00f9342623a5ebc
> "ARM: shmobile: sh73a0: Do not use early devices with DT reference"
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
> v2:
> 
>  - add device list r8a7740_devices_dt to r8a7740_add_early_devices() (fix)
>  - reworked code flow for the generic case (fix)
>  - added some devices to r8a7740.dtsi and switched to OF for generic case
>    (see commit message)
> 
>  arch/arm/boot/dts/r8a7740.dtsi                |  117 +++++++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/r8a7740.h |    2 +
>  arch/arm/mach-shmobile/setup-r8a7740.c        |   53 +++++------
>  3 files changed, 147 insertions(+), 25 deletions(-)

Thanks, queued-up for v3.11 in the soc-r8a7740 branch.
