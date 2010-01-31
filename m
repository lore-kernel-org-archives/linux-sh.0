From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 31 Jan 2010 03:55:40 +0000
Subject: Re: Bug: access to already released memory
Message-Id: <20100131035540.GA13428@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <a328840c1001301356r14505614pbb4563754c6890ac@mail.gmail.com>
In-Reply-To: <a328840c1001301356r14505614pbb4563754c6890ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Jan 30, 2010 at 10:56:30PM +0100, Marek Skuczynski wrote:
>    I have found two places where access to already released memory happens,
>    attaching patches.
> 
I'll apply them for 2.6.33, thanks.

> Subject: [PATCH 2/2] sh: Fix access to released memory in clk_debugfs_register_one()
> 
> Signed-off-by: Marek Skuczynski <mareksk7@gmail.com>
> ---
>  arch/sh/kernel/cpu/clock.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
Note that this code was copied from omap, so you may want to send them a
patch for arch/arm/plat-omap/clock.c, too.
