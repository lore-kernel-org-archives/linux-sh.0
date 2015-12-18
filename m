From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Date: Fri, 18 Dec 2015 01:56:49 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7795: DU and IPMMU prototype hack
Message-Id: <567367E1.80105@rvc.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151217065715.31261.43936.sendpatchset@little-apple>
In-Reply-To: <20151217065715.31261.43936.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

Thanks for your patch.
Let me confirm some points inline.

On 12/17/2015 1:57 PM, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> This prototype hack tries to hook up the r8a7795 DU/VSPD/FCPVD
> instance to the IPMMU device and hack the driver to get something
> to work. The IPMMU device has been proven to work with other
> on-chip r8a7795 devices with upstream support, however the DU
> devices are not yet working and seem to be a moving target.
>
> Developed on top on older renesas-drivers release that has the
> DU patch stack included. More recent releases have the DU patch
> stack excluded due to merge issues. Needs more work.
>
> Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>   Developed on top of renesas-drivers-2015-12-08-v4.4-rc4 and
>   [PATCH 00/06] iommu/ipmmu-vmsa: IPMMU multi-arch update
>   [PATCH/RFC 00/10] iommu/ipmmu-vmsa: Experimental r8a7795 support
>   [PATCH/RFC 00/03] ARM: shmobile: r8a7795 Salvator-X IPMMU test code
>
>   arch/arm64/boot/dts/renesas/r8a7795.dtsi |   15 +++++++++++++--
>   drivers/gpu/drm/rcar-du/rcar_du_drv.c    |    4 ++--
>   drivers/gpu/drm/rcar-du/rcar_du_vsp.c    |    2 ++
>   drivers/media/platform/vsp1/vsp1_wpf.c   |    3 +++
>   4 files changed, 20 insertions(+), 4 deletions(-)
>
> --- 0028/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi	2015-12-17 11:28:23.700513000 +0900
> @@ -325,7 +325,14 @@
>   			compatible = "renesas,ipmmu-r8a7795";
>   			reg = <0 0xe6740000 0 0x1000>; /* IPMMU-DS0 */
>   			#iommu-cells = <1>;
> -			status = "okay";
> +			status = "disabled";
> +		};
> +
> +		ipmmu_vi: mmu@febd0000 {
> +			compatible = "renesas,ipmmu-r8a7795";
> +			reg = <0 0xfebd0000 0 0x1000>;
> +			#iommu-cells = <1>;
> +			status = "disabled";

It should be "okay" to test with DU, right ?

>   		};
>
>   		dmac0: dma-controller@e6700000 {
> @@ -936,6 +943,7 @@
>   			reg = <0 0xfea20000 0 0x8000>;
>   			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cpg CPG_MOD 623>;
> +			iommus = <&ipmmu_vi 8>;
>
>   			renesas,has-lif;
>   			renesas,has-lut;
> @@ -948,6 +956,7 @@
>   			reg = <0 0xfea28000 0 0x8000>;
>   			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cpg CPG_MOD 622>;
> +			iommus = <&ipmmu_vi 9>;
>
>   			renesas,has-lif;
>   			renesas,has-lut;
> @@ -960,6 +969,7 @@
>   			reg = <0 0xfea30000 0 0x8000>;
>   			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cpg CPG_MOD 621>;
> +			iommus = <&ipmmu_vi 10>;
>
>   			renesas,has-lif;
>   			renesas,has-lut;
> @@ -972,6 +982,7 @@
>   			reg = <0 0xfea38000 0 0x8000>;
>   			interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cpg CPG_MOD 620>;
> +			iommus = <&ipmmu_vi 11>;
>
>   			renesas,has-lif;
>   			renesas,has-lut;
> @@ -996,7 +1007,7 @@
>   			clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0";
>   			status = "disabled";
>
> -			vsps = <&vspd0 &vspd1 &vspd2 &vspd3>;
> +			vsps = <&vspd0>;

As you has removed vspd1...vspd3 here,
I guess above iommus properties under vspd1...vspd3 are not necessary, 
right ?

>   			ports {
>   				#address-cells = <1>;
> --- 0001/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ work/drivers/gpu/drm/rcar-du/rcar_du_drv.c	2015-12-17 11:10:01.380513000 +0900
> @@ -138,13 +138,13 @@ static const struct rcar_du_device_info
>   	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
>   		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
>   		  | RCAR_DU_FEATURE_VSP1_SOURCE,
> -	.num_crtcs = 4,
> +	.num_crtcs = 1,
>   	.routes = {
>   		/* R8A7795 has one RGB output, one LVDS output and two
>   		 * (currently unsupported) HDMI outputs.
>   		 */
>   		[RCAR_DU_OUTPUT_DPAD0] = {
> -			.possible_crtcs = BIT(3),
> +			.possible_crtcs = BIT(0),
>   			.encoder_type = DRM_MODE_ENCODER_NONE,
>   			.port = 0,
>   		},
> --- 0001/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> +++ work/drivers/gpu/drm/rcar-du/rcar_du_vsp.c	2015-12-17 11:10:01.380513000 +0900
> @@ -329,6 +329,8 @@ int rcar_du_vsp_init(struct rcar_du_vsp
>
>   	vsp->vsp = &pdev->dev;
>
> +	rcdu->ddev->dev = vsp->vsp; // HACK
> +	
>   	ret = vsp1_du_init(vsp->vsp);
>   	if (ret < 0)
>   		return ret;
> --- 0001/drivers/media/platform/vsp1/vsp1_wpf.c
> +++ work/drivers/media/platform/vsp1/vsp1_wpf.c	2015-12-17 11:11:46.790513000 +0900
> @@ -158,6 +158,9 @@ static int wpf_s_stream(struct v4l2_subd
>   	if (vsp1->pdata.uapi)
>   		mutex_lock(wpf->ctrls.lock);
>   	outfmt |= wpf->alpha->cur.val << VI6_WPF_OUTFMT_PDV_SHIFT;
> +#if 1	
> +	outfmt |= (1 << 20);
> +#endif
>   	vsp1_wpf_write(wpf, VI6_WPF_OUTFMT, outfmt);
>   	if (vsp1->pdata.uapi)
>   		mutex_unlock(wpf->ctrls.lock);

-- 
Best regards,
KHIEM Nguyen
