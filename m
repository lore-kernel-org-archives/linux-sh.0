From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 19 Aug 2009 10:31:09 +0000
Subject: Re: [PATCH] sh: USB0 resource area fix for ms7724se
Message-Id: <20090819103109.GA30947@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uvdkk64rk.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uvdkk64rk.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 19, 2009 at 09:12:15AM +0900, Kuninori Morimoto wrote:
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> Magnus
> 
> in 15 Apr 2009, "Re: [PATCH 3/6] Add USB support for SH7724"
> you taught me about USB area miss. (do you remember ?)
> I think this is just your mistake. or is there any reason ?
> 
>  arch/sh/boards/mach-se/7724/setup.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

On Wed, Aug 19, 2009 at 07:24:15PM +0900, Kuninori Morimoto wrote:
> This patch also update help comment
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/sh/drivers/dma/Kconfig |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
applied, thanks.
