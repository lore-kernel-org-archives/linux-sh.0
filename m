From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Sep 2010 08:31:11 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: pfc-sh7372: modify wrong comment
Message-Id: <20100914083111.GK7336@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p62yooblk.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p62yooblk.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 02, 2010 at 04:20:40PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/pfc-sh7372.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

On Fri, Sep 03, 2010 at 02:36:43PM +0900, Kuninori Morimoto wrote:
> Add ignored device name by comment-out in INTCS.
> And MSIOF which has been forgotten is added

On Tue, Sep 07, 2010 at 11:05:30AM +0900, Kuninori Morimoto wrote:
> Current touchpanel had below 2 issues
> 
> - LCDD2 pin which is needed for WVGA was changed to
>   IRQ28_123 pin on ts_get_pendown_state
> 
> - GPIO pull up on ts_init was disabled by gpio_request
>   on ts_get_pendown_state.
>   This mean the return value from gpio_get_value is untrusted.
> 
> This patch solve these issues

Applied, thanks.
