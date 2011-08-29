From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Aug 2011 07:24:49 +0000
Subject: Re: [PATCH 1/2] sh: Fix unaligned memory access for branches without delay slots
Message-Id: <20110829072449.GE31809@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1314028568-7571-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1314028568-7571-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 22, 2011 at 04:56:08PM +0100, Phil Edworthy wrote:
> This patch just clears the return code for those cases where an
> unaligned memory access occurs on branch instructions without a
> delay slot.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

On Wed, Aug 24, 2011 at 11:43:59AM +0100, Phil Edworthy wrote:
> This adds unaligned memory access support for the following instructions:
>   mov.w @(disp,PC),Rn
>   mov.l @(disp,PC),Rn
> 
> These instructions are often used on SH2A toolchains.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v3:
>   Fixed the PC relative address calculation
> v2:
>   Fixed the mov.l case for big endian
>   Fixed typo in commit msg
> 
>  arch/sh/kernel/traps_32.c |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)
> 
Both applied, thanks.
