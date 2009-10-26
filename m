From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Oct 2009 01:01:06 +0000
Subject: Re: [PATCH] sh: Build fix: define more __movmem* symbols
Message-Id: <20091026010106.GC6108@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1256212717-14858-1-git-send-email-lkundrak@v3.sk>
In-Reply-To: <1256212717-14858-1-git-send-email-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 22, 2009 at 01:58:37PM +0200, Lubomir Rintel wrote:
> ERROR: "__movmemSI12" [net/unix/unix.ko] undefined!
> ERROR: "__movmemSI52" [net/ipv6/sit.ko] undefined!
> ERROR: "__movmemSI24" [net/ipv6/ipv6.ko] undefined!
> ERROR: "__movmemSI60" [net/ipv6/ipv6.ko] undefined!
> ERROR: "__movmemSI16" [net/ipv6/ipv6.ko] undefined!
> ERROR: "__movmemSI20" [net/ipv6/ipv6.ko] undefined!
> ERROR: "__movmemSI32" [net/ipv6/ipv6.ko] undefined!
> ---
>  arch/sh/kernel/sh_ksyms_32.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
Applied to the 2.6.32 queue, thanks.
