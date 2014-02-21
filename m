From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 21 Feb 2014 08:58:20 +0000
Subject: Maybe this is CCF bug
Message-Id: <87zjlkq1v1.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent, Magnus, and All

Now, I'm working for sound DT support,
and I noticed common clock setting's strange behavior.
I guess this is bug, but 50% my misunderstanding.

Now, we have clock index on ${LINUX}/include/dt-bindings/clock/r8a7790-clock.h
For example, r8a7790's MSTP9 case, like this

	/* MSTP9 */
	#define R8A7790_CLK_GPIO5		7
	#define R8A7790_CLK_GPIO4		8
	#define R8A7790_CLK_GPIO3		9
	#define R8A7790_CLK_GPIO2		10
	#define R8A7790_CLK_GPIO1		11
	#define R8A7790_CLK_GPIO0		12
	#define R8A7790_CLK_RCAN1		15
	#define R8A7790_CLK_RCAN0		16
	#define R8A7790_CLK_QSPI_MOD		17
	#define R8A7790_CLK_IICDVFS		26
	#define R8A7790_CLK_I2C3		28
	#define R8A7790_CLK_I2C2		29
	#define R8A7790_CLK_I2C1		30
	#define R8A7790_CLK_I2C0		31

and MSTP9 is like this

	mstp9_clks: mstp9_clks@e6150994 {
		compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
		reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
		clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7790_CLK_QSPI>,
			 <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>;
		#clock-cells = <1>;
		renesas,clock-indices = <
			R8A7790_CLK_RCAN1 R8A7790_CLK_RCAN0 R8A7790_CLK_QSPI_MOD
			R8A7790_CLK_I2C3 R8A7790_CLK_I2C2 R8A7790_CLK_I2C1
			R8A7790_CLK_I2C0
		>;
		clock-output-names 			"rcan1", "rcan0", "qspi_mod", "i2c3", "i2c2", "i2c1", "i2c0";
	};

And, now, spi parent is MSTP9 QSPI MOD

	spi: spi@e6b10000 {
		...
		clocks = <&mstp9_clks R8A7790_CLK_QSPI_MOD>;
		...
	};

This SPI would like to use MSTP9's 17th (= R8A7790_CLK_QSPI_MOD) clock as its parent.
But, mstp9_clks has 7 clocks only.
R8A7790_CLK_xxx means "bit shift", not "index" on DT clock.

On ${LINUX}/drivers/clk/shmobile/clk-mstp.c,
it try to get parent name by

	parent_name = of_clk_get_parent_name(np, i);

and it returns "mstp9_clks" in this case.
Maybe SPI would like to get "qspi_mod" ?

What do you think ?
Is this cause of pm_runtime issue ?

Best regards
---
Kuninori Morimoto
