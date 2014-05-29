From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Thu, 29 May 2014 14:46:31 +0000
Subject: RE: [PATCH 4/8] ARM: shmobile: lager: Add dummy PCIe bus clock
Message-Id: <d142b2658a1c4ae89462598d826341f8@HKXPR06MB168.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1401261843-6964-5-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1401261843-6964-5-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On 28 May 2014 18:40, Sergei wrote:
> On 05/28/2014 07:04 PM, Phil Edworthy wrote:
> 
> >>> Since the CPU's dtsi refers to pcie_bus_clock, we need an entry in
> >>> the board's dts, even if we aren't using PCIe.
> 
> >>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> >>> ---
> >>>    arch/arm/boot/dts/r8a7790-lager.dts | 10 ++++++++++
> >>>    1 file changed, 10 insertions(+)
> 
> >>> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts
> >> b/arch/arm/boot/dts/r8a7790-lager.dts
> >>> index 9becef7..6d4fe97 100644
> >>> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> >>> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> >>> @@ -144,6 +144,16 @@
> >>>    		states = <3300000 1
> >>>    			  1800000 0>;
> >>>    	};
> >>> +
> >>> +	clocks {
> >>> +		/* External PCIe bus clock - not used */
> >>> +		pcie_bus_clk: pcie_bus_clk {
> >>> +			compatible = "fixed-clock";
> >>> +			#clock-cells = <0>;
> >>> +			clock-frequency = <0>;
> 
> >>      When this value gets filled in?
> 
> > It doesn't. On the Lager board, there is no PCIe support.
> 
> > It's needed as pcie_bus_clk is referenced from r8a7790.dtsi and without it
> > you'll get build failures.
> 
>     Yeah, I've figured that out after sending that email. Perhaps it makes
> sense to stub this clock in the SoC's .dtsi file alike the EXTAL clock?

I am not sure what's best, providing a complete fixed-clock entry in the device dtsi and allow boards to override everything about the clock, or provide an empty shell for the clock. I'm leaning towards a complete fixed-clock entry.

Thanks
Phil

