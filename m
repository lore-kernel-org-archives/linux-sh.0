From: Simon Horman <horms@verge.net.au>
Date: Tue, 17 Nov 2015 19:09:18 +0000
Subject: Re: [PATCH v2 00/03] ARM: shmobile: r8a7794 ALT board DU VGA port enablement V2
Message-Id: <20151117190915.GK23979@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20151116085703.7119.2518.sendpatchset@little-apple>
In-Reply-To: <20151116085703.7119.2518.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 16, 2015 at 05:57:03PM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a7794 ALT board DU VGA port enablement V2
> 
> [PATCH v2 01/03] ARM: shmobile: r8a7794: Add DU0 clock
> [PATCH v2 02/03] ARM: shmobile: r8a7794: Add DU node to device tree
> [PATCH v2 03/03] ARM: shmobile: r8a7794: alt: Enable VGA port
> 
> These patches enable VGA port support for the r8a7794 ALT board. No
> special merge time dependencies exist, however for correct run time
> operation v4.4-rc1 is recommended and in particular the patch
> "drm: rcar-du: Add support for the R8A7794 DU".
> 
> Tested with the modetest utility on the r8a7794 ALT board.
> # modetest -M rcar-du -c
> # modetest -M rcar-du -s 33:1024x768@AR24
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks, I have queued these up for v4.5.
