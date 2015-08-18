From: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 18 Aug 2015 10:43:30 +0000
Subject: Re: [v2, 1/2] Move the pt_regs_offset struct definition from arch to common include file
Message-Id: <20150818104330.B24DC14032B@ozlabs.org>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <1437971974-2434-2-git-send-email-dave.long@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 2015-27-07 at 04:39:33 UTC, "David A. Long" wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> The pt_regs_offset structure is used for the HAVE_REGS_AND_STACK_ACCESS_API
> feature and has identical definitions in four different arch ptrace.h
> include files. It seems unlikely that definition would ever need to be
> changed regardless of architecture so lets move it into
> include/linux/ptrace.h, along with macros commonly used to access it.

Thanks for cleaning this up. Tested successfully on powerpc.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
