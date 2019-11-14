From: Michael Ellerman <patch-notifications@ellerman.id.au>
Date: Thu, 14 Nov 2019 09:07:36 +0000
Subject: Re: [PATCH net-next] defconfigs: remove obsolete CONFIG_INET_XFRM_MODE_* and CONFIG_INET6_XFRM_MODE_
Message-Id: <47DFxN5pWqz9sP6@ozlabs.org>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <20190612071901.21736-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YueHaibing <yuehaibing@huawei.com>, linux@armlinux.org.uk, fw@strlen.de, steffen.klassert@secunet.com, davem@davemloft.net, ralf@linux-mips.org, paul.burton@mips.com
Cc: linux-s390@vger.kernel.org, linux-aspeed@lists.ozlabs.org, linux-sh@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Wed, 2019-06-12 at 07:19:01 UTC, YueHaibing wrote:
> These Kconfig options has been removed in
> commit 4c145dce2601 ("xfrm: make xfrm modes builtin")
> So there is no point to keep it in defconfigs any longer.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/93a1544ad4ec4bd9147992e57b4f834ceb2cc159

cheers
