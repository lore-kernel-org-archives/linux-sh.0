From: Simon Horman <horms@verge.net.au>
Date: Thu, 17 Feb 2011 00:43:42 +0000
Subject: Re: [PATCH 1/2] ARM: mach-shmobile: ap4evb: fixup memory
Message-Id: <20110217004342.GB27179@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <u8wal629z.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u8wal629z.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 15, 2011 at 02:03:46PM +0900, Kuninori Morimoto wrote:
> Current ap4evb had issue which couldn't boot sometimes.
> This patch fixup it.

Hi Morimoto-san,

As per the Mackerel version of this patch,
I have looked over the register changes
and they seem reasonable to me.

I do not have an AP4EB available to test this code at this time.
(I think that the AP4EB that I previously used is sitting on/near
Magnus's desk.)

Reviewed-by: Simon Horman <horms@verge.net.au>
