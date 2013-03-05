From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 05 Mar 2013 04:27:20 +0000
Subject: Re: [RFC][PATCH] ARM: shmobile: bockw: Reference DT implementation
Message-Id: <CANqRtoT07meOckc=f7XWtTZQYehToqe+_EMRky3a7m-7Hn2YzQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppzfpr3b.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ppzfpr3b.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 4, 2013 at 4:22 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> I'm trying to support R-Car M1 Bock-W DT, but it still doesn't work.
> (There is no output when I boot it)
> Your feedback is very helpful for me...

Morimoto-san, perhaps you should aim slightly lower to get DT going?

> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
> @@ -0,0 +1,41 @@
> +/*
> + * Reference Device Tree Source for the Bock-W board
> + *
> + * Copyright (C) 2013  Renesas Solutions Corp.
> + * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + *
> + * based on r8a7779
> + *
> + * Copyright (C) 2013 Renesas Solutions Corp.
> + * Copyright (C) 2013 Simon Horman
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +/include/ "r8a7778.dtsi"
> +
> +/ {
> +       model = "bockw";
> +       compatible = "renesas,bockw-reference", "renesas,r8a7778";
> +
> +       chosen {
> +               bootargs = "console=ttySC0,115200 earlyprintk=sh-sci.0,115200 ignore_loglevel root=/dev/nfs ip=on";
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x60000000 0x40000000>;
> +       };
> +
> +       lan0@18000000 {
> +               compatible = "smsc,lan9220", "smsc,lan9115";
> +               reg = <0x18300000 0x100>;
> +               phy-mode = "mii";
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 0x3b 0x4>;
> +               reg-io-width = <4>;
> +       };

You want to use the external IRQ pin interrupt here, not the GIC.

Thanks,

/ magnus
