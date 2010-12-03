From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 03 Dec 2010 04:31:35 +0000
Subject: Re: [PATCH 2/2] sh: se/7724: Update clock of FSI to non-legacy
Message-Id: <20101203043135.GA32384@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1291349817-3077-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1291349817-3077-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 03, 2010 at 01:16:57PM +0900, Nobuhiro Iwamatsu wrote:
> Current FSI clock of ecovec uses legacy clock.
> This update to non-legacy.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
>  arch/sh/boards/mach-se/7724/setup.c |   16 ++++++++++++++--
>  1 files changed, 14 insertions(+), 2 deletions(-)
> 
For ecovec and 7724 clock framework we already have the patch from
Morimoto-san queued up, perhaps se7724 needs the same fix?

	http://git.kernel.org/?p=linux/kernel/git/lethal/sh-2.6.git;a=commitdiff;hKd5d259e451d35380de2fcd1a3510ae22d000a3
