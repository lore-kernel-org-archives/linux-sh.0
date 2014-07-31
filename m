From: Simon Horman <horms@verge.net.au>
Date: Thu, 31 Jul 2014 00:12:25 +0000
Subject: Re: [PATCH] ARM: shmobile: Use shmobile_init_delay() on APE6EVM
Message-Id: <20140731001221.GA893@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140511231050.19908.86623.sendpatchset@w520>
In-Reply-To: <20140511231050.19908.86623.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 31, 2014 at 08:45:00AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> The r8a73a4 DTS includes CPU Frequency information so
> adjust the APE6EVM board code to use shmobile_init_delay()
> instead of relying on CPU Frequency information included
> in r8a73a4_init_delay() that is specified in C.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Written on top of renesas-devel-v3.16-rc7-20140729 and
>  [PATCH 00/09] ARM: shmobile: Consistent use of shmobile_init_late()

Hi Magnus,

As per my comment on "[PATCH 00/09] ARM: shmobile: Consistent use of
shmobile_init_late()".

These patches seem fine for me but I wonder if you could follow the
convention that has emerged as being dominant for subjects

* Using lowercase for SOC names
* Omitting hyphens from boards names (i.e. bockw)
* Putting the board or soc after "shmobile: " and followed by a ':'.

I have taken the liberty of updating the patch name to the
following and queued up the result:

ARM: shmobile: ape6evm: Use shmobile_init_delay()
