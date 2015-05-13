From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 13 May 2015 05:57:56 +0000
Subject: Re: [PATCH v2 08/15] ARM: shmobile: add r8a7793 SoC device tree
Message-Id: <87vbfxdnr3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430403544-26742-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<1430403544-26742-9-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1430403544-26742-9-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: geert@linux-m68k.org, horms@verge.net.au, linux-sh@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart+renesas@ideasonboard.com, linus.walleij@linaro.org, Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Ryo Kataoka <ryo.kataoka.wt@renesas.com>, Phil Edworthy <phil.edworthy@renesas.com>, devicetree@vger.kernel.org


Hi Ulrich

> r8a7793 device tree including clock descriptions.
> 
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> [uli: collapsed BSP revisions into a single commit, edited for style]
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Cc: devicetree@vger.kernel.org

# Hmm... I have never created patch for r8a7793 BSP before, but it has mine :)


About sound, it is using old style.
Please check upstreamed DTS, like r8a7790.dtsi/r8a7791.dtsi.
I added comment inline

> +	rcar_sound: sound@0xec500000 {
> +		#sound-dai-cells = <1>;

please don't set #sound-dai-cells on .dtsi

> +		compatible =  "renesas,rcar_sound-r8a7793", "renesas,rcar_sound-gen2", "renesas,rcar_sound";
> +		reg =	<0 0xec500000 0 0x1000>, /* SCU */
> +			<0 0xec5a0000 0 0x100>,  /* ADG */
> +			<0 0xec540000 0 0x1000>, /* SSIU */
> +			<0 0xec541000 0 0x1280>; /* SSI */

reg needs "Audio DMAC peri peri", and reg-names too.

> +		clocks = <&mstp10_clks R8A7793_CLK_SSI_ALL>,
> +			<&mstp10_clks R8A7793_CLK_SSI9>, <&mstp10_clks R8A7793_CLK_SSI8>,
> +			<&mstp10_clks R8A7793_CLK_SSI7>, <&mstp10_clks R8A7793_CLK_SSI6>,
> +			<&mstp10_clks R8A7793_CLK_SSI5>, <&mstp10_clks R8A7793_CLK_SSI4>,
> +			<&mstp10_clks R8A7793_CLK_SSI3>, <&mstp10_clks R8A7793_CLK_SSI2>,
> +			<&mstp10_clks R8A7793_CLK_SSI1>, <&mstp10_clks R8A7793_CLK_SSI0>,
> +			<&mstp10_clks R8A7793_CLK_SCU_SRC9>, <&mstp10_clks R8A7793_CLK_SCU_SRC8>,
> +			<&mstp10_clks R8A7793_CLK_SCU_SRC7>, <&mstp10_clks R8A7793_CLK_SCU_SRC6>,
> +			<&mstp10_clks R8A7793_CLK_SCU_SRC5>, <&mstp10_clks R8A7793_CLK_SCU_SRC4>,
> +			<&mstp10_clks R8A7793_CLK_SCU_SRC3>, <&mstp10_clks R8A7793_CLK_SCU_SRC2>,
> +			<&mstp10_clks R8A7793_CLK_SCU_SRC1>, <&mstp10_clks R8A7793_CLK_SCU_SRC0>,
> +			<&mstp10_clks R8A7793_CLK_SCU_DVC0>, <&mstp10_clks R8A7793_CLK_SCU_DVC1>,
> +			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
> +		clock-names = "ssi",
> +				"ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
> +				"ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
> +				"src.9", "src.8", "src.7", "src.6", "src.5",
> +				"src.4", "src.3", "src.2", "src.1", "src.0",
> +				"dvc.0", "dvc.1",
> +				"clk_a", "clk_b", "clk_c", "clk_i";
> +
> +		dmas =  <&audma0 0x01>,	<&audma1 0x02>,	<&audma0 0x15>,	<&audma1 0x16>,
> +			<&audma0 0x03>,	<&audma1 0x04>,	<&audma0 0x49>,	<&audma1 0x4a>,
> +			<&audma0 0x05>,	<&audma1 0x06>,	<&audma0 0x63>,	<&audma1 0x64>,
> +			<&audma0 0x07>,	<&audma1 0x08>,	<&audma0 0x6f>,	<&audma1 0x70>,
> +			<&audma0 0x09>,	<&audma1 0x0a>,	<&audma0 0x71>,	<&audma1 0x72>,
> +			<&audma0 0x0b>,	<&audma1 0x0c>,	<&audma0 0x73>,	<&audma1 0x74>,
> +			<&audma0 0x0d>,	<&audma1 0x0e>,	<&audma0 0x75>,	<&audma1 0x76>,
> +			<&audma0 0x0f>,	<&audma1 0x10>,	<&audma0 0x79>,	<&audma1 0x7a>,
> +			<&audma0 0x11>,	<&audma1 0x12>,	<&audma0 0x7b>,	<&audma1 0x7c>,
> +			<&audma0 0x13>,	<&audma1 0x14>,	<&audma0 0x7d>,	<&audma1 0x7e>,
(snip)
> +		dma-names = "mem_ssi0", "ssi0_mem", "mem_ssiu0", "ssiu0_mem",
> +			    "mem_ssi1", "ssi1_mem", "mem_ssiu1", "ssiu1_mem",
> +			    "mem_ssi2", "ssi2_mem", "mem_ssiu2", "ssiu2_mem",
> +			    "mem_ssi3", "ssi3_mem", "mem_ssiu3", "ssiu3_mem",
> +			    "mem_ssi4", "ssi4_mem", "mem_ssiu4", "ssiu4_mem",
> +			    "mem_ssi5", "ssi5_mem", "mem_ssiu5", "ssiu5_mem",
> +			    "mem_ssi6", "ssi6_mem", "mem_ssiu6", "ssiu6_mem",
> +			    "mem_ssi7", "ssi7_mem", "mem_ssiu7", "ssiu7_mem",
> +			    "mem_ssi8", "ssi8_mem", "mem_ssiu8", "ssiu8_mem",
> +			    "mem_ssi9", "ssi9_mem", "mem_ssiu9", "ssiu9_mem",

These dmas/dma-names are not supported on upstreamed driver.

> +		status = "disabled";
> +
> +		rcar_sound,dvc {
> +			dvc0: dvc@0 { };
> +			dvc1: dvc@1 { };
> +		};
> +
> +		rcar_sound,src {
> +			src0: src@0 { interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>; };
> +			src1: src@1 { interrupts = <0 353 IRQ_TYPE_LEVEL_HIGH>; };
> +			src2: src@2 { interrupts = <0 354 IRQ_TYPE_LEVEL_HIGH>; };
> +			src3: src@3 { interrupts = <0 355 IRQ_TYPE_LEVEL_HIGH>; };
> +			src4: src@4 { interrupts = <0 356 IRQ_TYPE_LEVEL_HIGH>; };
> +			src5: src@5 { interrupts = <0 357 IRQ_TYPE_LEVEL_HIGH>; };
> +			src6: src@6 { interrupts = <0 358 IRQ_TYPE_LEVEL_HIGH>; };
> +			src7: src@7 { interrupts = <0 359 IRQ_TYPE_LEVEL_HIGH>; };
> +			src8: src@8 { interrupts = <0 360 IRQ_TYPE_LEVEL_HIGH>; };
> +			src9: src@9 { interrupts = <0 361 IRQ_TYPE_LEVEL_HIGH>; };
> +		};
> +
> +		rcar_sound,ssi {
> +			ssi0: ssi@0 { interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>; };
> +			ssi1: ssi@1 { interrupts = <0 371 IRQ_TYPE_LEVEL_HIGH>; };
> +			ssi2: ssi@2 { interrupts = <0 372 IRQ_TYPE_LEVEL_HIGH>; };
> +			ssi3: ssi@3 { interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>; };
> +			ssi4: ssi@4 { interrupts = <0 374 IRQ_TYPE_LEVEL_HIGH>; };
> +			ssi5: ssi@5 { interrupts = <0 375 IRQ_TYPE_LEVEL_HIGH>; };
> +			ssi6: ssi@6 { interrupts = <0 376 IRQ_TYPE_LEVEL_HIGH>; };
> +			ssi7: ssi@7 { interrupts = <0 377 IRQ_TYPE_LEVEL_HIGH>; };
> +			ssi8: ssi@8 { interrupts = <0 378 IRQ_TYPE_LEVEL_HIGH>; };
> +			ssi9: ssi@9 { interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>; };
> +		};

rcar_sound,dvc/src/ssi needs interrupts/dmas/dma-names

