From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Sep 2015 00:31:22 +0000
Subject: Re: [PATCH][RFC] arm64: renesas: Add EXTAL configuration to Salvator-X
Message-Id: <20150909003121.GA15475@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150908044957.4919.98690.sendpatchset@little-apple>
In-Reply-To: <20150908044957.4919.98690.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 08, 2015 at 01:49:57PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Configure EXTAL to 16.666 MHz on Salvator-X.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  This sets the EXTAL frequency for the V9 integration series:
>  [PATCH v9 00/07][RFC] Renesas R-Car H3 (r8a7795) integration patches V9
> 
>  To be used with the V7 CPG:
>  [PATCH v7 00/05] Renesas R-Car Gen3 CPG support V7

Thanks,

I have pushed this patch to the renesas tree in a new topic branch, 
topic/arm64-rcar-gen3-v9.plus, which is based on topic/arm64-rcar-gen3-v9.

I am assuming you will include this in/squash this into the next posting of
"Renesas R-Car H3 (r8a7795) integration patches".


Disclaimer: To be quite clear none of these patches are queued up for
mainline yet and as such they are not included in the next or devel
branches of the renesas tree.

