From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 15 Feb 2008 07:56:59 +0000
Subject: Re: needs writeback on ptrace
Message-Id: <20080215075659.GA23834@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080215.095254.68562685.saito@densan.co.jp>
In-Reply-To: <20080215.095254.68562685.saito@densan.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 15, 2008 at 04:40:03PM +0900, Hideo Saito wrote:
> The chang was not effective. If the following code at
> flush_cache_page() in cache-sh4.c is removed, gdb works.
> 
>         if ((address^phys) & alias_mask) {
>                 /* Loop 4K of the D-cache */
>                 flush_cache_4096(
>                         CACHE_OC_ADDRESS_ARRAY | (address & alias_mask),
>                         phys);
>                 /* Loop another 4K of the D-cache */
>                 flush_cache_4096(
>                         CACHE_OC_ADDRESS_ARRAY | (phys & alias_mask),
>                         phys);
>         }
> 
> modified as follows:
>         if (1) {
>             ...
>         }
> 
> I think that the breakpoint should always be written to the physical memory.

What are the values of address, phys, and alias_mask on your platform in
this case?
