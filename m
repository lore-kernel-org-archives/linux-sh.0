From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 30 Nov 2009 04:45:39 +0000
Subject: Re: [PATCH] sh: convert /proc/cpu/aligmnent, /proc/cpu/kernel_alignment to seq_file
Message-Id: <20091130044538.GE7217@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091127064216.GD25983@x200.malnet.ru>
In-Reply-To: <20091127064216.GD25983@x200.malnet.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 27, 2009 at 09:42:16AM +0300, Alexey Dobriyan wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  arch/sh/kernel/traps_32.c |   77 ++++++++++++++++++----------------------------
>  1 file changed, 31 insertions(+), 46 deletions(-)
> 
Applied, thanks.
