From: Simon Horman <horms@verge.net.au>
Date: Tue, 24 Nov 2015 02:53:30 +0000
Subject: Re: [PATCH 00/02] ARM: shmobile: r8a7793 GOSE board HDMI prototype
Message-Id: <20151124025329.GJ21853@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20151116091515.20711.14784.sendpatchset@little-apple>
In-Reply-To: <20151116091515.20711.14784.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Mon, Nov 16, 2015 at 06:15:15PM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a7793 GOSE board HDMI prototype
> 
> [PATCH 01/02] ARM: shmobile: r8a7793: Add DU node to device tree
> [PATCH 02/02] ARM: shmobile: r8a7793: gose: HDMI prototype hack
> 
> These patches include HDMI prototype support for the r8a7793 GOSE board.
> No special merge time dependencies exist, however for correct run time
> operation v4.4-rc1 is recommended and in particular the patch
> "drm: rcar-du: Add support for the R8A7793 DU".
> 
> Tested with the modetest utility on the r8a7793 GOSE board.
> # modetest -M rcar-du -c
> # modetest -M rcar-du -s 33:1280x720@AR24
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

It would help me somewhat if you could prefix prototype patches with
RFC or PATCH/RFC. Thanks.
