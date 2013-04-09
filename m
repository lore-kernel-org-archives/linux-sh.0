From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 09 Apr 2013 14:45:55 +0000
Subject: Re: [RFC][PATCH 1/4] sh-pfc: Add r8a7778 pinmux support
Message-Id: <2688069.GflBqgdHW4@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <8761zwb74q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761zwb74q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch. The code looks good overall, please see inline for 
comments.

On Monday 08 April 2013 22:33:29 Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/Kconfig       |    1 +

Could you please split the change to arch/arm to a separate patch ? You can 
move it to patch 3/4 in this series.

>  drivers/pinctrl/sh-pfc/Kconfig       |    5 +
>  drivers/pinctrl/sh-pfc/Makefile      |    1 +
>  drivers/pinctrl/sh-pfc/core.c        |    3 +
>  drivers/pinctrl/sh-pfc/core.h        |    1 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 2359 +++++++++++++++++++++++++++++++
>  6 files changed, 2370 insertions(+)
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a7778.c

[snip]

> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c new file mode 100644
> index 0000000..247e589
> --- /dev/null
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> @@ -0,0 +1,2359 @@
> +/*
> + * r8a7778 processor support - PFC hardware block
> + *
> + * Copyright (C) 2013  Renesas Solutions Corp.
> + * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + *
> + * based on
> + * Copyright (C) 2011  Renesas Solutions Corp.
> + * Copyright (C) 2011  Magnus Damm
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 
> USA

You can remove the last paragraph, we don't want to patch all source files in 
the kernel the day the FSF decides to move :-)

> + */
> +
> +#include <linux/platform_data/gpio-rcar.h>
> +#include <linux/kernel.h>
> +#include "sh_pfc.h"
> +
> +#define PORT_GP_1(bank, pin, fn, sfx) fn(bank, pin, GP_##bank##_##pin, sfx)
> +
> +#define PORT_GP_32(bank, fn, sfx)					\
> +	PORT_GP_1(bank, 0,  fn, sfx), PORT_GP_1(bank, 1,  fn, sfx),	\
> +	PORT_GP_1(bank, 2,  fn, sfx), PORT_GP_1(bank, 3,  fn, sfx),	\
> +	PORT_GP_1(bank, 4,  fn, sfx), PORT_GP_1(bank, 5,  fn, sfx),	\
> +	PORT_GP_1(bank, 6,  fn, sfx), PORT_GP_1(bank, 7,  fn, sfx),	\
> +	PORT_GP_1(bank, 8,  fn, sfx), PORT_GP_1(bank, 9,  fn, sfx),	\
> +	PORT_GP_1(bank, 10, fn, sfx), PORT_GP_1(bank, 11, fn, sfx),	\
> +	PORT_GP_1(bank, 12, fn, sfx), PORT_GP_1(bank, 13, fn, sfx),	\
> +	PORT_GP_1(bank, 14, fn, sfx), PORT_GP_1(bank, 15, fn, sfx),	\
> +	PORT_GP_1(bank, 16, fn, sfx), PORT_GP_1(bank, 17, fn, sfx),	\
> +	PORT_GP_1(bank, 18, fn, sfx), PORT_GP_1(bank, 19, fn, sfx),	\
> +	PORT_GP_1(bank, 20, fn, sfx), PORT_GP_1(bank, 21, fn, sfx),	\
> +	PORT_GP_1(bank, 22, fn, sfx), PORT_GP_1(bank, 23, fn, sfx),	\
> +	PORT_GP_1(bank, 24, fn, sfx), PORT_GP_1(bank, 25, fn, sfx),	\
> +	PORT_GP_1(bank, 26, fn, sfx), PORT_GP_1(bank, 27, fn, sfx),	\
> +	PORT_GP_1(bank, 28, fn, sfx), PORT_GP_1(bank, 29, fn, sfx),	\
> +	PORT_GP_1(bank, 30, fn, sfx), PORT_GP_1(bank, 31, fn, sfx)
> +
> +#define PORT_GP_26(bank, fn, sfx)					\

This macro will definee 27 pins, so you could rename it to PORT_GP_27 for 
consistency with PORT_GP_32.

