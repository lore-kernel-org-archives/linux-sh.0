From: =?windows-1252?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Date: Wed, 05 Nov 2014 03:35:18 +0000
Subject: Re: [PATCH 4/7] pinctrl: zynq: Document DT binding
Message-Id: <54599AF6.1030404@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-5-git-send-email-soren.brinkmann@xilinx.com>
In-Reply-To: <1415041531-15520-5-git-send-email-soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Am 03.11.2014 um 20:05 schrieb Soren Brinkmann:
> Add documentation for the devicetree binding for the Zynq pincontroller.
>=20
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  .../bindings/pinctrl/xlnx,zynq-pinctrl.txt         | 90 ++++++++++++++++=
++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,zynq-p=
inctrl.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.=
txt b/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.txt
> new file mode 100644
> index 000000000000..86a86b644e6c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.txt
> @@ -0,0 +1,90 @@
> +	Binding for Xilinx Zynq Pinctrl
> +
> +Required properties:
> +- compatible: "xlnx,zynq-pinctrl"
> +- syscon: phandle to SLCR
> +- reg: Offset and length of pinctrl space in SLCR
> +
> +Please refer to pinctrl-bindings.txt in this directory for details of the
> +common pinctrl bindings used by client devices, including the meaning of=
 the
> +phrase "pin configuration node".
> +
> +Zynq's pin configuration nodes act as a container for an abitrary number=
 of

"arbitrary"

> +subnodes. Each of these subnodes represents some desired configuration f=
or a
> +pin, a group, or a list of pins or groups. This configuration can includ=
e the
> +mux function to select on those pin(s)/group(s), and various pin configu=
ration
> +parameters, such as pull-up, slew rate, etc.
> +
> +The name of each subnode is not important; all subnodes should be enumer=
ated
> +and processed purely based on their content.
> +
> +Each subnode only affects those parameters that are explicitly listed. In
> +other words, a subnode that lists a mux function but no pin configuration
> +parameters implies no information about any pin configuration parameters.
> +Similarly, a pin subnode that describes a pullup parameter implies no
> +information about e.g. the mux function.
> +
> +
> +The following generic properties as defined in pinctrl-bindings.txt are =
valid
> +to specify in a pin configuration subnode:
> + groups, pins, function, bias-disable, bias-high-impedance, bias-pull-up,
> + slew-rate, low-power-disable, low-power-enable
> +
> + Valid arguments for 'slew-rate' are '0' and '1' to select between slow =
and fast
> + respectively.
> +
> + Valid values for groups are:
> +   ethernet0_0_grp, ethernet1_0_grp, mdio0_0_grp, mdio1_0_grp,
> +   qspi0_0_grp, qspi1_0_grp, qspi_fbclk, qspi_cs1_grp, spi0_0_grp,
> +   spi0_1_grp - spi0_2_grp, spi1_0_grp - spi1_3_grp, sdio0_0_grp - sdio0=
_2_grp,
> +   sdio1_0_grp - sdio1_3_grp, sdio0_emio_wp, sdio0_emio_cd, sdio1_emio_w=
p,
> +   sdio1_emio_cd, smc0_nor, smc0_nor_cs1_grp, smc0_nor_addr25_grp, smc0_=
nand,
> +   can0_0_grp - can0_10_grp, can1_0_grp - can1_11_grp, uart0_0_grp - uar=
t0_10_grp,
> +   uart1_0_grp - uart1_11_grp, i2c0_0_grp - i2c0_10_grp, i2c1_0_grp - i2=
c1_10_grp,
> +   ttc0_0_grp - ttc0_2_grp, ttc1_0_grp - ttc1_2_grp, swdt0_0_grp - swdt0=
_4_grp,
> +   gpio0_0_grp - gpio0_53_grp
> +
> + Valid values for pins are:
> +   MIO0 - MIO53

What about the four EMIO_SD* pins?

> +
> + Valid values for function are:
> +   ethernet0, ethernet1, mdio0, mdio1, qspi0, qspi1, qspi_fbclk, qspi_cs=
1,
> +   spi0, spi1, sdio0, sdio0_pc, sdio0_cd, sdio0_wp,
> +   sdio1, sdio1_pc, sdio1_cd, sdio1_wp,
> +   smc0_nor, smc0_nor_cs1, smc0_nor_addr25, smc0_nand, can0, can1, uart0=
, uart1,
> +   i2c0, i2c1, ttc0, ttc1, swdt0, gpio0
> +
> +The following driver-specific properties as defined here are valid to sp=
ecify in
> +a pin configuration subnode:
> + - io-standard: Configure the pin to use the selected IO standard accord=
ing to
> +   this mapping:
> +    1: LVCMOS18
> +    2: LVCMOS25
> +    3: LVCMOS33
> +    4: HSTL
> +
> +Example:
> +	pinctrl0: pinctrl@700 {
> +		compatible =3D "xlnx,pinctrl-zynq";
> +		reg =3D <0x700 0x200>;
> +		syscon =3D <&slcr>;
> +
> +		pinctrl_uart1_default: pinctrl-uart1-default {

Nit: Is it really necessary to prefix subnodes of "pinctrl@700" with
"pinctrl-", here and in .dts?

> +			common {
> +				groups =3D "uart1_10_grp";
> +				function =3D "uart1";
> +				slew-rate =3D <0>;
> +				io-standard =3D <1>;
> +			};
> +
> +			rx {
> +				pins =3D "MIO49";
> +				bias-high-impedance;
> +			};
> +
> +			tx {
> +				pins =3D "MIO48";
> +				bias-disable;
> +			};
> +		};
> +	};

Otherwise looks good.

Cheers,
Andreas

--=20
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 21284 AG N=FCrnberg
