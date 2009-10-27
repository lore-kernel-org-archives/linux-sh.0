From: David Miller <davem@davemloft.net>
Date: Tue, 27 Oct 2009 00:19:56 +0000
Subject: Re: [PATCH] sh_eth: Add asm/cacheflush.h
Message-Id: <20091026.171956.110203653.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <29ab51dc0910261649p2fb22799o5cc70a71dff0f1dd@mail.gmail.com>
In-Reply-To: <29ab51dc0910261649p2fb22799o5cc70a71dff0f1dd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iwamatsu@nigauri.org
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, lethal@linux-sh.org

From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Tue, 27 Oct 2009 08:49:50 +0900

> Add include asm/cacheflush.h,  because declaration of __flush_purge_region
> moved to asm/cacheflush.h.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Applied, thanks.