> +	PORT_GP_1(bank, 0,  fn, sfx), PORT_GP_1(bank, 1,  fn, sfx),	\
> +	PORT_GP_1(bank, 2,  fn, sfx), PORT_GP_1(bank, 3,  fn, sfx),	\
> +	PORT_GP_1(bank, 4,  fn, sfx), PORT_GP_1(bank, 5,  fn, sfx),	\
> +	PORT_GP_1(bank, 6,  fn, sfx), PORT_GP_1(bank, 7,  fn, sfx),	\
> +	PORT_GP_1(bank, 8,  fn, sfx), PORT_GP_1(bank, 9,  fn, sfx),	\
> +	PORT_GP_1(bank, 10, fn, sfx), PORT_GP_1(bank, 11, fn, sfx),	\
> +	PORT_GP_1(bank, 12, fn, sfx), PORT_GP_1(bank, 13, fn, sfx),	\
> +	PORT_GP_1(bank, 14, fn, sfx), PORT_GP_1(bank, 15, fn, sfx),	\
> +	PORT_GP_1(bank, 16, fn, sfx), PORT_GP_1(bank, 17, fn, sfx),	\
> +	PORT_GP_1(bank, 18, fn, sfx), PORT_GP_1(bank, 19, fn, sfx),	\
> +	PORT_GP_1(bank, 20, fn, sfx), PORT_GP_1(bank, 21, fn, sfx),	\
> +	PORT_GP_1(bank, 22, fn, sfx), PORT_GP_1(bank, 23, fn, sfx),	\
> +	PORT_GP_1(bank, 24, fn, sfx), PORT_GP_1(bank, 25, fn, sfx),	\
> +	PORT_GP_1(bank, 26, fn, sfx)
> +
> +#define CPU_ALL_PORT(fn, sfx)		\
> +	PORT_GP_32(0, fn, sfx),		\
> +	PORT_GP_32(1, fn, sfx),		\
> +	PORT_GP_32(2, fn, sfx),		\
> +	PORT_GP_32(3, fn, sfx),		\
> +	PORT_GP_26(4, fn, sfx)
> +
> +#define _GP_PORT_ALL(bank, pin, name, sfx)	name##_##sfx
> +
> +#define _GP_GPIO(bank, pin, _name, sfx)		\
> +	[RCAR_GP_PIN(bank, pin)] = {		\
> +		.name = __stringify(_name),	\
> +		.enum_id = _name##_DATA,	\
> +	}
> +
> +#define _GP_DATA(bank, pin, name, sfx)		\
> +	PINMUX_DATA(name##_DATA, name##_FN)
> +
> +#define GP_ALL(str)		CPU_ALL_PORT(_GP_PORT_ALL, str)
> +#define PINMUX_GPIO_GP_ALL()	CPU_ALL_PORT(_GP_GPIO, unused)
> +#define PINMUX_DATA_GP_ALL()	CPU_ALL_PORT(_GP_DATA, unused)
> +
> +#define PINMUX_IPSR_NOGP(ispr, fn)	PINMUX_DATA(fn##_MARK, FN_##fn)
> +#define PINMUX_IPSR_DATA(ipsr, fn)	PINMUX_DATA(fn##_MARK, FN_##fn,
> FN_##ipsr)
> +#define PINMUX_IPSR_MSEL(ipsr, fn, ms)	PINMUX_DATA(fn##_MARK, FN_##fn,
> FN_##ipsr, FN_##ms)
> +#define PINMUX_IPSR_NOGM(ispr, fn, ms)	PINMUX_DATA(fn##_MARK, FN_##fn,
> FN_##ms)

[snip]

> +/* Pin numbers for pins without a corresponding GPIO port number are
> computed
> + * from the row and column numbers with a 1000 offset to avoid collisions
> with
> + * GPIO port numbers.
> + */
> +#define PIN_NUMBER(row, col)		(1000+((row)-1)*25+(col)-1)
> +
> +#define SH_PFC_PINS(name, args...)	static const unsigned int name
> ##_pins[] = { args }

Could you please add a line break before 'static' (here and below) to keep the 
line length below 80 characters ?

#define SH_PFC_PINS(name, args...) \
        static const unsigned int name ##_pins[] = { args }

> +#define SH_PFC_MUX1(name, arg1)		static const unsigned int name
> ##_mux[]  = { arg1##_MARK, }
> +#define SH_PFC_MUX2(name, arg1, arg2)	static const unsigned int name
> ##_mux[]  = { arg1##_MARK, arg2##_MARK, }

This is an interesting approach, but I'm afraid it won't scale. We will have 
groups with more than 2 pins, and I'd like to avoid defining MUX3, MUX4, ... 
macros.

One possible solution woud be to define a single SH_PFC_MUX macro with a 
variable number of arguments, and add the _MARK suffix explicitly. The other 
solution is to define the tables explicitly as done in the other pfc-*.c 
files. I have no strong preference.

> +/* - SCIF
> -------------------------------------------------------------------- */
> +SH_PFC_PINS(scif0_data_a,	RCAR_GP_PIN(1, 17),	RCAR_GP_PIN(1, 18));
> +SH_PFC_MUX2(scif0_data_a,	TX0_A,			RX0_A);

Aligning the pins and mux is nice here, but will result it way too long lines 
later for groups with more than two pins. I'll let you decide whether to keep 
the alignment here or not.

> +SH_PFC_PINS(scif0_data_b,	RCAR_GP_PIN(2, 3),	RCAR_GP_PIN(2, 2));
> +SH_PFC_MUX2(scif0_data_b,	TX0_B,			RX0_B);
> +SH_PFC_PINS(scif0_data_c,	RCAR_GP_PIN(4, 0),	RCAR_GP_PIN(3, 31));
> +SH_PFC_MUX2(scif0_data_c,	TX0_C,			RX0_C);
> +SH_PFC_PINS(scif0_data_d,	RCAR_GP_PIN(3, 6),	RCAR_GP_PIN(3, 1));
> +SH_PFC_MUX2(scif0_data_d,	TX0_D,			RX0_D);
> +SH_PFC_PINS(scif0_ctrl,		RCAR_GP_PIN(1, 20),	RCAR_GP_PIN(1, 21));
> +SH_PFC_MUX2(scif0_ctrl,		CTS0,			RTS0);
> +SH_PFC_PINS(scif0_clk,		RCAR_GP_PIN(1, 19));
> +SH_PFC_MUX1(scif0_clk,		SCK0);

Could you please add a separator line like in the other pfc-*.c files ?

> +SH_PFC_PINS(scif1_data_a,	RCAR_GP_PIN(4, 0),	RCAR_GP_PIN(4, 1));
> +SH_PFC_MUX2(scif1_data_a,	TX1_A,			RX1_A);
> +SH_PFC_PINS(scif1_data_b,	RCAR_GP_PIN(2, 24),	RCAR_GP_PIN(2, 25));
> +SH_PFC_MUX2(scif1_data_b,	TX1_B,			RX1_B);
> +SH_PFC_PINS(scif1_data_c,	RCAR_GP_PIN(3, 22),	RCAR_GP_PIN(3, 21));
> +SH_PFC_MUX2(scif1_data_c,	TX1_C,			RX1_C);
> +SH_PFC_PINS(scif1_data_d,	RCAR_GP_PIN(1, 30),	RCAR_GP_PIN(1, 31));
> +SH_PFC_MUX2(scif1_data_d,	TX1_D,			RX1_D);
> +SH_PFC_PINS(scif1_ctrl_a,	RCAR_GP_PIN(4, 3),	RCAR_GP_PIN(4, 4));
> +SH_PFC_MUX2(scif1_ctrl_a,	CTS1_A,			RTS1_A);
> +SH_PFC_PINS(scif1_ctrl_c,	RCAR_GP_PIN(3, 23),	RCAR_GP_PIN(3, 19));
> +SH_PFC_MUX2(scif1_ctrl_c,	CTS1_C,			RTS1_C);
> +SH_PFC_PINS(scif1_clk_a,	RCAR_GP_PIN(4, 2));
> +SH_PFC_MUX1(scif1_clk_a,	SCK1_A);
> +SH_PFC_PINS(scif1_clk_c,	RCAR_GP_PIN(3, 20));
> +SH_PFC_MUX1(scif1_clk_c,	SCK1_C);
> +
> +SH_PFC_PINS(scif2_data_a,	RCAR_GP_PIN(2, 26),	RCAR_GP_PIN(2, 27));
> +SH_PFC_MUX2(scif2_data_a,	TX2_A,			RX2_A);
> +SH_PFC_PINS(scif2_data_b,	RCAR_GP_PIN(0, 29),	RCAR_GP_PIN(0, 28));
> +SH_PFC_MUX2(scif2_data_b,	TX2_B,			RX2_B);
> +SH_PFC_PINS(scif2_data_c,	RCAR_GP_PIN(4, 13),	RCAR_GP_PIN(4, 14));
> +SH_PFC_MUX2(scif2_data_c,	TX2_C,			RX2_C);
> +SH_PFC_PINS(scif2_data_d,	RCAR_GP_PIN(4, 15),	RCAR_GP_PIN(4, 16));
> +SH_PFC_MUX2(scif2_data_d,	TX2_D,			RX2_D);
> +SH_PFC_PINS(scif2_data_e,	RCAR_GP_PIN(0, 3),	RCAR_GP_PIN(0, 4));
> +SH_PFC_MUX2(scif2_data_e,	TX2_E,			RX2_E);
> +SH_PFC_PINS(scif2_clk_a,	RCAR_GP_PIN(3, 9));
> +SH_PFC_MUX1(scif2_clk_a,	SCK2_A);
> +SH_PFC_PINS(scif2_clk_b,	PIN_NUMBER(3, 20));
> +SH_PFC_MUX1(scif2_clk_b,	SCK2_B);
> +SH_PFC_PINS(scif2_clk_c,	RCAR_GP_PIN(4, 12));
> +SH_PFC_MUX1(scif2_clk_c,	SCK2_C);
> +
> +SH_PFC_PINS(scif3_data_a,	RCAR_GP_PIN(1, 10),	RCAR_GP_PIN(1, 9));
> +SH_PFC_MUX2(scif3_data_a,	TX3_A,			RX3_A);
> +SH_PFC_PINS(scif3_data_b,	RCAR_GP_PIN(3, 28),	RCAR_GP_PIN(3, 27));
> +SH_PFC_MUX2(scif3_data_b,	TX3_B,			RX3_B);
> +SH_PFC_PINS(scif3_data_c,	RCAR_GP_PIN(1, 3),	RCAR_GP_PIN(0, 31));
> +SH_PFC_MUX2(scif3_data_c,	TX3_C,			RX3_C);
> +SH_PFC_PINS(scif3_data_d,	RCAR_GP_PIN(3, 30),	RCAR_GP_PIN(3, 29));
> +SH_PFC_MUX2(scif3_data_d,	TX3_D,			RX3_D);
> +
> +SH_PFC_PINS(scif4_data_a,	RCAR_GP_PIN(2, 5),	RCAR_GP_PIN(2, 4));
> +SH_PFC_MUX2(scif4_data_a,	TX4_A,			RX4_A);
> +SH_PFC_PINS(scif4_data_b,	RCAR_GP_PIN(3, 26),	RCAR_GP_PIN(3, 25));
> +SH_PFC_MUX2(scif4_data_b,	TX4_B,			RX4_B);
> +SH_PFC_PINS(scif4_data_c,	RCAR_GP_PIN(3, 0),	RCAR_GP_PIN(2, 31));
> +SH_PFC_MUX2(scif4_data_c,	TX4_C,			RX4_C);
> +
> +SH_PFC_PINS(scif5_data_a,	RCAR_GP_PIN(3, 17),	RCAR_GP_PIN(3, 18));
> +SH_PFC_MUX2(scif5_data_a,	TX5_A,			RX5_A);
> +SH_PFC_PINS(scif5_data_b,	RCAR_GP_PIN(1, 15),	RCAR_GP_PIN(1, 14));
> +SH_PFC_MUX2(scif5_data_b,	TX5_B,			RX5_B);
> +
> +SH_PFC_PINS(scif_clk,		RCAR_GP_PIN(1, 16));
> +SH_PFC_MUX1(scif_clk,		SCIF_CLK);
> +
> +SH_PFC_PINS(hscif0_data_a,	RCAR_GP_PIN(1, 17),	RCAR_GP_PIN(1, 18));
> +SH_PFC_MUX2(hscif0_data_a,	HTX0_A,			HRX0_A);
> +SH_PFC_PINS(hscif0_data_b,	RCAR_GP_PIN(0, 29),	RCAR_GP_PIN(0, 30));
> +SH_PFC_MUX2(hscif0_data_b,	HTX0_B,			HRX0_B);
> +SH_PFC_PINS(hscif1_data_a,	RCAR_GP_PIN(3, 19),	RCAR_GP_PIN(3, 20));
> +SH_PFC_MUX2(hscif1_data_a,	HTX1_A,			HRX1_A);
> +SH_PFC_PINS(hscif1_data_b,	RCAR_GP_PIN(4, 5),	RCAR_GP_PIN(4, 6));
> +SH_PFC_MUX2(hscif1_data_b,	HTX1_B,			HRX1_B);
> +
> +SH_PFC_PINS(hscif0_ctrl_a,	RCAR_GP_PIN(1, 21),	RCAR_GP_PIN(1, 20));
> +SH_PFC_MUX2(hscif0_ctrl_a,	HRTS0_A,		HCTS0_A);
> +SH_PFC_PINS(hscif0_ctrl_b,	RCAR_GP_PIN(0, 28),	RCAR_GP_PIN(0, 31));
> +SH_PFC_MUX2(hscif0_ctrl_b,	HRTS0_B,		HCTS0_B);
> +SH_PFC_PINS(hscif1_ctrl_a,	RCAR_GP_PIN(3, 21),	RCAR_GP_PIN(3, 22));
> +SH_PFC_MUX2(hscif1_ctrl_a,	HRTS1_A,		HCTS1_A);
> +SH_PFC_PINS(hscif1_ctrl_b,	RCAR_GP_PIN(4, 7),	RCAR_GP_PIN(4, 8));
> +SH_PFC_MUX2(hscif1_ctrl_b,	HRTS1_B,		HCTS1_B);
> +SH_PFC_PINS(hscif0_clk_a,	RCAR_GP_PIN(1, 19));
> +SH_PFC_MUX1(hscif0_clk_a,	HSCK0_A);

There's no hscif0_clk_b, shouldn't hscif0_clk_a be renamed to hscif0_clk (and 
HSCK0_A to HSCK0) ? The version of the datasheet I have calls GP-1-19 function 
2 HSCK0, not HSCK0_A.

> +SH_PFC_PINS(hscif1_clk_a,	RCAR_GP_PIN(3, 23));
> +SH_PFC_MUX1(hscif1_clk_a,	HSCK1_A);
> +SH_PFC_PINS(hscif1_clk_b,	RCAR_GP_PIN(4, 2));
> +SH_PFC_MUX1(hscif1_clk_b,	HSCK1_B);

Could you please define hscif0 and hscif1 above scif* to keep the functions 
sorted alphabetically (and below as well) ?

> +static const struct sh_pfc_pin_group pinmux_groups[] = {
> +	SH_PFC_PIN_GROUP(scif0_data_a),
> +	SH_PFC_PIN_GROUP(scif0_data_b),
> +	SH_PFC_PIN_GROUP(scif0_data_c),
> +	SH_PFC_PIN_GROUP(scif0_data_d),
> +	SH_PFC_PIN_GROUP(scif0_ctrl),
> +	SH_PFC_PIN_GROUP(scif0_clk),
> +	SH_PFC_PIN_GROUP(scif1_data_a),
> +	SH_PFC_PIN_GROUP(scif1_data_b),
> +	SH_PFC_PIN_GROUP(scif1_data_c),
> +	SH_PFC_PIN_GROUP(scif1_data_d),
> +	SH_PFC_PIN_GROUP(scif1_ctrl_a),
> +	SH_PFC_PIN_GROUP(scif1_ctrl_c),
> +	SH_PFC_PIN_GROUP(scif1_clk_a),
> +	SH_PFC_PIN_GROUP(scif1_clk_c),
> +	SH_PFC_PIN_GROUP(scif2_data_a),
> +	SH_PFC_PIN_GROUP(scif2_data_b),
> +	SH_PFC_PIN_GROUP(scif2_data_c),
> +	SH_PFC_PIN_GROUP(scif2_data_d),
> +	SH_PFC_PIN_GROUP(scif2_data_e),
> +	SH_PFC_PIN_GROUP(scif2_clk_a),
> +	SH_PFC_PIN_GROUP(scif2_clk_b),
> +	SH_PFC_PIN_GROUP(scif2_clk_c),
> +	SH_PFC_PIN_GROUP(scif3_data_a),
> +	SH_PFC_PIN_GROUP(scif3_data_b),
> +	SH_PFC_PIN_GROUP(scif3_data_c),
> +	SH_PFC_PIN_GROUP(scif3_data_d),
> +	SH_PFC_PIN_GROUP(scif4_data_a),
> +	SH_PFC_PIN_GROUP(scif4_data_b),
> +	SH_PFC_PIN_GROUP(scif4_data_c),
> +	SH_PFC_PIN_GROUP(scif5_data_a),
> +	SH_PFC_PIN_GROUP(scif5_data_b),
> +	SH_PFC_PIN_GROUP(scif_clk),
> +	SH_PFC_PIN_GROUP(hscif0_data_a),
> +	SH_PFC_PIN_GROUP(hscif0_data_b),
> +	SH_PFC_PIN_GROUP(hscif1_data_a),
> +	SH_PFC_PIN_GROUP(hscif1_data_b),
> +	SH_PFC_PIN_GROUP(hscif0_ctrl_a),
> +	SH_PFC_PIN_GROUP(hscif0_ctrl_b),
> +	SH_PFC_PIN_GROUP(hscif1_ctrl_a),
> +	SH_PFC_PIN_GROUP(hscif1_ctrl_b),
> +	SH_PFC_PIN_GROUP(hscif0_clk_a),
> +	SH_PFC_PIN_GROUP(hscif1_clk_a),
> +	SH_PFC_PIN_GROUP(hscif1_clk_b),
> +};
> +
> +static const char * const scif0_groups[] = {
> +	"scif0_data_a",
> +	"scif0_data_b",
> +	"scif0_data_c",
> +	"scif0_data_d",
> +	"scif0_ctrl",
> +	"scif0_clk",
> +};
> +
> +static const char * const scif1_groups[] = {
> +	"scif1_data_a",
> +	"scif1_data_b",
> +	"scif1_data_c",
> +	"scif1_data_d",
> +	"scif1_ctrl_a",
> +	"scif1_ctrl_c",
> +	"scif1_clk_a",
> +	"scif1_clk_c",
> +};
> +
> +static const char * const scif2_groups[] = {
> +	"scif2_data_a",
> +	"scif2_data_b",
> +	"scif2_data_c",
> +	"scif2_data_d",
> +	"scif2_data_e",
> +	"scif2_clk_a",
> +	"scif2_clk_b",
> +	"scif2_clk_c",
> +};
> +
> +static const char * const scif3_groups[] = {
> +	"scif3_data_a",
> +	"scif3_data_b",
> +	"scif3_data_c",
> +	"scif3_data_d",
> +};
> +
> +static const char * const scif4_groups[] = {
> +	"scif4_data_a",
> +	"scif4_data_b",
> +	"scif4_data_c",
> +};
> +
> +static const char * const scif5_groups[] = {
> +	"scif5_data_a",
> +	"scif5_data_b",
> +};
> +
> +static const char * const scif_clk_groups[] = {
> +	"scif_clk",
> +};
> +
> +static const char * const hscif0_groups[] = {
> +	"hscif0_data_a",
> +	"hscif0_data_b",
> +	"hscif0_ctrl_a",
> +	"hscif0_ctrl_b",
> +	"hscif0_clk_a",
> +};
> +
> +static const char * const hscif1_groups[] = {
> +	"hscif1_data_a",
> +	"hscif1_data_b",
> +	"hscif1_ctrl_a",
> +	"hscif1_ctrl_b",
> +	"hscif1_clk_a",
> +	"hscif1_clk_b",
> +};
> +
> +static const struct sh_pfc_function pinmux_functions[] = {
> +	SH_PFC_FUNCTION(scif0),
> +	SH_PFC_FUNCTION(scif1),
> +	SH_PFC_FUNCTION(scif2),
> +	SH_PFC_FUNCTION(scif3),
> +	SH_PFC_FUNCTION(scif4),
> +	SH_PFC_FUNCTION(scif5),
> +	SH_PFC_FUNCTION(scif_clk),
> +	SH_PFC_FUNCTION(hscif0),
> +	SH_PFC_FUNCTION(hscif1),
> +};

-- 
Regards,

Laurent Pinchart

