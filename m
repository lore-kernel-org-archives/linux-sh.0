From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 03 Dec 2010 05:44:54 +0000
Subject: Re: [PATCH] sh: se/7724: Update clock framework of FSI clock to non-legacy
Message-Id: <20101203054454.GA824@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1291354674-13100-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1291354674-13100-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 03, 2010 at 02:37:53PM +0900, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
>  arch/sh/boards/mach-se/7724/setup.c |   33 ++++-----------------------------
>  1 files changed, 4 insertions(+), 29 deletions(-)

On Fri, Dec 03, 2010 at 02:37:54PM +0900, Nobuhiro Iwamatsu wrote:
> se7724 board does not have FSI/B.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
>  arch/sh/boards/mach-se/7724/setup.c |   10 +---------
>  1 files changed, 1 insertions(+), 9 deletions(-)

Both applied, thanks.
