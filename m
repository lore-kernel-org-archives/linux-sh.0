From: Rob Herring <robh@kernel.org>
Date: Tue, 14 Jun 2016 22:24:38 +0000
Subject: Re: [PATCH v2 17/17] sh: landisk CPLD interrupt controller driver
Message-Id: <20160614222438.GA30320@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1465714475-24111-18-git-send-email-ysato@users.sourceforge.jp>
 <1465717454-7606-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465717454-7606-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Sun, Jun 12, 2016 at 04:44:14PM +0900, Yoshinori Sato wrote:
> Sorry. I send old patches.
> Please ignore previous files.

same comment here.

> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../interrupt-controller/iodata-landisk.txt        | 28 +++++++++
>  drivers/irqchip/irq-io-landisk.c                   | 72 ++++++++++++++++++++++
>  2 files changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
>  create mode 100644 drivers/irqchip/irq-io-landisk.c
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt b/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
> new file mode 100644
> index 0000000..d398538
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
> @@ -0,0 +1,28 @@
> +DT bindings for the I/O DATA HDL-U interrupt controller
> +
> +Required properties:
> +
> +  - compatible: has to be "iodata,landisk-intc".
> +
> +  - reg: Base address and length of interrupt controller register.
> +
> +  - interrupt-controller: Identifies the node as an interrupt controller.
> +
> +  - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined
> +    in interrupts.txt in this directory.
> +
> +  - interrupt-map: Interrupt mapping on parent controller.
> +
> +Example
> +-------
> +
> +	cpldintc: cpld@b0000000 {
> +		compatible = "iodata,landisk-intc";
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		reg = <0xb0000000 8>;
> +		interrupt-map=<0 &shintc 0 0>, <1 &shintc 1 0>,
> +		              <2 &shintc 2 0>, <3 &shintc 3 0>,
> +		              <4 &shintc 4 0>, <5 &shintc 5 0>,
> +		              <6 &shintc 6 0>, <7 &shintc 7 0>;

This is not right. Since this node has 2 interrupt-cells, you need 2 
entries for the child-interrupt specifier. You also need to set 
#address-cells to 0 and set the mask to mask out the 2nd cell.

Then again, there is not any real translation happening here, so perhaps 
you don't need this at all.

Rob
