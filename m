From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 27 Oct 2009 00:25:25 +0000
Subject: Re: [PATCH] sh_eth: Add asm/cacheflush.h
Message-Id: <20091027002525.GA17085@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <29ab51dc0910261649p2fb22799o5cc70a71dff0f1dd@mail.gmail.com> <20091026.171956.110203653.davem@davemloft.net>
In-Reply-To: <20091026.171956.110203653.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: iwamatsu@nigauri.org, netdev@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, Oct 26, 2009 at 05:19:56PM -0700, David Miller wrote:
> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Date: Tue, 27 Oct 2009 08:49:50 +0900
> 
> > Add include asm/cacheflush.h,  because declaration of __flush_purge_region
> > moved to asm/cacheflush.h.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> 
> Applied, thanks.

Even though Iwamatsu-san didn't specify the kernel version, this is
relevant for 2.6.32 (as that's where we made the change).
