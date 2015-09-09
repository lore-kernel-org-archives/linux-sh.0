From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Sep 2015 00:31:18 +0000
Subject: Re: [PATCH][RFC] arm64: renesas: r8a7795 dtsi: Update common divider clocks
Message-Id: <20150909003118.GC29272@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150908044342.21900.84407.sendpatchset@little-apple>
In-Reply-To: <20150908044342.21900.84407.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 08, 2015 at 01:43:42PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Update the r8a7795 CPG DTS to include pll1_div2. In older r8a7795 CPG
> CCF driver implementations the output of PLL1 was divided by two.
> 
> To support r8a7795 clocks like RPCSRC the PLL1 has now been converted
> to not divide by two in the V7 CPG series, so when that series is used
> we have to divide by two using a fixed divider outside the CPG.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  This fixes the PLL1 output in the V9 integration series:
>  [PATCH v9 00/07][RFC] Renesas R-Car H3 (r8a7795) integration patches V9
> 
>  With this patch V9 integration series below will work with V7 CPG:
>  [PATCH v7 00/05] Renesas R-Car Gen3 CPG support V7
>  1 file changed, 18 insertions(+), 9 deletions(-)

Thanks,

I have pushed this patch to the renesas tree in a new topic branch, 
topic/arm64-rcar-gen3-v9.plus, which is based on topic/arm64-rcar-gen3-v9.

I am assuming you will include this in/squash this into the next posting of
"Renesas R-Car H3 (r8a7795) integration patches".

Disclaimer: To be quite clear none of these patches are queued up for
mainline yet and as such they are not included in the next or devel
branches of the renesas tree.
