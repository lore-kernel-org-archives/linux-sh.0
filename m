From: Simon Horman <horms@verge.net.au>
Date: Tue, 09 Dec 2014 00:39:47 +0000
Subject: Re: [PATCH] ARM: shmobile: Enable MICREL_PHY in shmobile_defconfig
Message-Id: <20141209003946.GF8897@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1418038524-27990-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1418038524-27990-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 08, 2014 at 12:35:24PM +0100, Geert Uytterhoeven wrote:
> commit 1c9106cb783cd227 ("ARM: shmobile: lager-reference: DTS-only board
> support"), dropped the MACH_LAGER Kconfig section, which did "select
> MICREL_PHY if SH_ETH". Hence we now have to enable MICREL_PHY explicitly
> in shmobile_defconfig.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
