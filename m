From: Simon Horman <horms@verge.net.au>
Date: Mon, 24 Feb 2014 00:28:40 +0000
Subject: Re: [PATCH v2 1/2] ARM: shmobile: r8a7778/r8a7779 dtsi: Improve and correct HSPI bindings
Message-Id: <20140224002837.GA3898@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1392908239-22645-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1392908239-22645-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 20, 2014 at 03:57:18PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Binding documentation:
>   - Add future-proof "renesas,hspi-<soctype>" compatible values,
>   - Add "interrupt-parent", "#address-cells" and "#size-cells" properties,
>   - Add reference to pinctrl documentation,
>   - Add example bindings.
> 
> r8a7778 and r8a7779 dtsi:
>   - Add "renesas,hspi-r8a7778" resp. "renesas,hspi-r8a7779" compatible
>     values,
>   - Correct reference to parent interrupt controller
>     (use "interrupt-parent" instead of "interrupt-controller"),
>   - Add missing "#address-cells" and "#size-cells" properties, which are
>     needed when populating the SPI buses.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [HSPI/BockW]
> Cc: Mark Brown <broonie@linaro.org>
> ---
> v2:
>   - Add Tested-by
>   - List full example compatible properties with soctypes instead of just
>     the soctypes, so checkpatch can validate DTSes.

Thanks, I have queued this up.
