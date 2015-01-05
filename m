From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 05 Jan 2015 20:40:25 +0000
Subject: Re: [PATCH v3] clk-rcar-gen2: RCAN clock support
Message-Id: <54AAF6B9.6050703@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1678262.gW7XrkflEf@wasted.cogentembedded.com>
In-Reply-To: <1678262.gW7XrkflEf@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mturquette@linaro.org, linux-kernel@vger.kernel.org, sboyd@codeaurora.org
Cc: linux-sh@vger.kernel.org, vksavl@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org

Hello.

On 01/05/2015 11:10 PM, Sergei Shtylyov wrote:

> Add the RCAN clock support to the R-Car generation 2 CPG driver.  This clock
> gets derived from  the USB_EXTAL clock, dividing  it by 6.  The layout of the
> RCANCKCR register is similar to those of the clocks supported by the 'clk-div6'
> driver but has no divider field, and so can't be supported by that driver...

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

> Index: renesas/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
> =================================> --- renesas.orig/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
> +++ renesas/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt

    It should have been against Mike's tree. And forgot to add Geert's ACK. 
Ignore this one, I'll repost.

WBR, Sergei

