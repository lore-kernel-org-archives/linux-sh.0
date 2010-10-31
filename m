From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 31 Oct 2010 14:54:50 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ap4evb: Add HDMI sound support
Message-Id: <20101031145450.GB6955@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 18, 2010 at 07:13:05PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> This patch is depend on my FSIDIV support patch and ALSA tree
> 
>  arch/arm/mach-shmobile/board-ap4evb.c |   46 ++++++++++++++++++++++++++++++++-
>  1 files changed, 45 insertions(+), 1 deletions(-)
> 
Ok, I've now applied this and the FSIDIV patch. It all builds ok, but you
may wish to doublecheck to make sure nothing got overlooked.
