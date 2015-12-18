From: Simon Horman <horms@verge.net.au>
Date: Fri, 18 Dec 2015 03:20:12 +0000
Subject: Re: [PATCH 0/7] ARM: shmobile: dtsi: Add SCIF fallback compatibility strings
Message-Id: <20151218032011.GA9704@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1450119475-1183-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1450119475-1183-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Dec 14, 2015 at 07:57:48PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds fallback compatibility strings for SCIF and HSCIF
> to the DTS files for R-Car Gen1, Gen2, and Gen3, as defined in
> "[PATCH v3 02/27] serial: sh-sci: Add fallback compatibility strings" of
> series "[PATCH v3 00/27] serial: sh-sci: External Clock Support".
> This will allow the sh-sci driver to match on family-specific compatible
> values to enable BGR support later.
> 
> Note that fallback compatibility strings for SCIFA/SCIFB are not added
> yet.
> 
> Dependencies:
>   - This series is against renesas-devel-20151214-v4.4-rc5,
>   - It can be applied independently, as soon as the aforementioned DT
>     binding patch has been accepted,
>   - Later series depend on this:
>       - "[PATCH v3 00/12] ARM: shmobile: dtsi: Rename the serial port
> 	 clock to fck",
>       - "[PATCH v2 0/7] ARM: shmobile: dtsi: Add BRG support for (H)SCIF",
>       - "[PATCH v2 0/9] ARM: shmobile: dts: Enable SCIF_CLK frequency and
> 	 pins".

I have marked this and the above series as deferred pending
acceptance of the driver changes.
