From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Tue, 31 Aug 2010 17:05:48 +0000
Subject: Re: [PATCH] SH: Add missing consts to sys_execve() declaration
Message-Id: <20100831170548.GB22790@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100827013013.13712.88419.stgit@warthog.procyon.org.uk>
In-Reply-To: <20100827013013.13712.88419.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 16:52 Tue 31 Aug     , David Howells wrote:
> Add missing consts to the sys_execve() declaration which result in the
> following error:
> 
> arch/sh/kernel/process_32.c:303: error: conflicting types for 'sys_execve'
> /warthog/nfs/linux-2.6-fscache/arch/sh/include/asm/syscalls_32.h:24: error: previous declaration of 'sys_execve' was here
I send it too just before :p

Best Regards,
J.
