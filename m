From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 11 Mar 2009 08:30:19 +0000
Subject: Re: [PATCH] sh: break out vbr register code
Message-Id: <20090311083019.GF6281@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090311081852.2041.19566.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090311081852.2041.19566.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 11, 2009 at 05:18:52PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Add set_vbr_register(), get_vbr_register() and vbr_base
> to system.h.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  This register needs to be modified by the suspend code
>  as well, so break it out.
> 
Let's just open code the instruction instead, there is not much point in
having wrapper for a single instruction..

>  arch/sh/include/asm/system.h |   19 +++++++++++++++++++
>  arch/sh/kernel/traps_32.c    |   13 ++-----------
>  2 files changed, 21 insertions(+), 11 deletions(-)
> 
It can't be in system.h anyways, since SH-5 also uses this file.
