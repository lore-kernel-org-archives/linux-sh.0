From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 17 Dec 2012 00:54:58 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: Armadillo800eva: DT boot testcase with ethernet support
Message-Id: <87txrlijkv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87bok7lm0h.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bok7lm0h.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Bastian

> This patch strips off most of the board code. We only keep the GPIO
> configurations used for the ethernet module sh_eth. We add the ethernet
> controller in the DT config file r8a7740-armadillo800eva.dts and make
> sure that clocks are turned on working with the different naming scheme
> for devices when using DT instead of the old platform code.
> 
> Never-signed-off-by: Bastian Hecht <hechtb@gmail.com>
> ---
(snip)
> -/*
> - * CON1		Camera Module
> - * CON2		Extension Bus
> - * CON3		HDMI Output
> - * CON4		Composite Video Output
> - * CON5		H-UDI JTAG
> - * CON6		ARM JTAG
> - * CON7		SD1
> - * CON8		SD2
> - * CON9		RTC BackUp
> - * CON10	Monaural Mic Input
> - * CON11	Stereo Headphone Output
> - * CON12	Audio Line Output(L)
> - * CON13	Audio Line Output(R)
> - * CON14	AWL13 Module
> - * CON15	Extension
> - * CON16	LCD1
> - * CON17	LCD2
> - * CON19	Power Input
> - * CON20	USB1
> - * CON21	USB2
> - * CON22	Serial
> - * CON23	LAN
> - * CON24	USB3
> - * LED1		Camera LED(Yellow)
> - * LED2		Power LED (Green)
> - * ED3-LED6	User LED(Yellow)
> - * LED7		LAN link LED(Green)
> - * LED8		LAN activity LED(Yellow)
> - */
> -
> -/*
> - * DipSwitch
> - *
> - *                    SW1
> - *
> - * -12345678-+---------------+----------------------------
> - *  1        | boot          | hermit
> - *  0        | boot          | OS auto boot
> - * -12345678-+---------------+----------------------------
> - *   00      | boot device   | eMMC
> - *   10      | boot device   | SDHI0 (CON7)
> - *   01      | boot device   | -
> - *   11      | boot device   | Extension Buss (CS0)
> - * -12345678-+---------------+----------------------------
> - *     0     | Extension Bus | D8-D15 disable, eMMC enable
> - *     1     | Extension Bus | D8-D15 enable,  eMMC disable
> - * -12345678-+---------------+----------------------------
> - *      0    | SDHI1         | COM8 disable, COM14 enable
> - *      1    | SDHI1         | COM8 enable,  COM14 disable
> - * -12345678-+---------------+----------------------------
> - *       0   | USB0          | COM20 enable,  COM24 disable
> - *       1   | USB0          | COM20 disable, COM24 enable
> - * -12345678-+---------------+----------------------------
> - *        00 | JTAG          | SH-X2
> - *        10 | JTAG          | ARM
> - *        01 | JTAG          | -
> - *        11 | JTAG          | Boundary Scan
> - *-----------+---------------+----------------------------
> - */
> -
> -/*
> - * FSI-WM8978
> - *
> - * this command is required when playback.
> - *
> - * # amixer set "Headphone" 50
> - */

Please keep these comments.
it is very important information for users.
