From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 05 Oct 2009 02:23:06 +0000
Subject: Re: [PATCH 00/07] sh: SuperH Mobile SDHI changes
Message-Id: <20091005022306.GC3185@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, g.liakhovetski@gmx.de, ian@mnementh.co.uk, akpm@linux-foundation.org

On Fri, Oct 02, 2009 at 11:21:58AM +0900, Magnus Damm wrote:
> sh: SuperH Mobile SDHI changes
> 
> [PATCH 01/07] mfd: Add SuperH Mobile SDHI platform driver 
> [PATCH 02/07] mmc: Add SuperH to the tmio-mmc Kconfig
> [PATCH 03/07] mmc: Remove const from tmio-mmc platform data
> [PATCH 04/07] sh: SDHI platform data to the Migo-R board
> [PATCH 05/07] sh: SDHI platform data to the AP325RXA board
> [PATCH 06/07] sh: SDHI platform data to the SE7724 board
> [PATCH 07/07] sh: SDHI platform data to the kfr2r09 board
> 
> These patches contain the SuperH specific changes needed for
> the tmio-mmc driver to work with SuperH Mobile SDHI hardware.
> 
> The tmio-mmc patch 0001-MMC-hardware-abstraction-for-CNF-area.patch
> by Ian Molton is needed for correct run time behaviour. Without
> this patch the tmio-mmc probe() fails gracefully.
> 
> I suggest merging the series in the SuperH tree. Not sure about
> the best way to merge the patch by Ian.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

At least patch 3/7 depends on Ian's patch being merged first, so there's
little point in merging this series until that hits upstream. So I'll
hold off on this for now.
