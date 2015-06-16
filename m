From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 16 Jun 2015 08:12:16 +0000
Subject: Re: [PATCH 0/2] Consolidate redundant register/stack access code
Message-Id: <20150616101216.08a56f1a@mschwide>
List-Id: <linux-sh.vger.kernel.org>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
In-Reply-To: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 15 Jun 2015 12:42:57 -0400
David Long <dave.long@linaro.org> wrote:

> From: "David A. Long" <dave.long@linaro.org>
> 
> Move duplicate and functionally equivalent code for accessing registers
> and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
> common kernel files.
> 
> Note: Help regression testing s390, hexagon, and sh would be appreciated.
>       Powerpc builds but I have not verified the functionality.
> 
> David A. Long (2):
>   Move the pt_regs_offset struct definition from arch to common include
>     file
>   Consolidate redundant register/stack access code

Compiles & boots on a s390 box. The code for regs_query_register_offset
and regs_query_register_name is a bit more complex for s390 compared
to the current state of things. Should be equivalent though.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

