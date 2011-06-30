From: Simon Horman <horms@verge.net.au>
Date: Thu, 30 Jun 2011 10:34:08 +0000
Subject: Re: [PATCH 2/2] ARM: mach-shmobile: ag5evm: fixup compile error
Message-Id: <20110630103406.GA15940@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20101119131112.45efa0dc.yoshii.takashi@gmail.com>
In-Reply-To: <20101119131112.45efa0dc.yoshii.takashi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 30, 2011 at 12:30:55AM -0700, Kuninori Morimoto wrote:
> ag5evm compile will be error if it doesn't have CONFIG_I2C.
> this patch fixup it.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This does what is says on the wrapper.

Tested-by: Simon Horman <horms@verge.net.au>
