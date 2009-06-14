From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 14 Jun 2009 08:46:11 +0000
Subject: Re: [PATCH 1/3] sh: pci: remove duplicated #include's
Message-Id: <20090614084611.GC832@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1244895671-2840-1-git-send-email-weiyi.huang@gmail.com>
In-Reply-To: <1244895671-2840-1-git-send-email-weiyi.huang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Jun 13, 2009 at 08:21:11PM +0800, Huang Weiyi wrote:
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
> ---
>  arch/sh/boards/mach-se/7780/irq.c   |    1 -
>  arch/sh/drivers/pci/ops-dreamcast.c |    1 -
>  2 files changed, 0 insertions(+), 2 deletions(-)
> 
Applied, thanks.
