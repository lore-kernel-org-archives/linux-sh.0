From: Rob Herring <robh@kernel.org>
Date: Mon, 11 Jul 2016 14:02:12 +0000
Subject: Re: [PATCH v5 19/22] sh: IO-DATA HDL-U (a.k.a landisk) IRQCHIP driver
Message-Id: <20160711140212.GA21332@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <1467564402-2649-20-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467564402-2649-20-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 04, 2016 at 01:46:39AM +0900, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../interrupt-controller/iodata-landisk.txt        | 31 ++++++++++
>  drivers/irqchip/Makefile                           |  2 +-
>  drivers/irqchip/irq-io-landisk.c                   | 72 ++++++++++++++++++++++
>  3 files changed, 104 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
>  create mode 100644 drivers/irqchip/irq-io-landisk.c
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt b/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
> new file mode 100644
> index 0000000..cf461dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
> @@ -0,0 +1,31 @@
> +DT bindings for the I/O DATA HDL-U interrupt controller
> +
> +Required properties:
> +
> +  - compatible: has to be "iodata,landisk-intc".
> +
> +  - reg: Base address and length of interrupt controller register.
> +
> +  - #interrupt-cells: has to be <1>: an interrupt index.
> +
> +  - #address-cells: has to be <0>
> +
> +  - interrupt-map: Interrupt mapping on parent controller.
> +
> +Example
> +-------
> +
> +	cpldintc: cpld@b0000000 {
> +		compatible = "iodata,landisk-intc";
> +		#interrupt-cells = <1>;
> +		#address-cells = <0>;
> +		reg = <0xb0000000 8>;
> +		interrupt-map=<0 &shintc evt2irq(0x2a0)>,

What is evt2irq? We only allow simple defines for DT files, not complex 
macros.

Spaces around the '=' also needed.

> +		              <1 &shintc evt2irq(0x2c0)>,
> +		              <2 &shintc evt2irq(0x2e0)>,
> +			      <3 &shintc evt2irq(0x300)>,
> +		              <4 &shintc evt2irq(0x320)>,
> +			      <5 &shintc evt2irq(0x340)>,
> +		              <6 &shintc evt2irq(0x360)>,
> +			      <7 &shintc evt2irq(0x380)>;
> +	};
