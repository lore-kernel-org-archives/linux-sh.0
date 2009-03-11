From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 11 Mar 2009 08:27:01 +0000
Subject: Re: [PATCH] sh: ap325 and Migo-R use new sh_mobile_ceu_info flags
Message-Id: <20090311082701.GB6281@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uprgoplg4.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uprgoplg4.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 11, 2009 at 04:20:32PM +0900, Kuninori Morimoto wrote:
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> > Paul
> this patch is for linux 2.6.30
> 
>  arch/sh/boards/board-ap325rxa.c   |    4 +---
>  arch/sh/boards/mach-migor/setup.c |    4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
This seems to depend on some stuff in the v4l tree that well presumably
be merged during the merge window, so I'll apply this once those changes
hit mainline.
