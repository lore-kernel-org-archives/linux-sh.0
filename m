From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 05 Oct 2018 16:32:51 +0000
Subject: Re: [PATCH 3/5] arm64: mm: make use of new memblocks_present() helper
Message-Id: <20181005163248.naky3huexiiwycra@mbp>
List-Id: <linux-sh.vger.kernel.org>
References: <20181005161642.2462-1-logang@deltatee.com>
 <20181005161642.2462-4-logang@deltatee.com>
In-Reply-To: <20181005161642.2462-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Oct 05, 2018 at 10:16:40AM -0600, Logan Gunthorpe wrote:
> Cleanup the arm64_memory_present() function seeing it's very
> similar to other arches.
> 
> memblocks_present() is a direct replacement of arm64_memory_present()
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  arch/arm64/mm/init.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
