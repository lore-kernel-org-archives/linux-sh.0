From: Simon Horman <horms@verge.net.au>
Date: Thu, 07 Aug 2014 00:47:41 +0000
Subject: Re: [PATCH] ARM: shmobile: koelsch: add VIN1/ADV7180 DT support
Message-Id: <20140807004741.GA32766@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201408020402.14560.sergei.shtylyov@cogentembedded.com>
 <2131152.vMTPsJUYLQ@wasted.cogentembedded.com>
In-Reply-To: <2131152.vMTPsJUYLQ@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 06, 2014 at 10:38:22PM +0400, sergei.shtylyov@cogentembedded.com wrote:
> Define the Koelsch board dependent part of the VIN1 device node. Add the device
> node for Analog  Devices ADV7180  video decoder to  I2C2 bus. Add the necessary
> subnodes to interconnect VIN1 and ADV7180 devices.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against the 'renesas-devel-v3.16-20140804' tag of Simon Horman's
> 'renesas.git' repo. It requires the 'soc_camera' and 'rcar_vin' device tree
> support patches (already merged to the 'media_tree.git' repo) in order to work.
> 
>  arch/arm/boot/dts/r8a7791-koelsch.dts |   35 ++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

Thanks, I have queued this up for v3.18.
