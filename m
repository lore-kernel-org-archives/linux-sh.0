From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 17 Dec 2015 11:42:23 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: DU and IPMMU-MX prototype
Message-Id: <56729F9F.9070307@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151217064535.30114.91840.sendpatchset@little-apple>
In-Reply-To: <20151217064535.30114.91840.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 12/17/2015 9:45 AM, Magnus Damm wrote:

> From: Magnus Damm <damm+renesas@opensource.se>
>
> Enable the IPMMU-MX device and hook up the DU on r8a7790,
> and also include enable debug messages.
>
> On boards such as r8a7790 Lager the DU will with this change
> included use IOMMU framework and IPMMU-MX device  when driving
> on-board video output via VGA, HDMI and LVDS.
>
> Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>   Written against renesas-devel-20151217v2-v4.4-rc5
>
>   arch/arm/boot/dts/r8a7790.dtsi |    3 ++-
>   drivers/iommu/iommu.c          |    2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> --- 0001/arch/arm/boot/dts/r8a7790.dtsi
> +++ work/arch/arm/boot/dts/r8a7790.dtsi	2015-12-17 15:38:20.890513000 +0900
> @@ -886,6 +886,7 @@
>   			 <&mstp7_clks R8A7790_CLK_LVDS0>,
>   			 <&mstp7_clks R8A7790_CLK_LVDS1>;
>   		clock-names = "du.0", "du.1", "du.2", "lvds.0", "lvds.1";
> +		iommus = <&ipmmu_mx 15>, <&ipmmu_mx 16>;
>   		status = "disabled";
>
>   		ports {
> @@ -1809,7 +1810,7 @@
>   		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
>   			     <0 221 IRQ_TYPE_LEVEL_HIGH>;
>   		#iommu-cells = <1>;
> -		status = "disabled";
> +		status = "okay";

    It's enough to just omit the "status" prop, AFAIK.

[...]
> --- 0001/drivers/iommu/iommu.c
> +++ work/drivers/iommu/iommu.c	2015-12-17 15:38:34.880513000 +0900
> @@ -15,7 +15,7 @@
>    * along with this program; if not, write to the Free Software
>    * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
>    */
> -
> +#define DEBUG

    Unrelated change?

MBR, Sergei

