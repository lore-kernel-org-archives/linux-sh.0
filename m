From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 12 Jan 2012 04:11:30 +0000
Subject: Re: [PATCH v3] sh: sh2a: Improve cache flush/invalidate functions
Message-Id: <20120112041130.GB28470@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1326125327-30189-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1326125327-30189-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 09, 2012 at 04:08:47PM +0000, Phil Edworthy wrote:
> The cache functions lock out interrupts for long periods; this patch
> reduces the impact when operating on large address ranges. In such
> cases it will:
> - Invalidate the entire cache rather than individual addresses.
> - Do nothing when flushing the operand cache in write-through mode.
> - When flushing the operand cache in write-back mdoe, index the
>   search for matching addresses on the cache entires instead of the
>   addresses to flush
> 
> Note: sh2a__flush_purge_region was only invalidating the operand
> cache, this adds flush.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v3:
> 1. Refactored code to make it readable and correct formatting.
> 2. Added code to handle flushing large address ranges in
>    write-back mode.
> 
Looks good. Applied, thanks Phil.
