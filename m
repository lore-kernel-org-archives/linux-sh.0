From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 16 Aug 2010 04:55:29 +0000
Subject: Re: [PATCH] sh: fix recursive dependency in Kconfig
Message-Id: <20100816045529.GB8817@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100814122339.GA26739@merkur.ravnborg.org>
In-Reply-To: <20100814122339.GA26739@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Aug 14, 2010 at 02:23:39PM +0200, Sam Ravnborg wrote:
> When executing:
> 
>    make ARCH=sh defconfig
> 
> kconfig segfaulted.
> kconfig should obviously not segfault.
> 
> But this indicated a problem in the sh files which was
> tracked down to a recursive dependency.
> 
> We select HAVE_HW_BREAKPOINT and in the following line
> we use the same symbol in an expression.
> Drop the conditional as it is of no use.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Michal Marek <mmarek@suse.cz>

Applied, thanks.
