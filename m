From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 30 Sep 2009 06:42:27 +0000
Subject: Re: [PATCH] sh: Build fix: define __movmem
Message-Id: <20090930064227.GA5967@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1254291454-7436-1-git-send-email-lkundrak@v3.sk>
In-Reply-To: <1254291454-7436-1-git-send-email-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 30, 2009 at 08:17:34AM +0200, Lubomir Rintel wrote:
> ERROR: "__movmem" [net/irda/irda.ko] undefined!
> ERROR: "__movmem" [fs/nfsd/nfsd.ko] undefined!
> ERROR: "__movmem" [fs/lockd/lockd.ko] undefined!
> ERROR: "__movmem" [crypto/sha1_generic.ko] undefined!
> ---
>  arch/sh/kernel/sh_ksyms_32.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
Applied, thanks.
