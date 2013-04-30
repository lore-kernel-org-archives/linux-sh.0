From: Simon Horman <horms@verge.net.au>
Date: Tue, 30 Apr 2013 02:08:22 +0000
Subject: Re: [PATCH] ARM: shmobile: sh73a0: Use DEFINE_RES_MEM*() everywhere
Message-Id: <20130430020822.GA5021@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1366684035-6882-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1366684035-6882-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Apr 23, 2013 at 11:27:15AM +0900, Simon Horman wrote:
> Convert code to use DEFINE_RES_MEM*() macros.
> These macros were already used in this file,
> this change makes their usage consistent throughout the file.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> v2
> * As suggested by Sergei Shtylyov:
>   Correct change log to refer to DEFINE_RES_MEM* instead of
>   IORESOURCE_MEM_*.

Queued-up for v3.11 in the soc-sh73a0 branch.
