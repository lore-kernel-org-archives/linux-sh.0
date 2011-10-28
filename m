From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 28 Oct 2011 06:05:59 +0000
Subject: Re: [PATCH] sh: kexec: Add PHYSICAL_START
Message-Id: <20111028060559.GB32187@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 15, 2011 at 08:13:00PM +0900, Simon Horman wrote:
> Add PHYSICAL_START kernel configuration parameter to set the address at
> which the kernel should be loaded.
> 
> It has been observed on an sh7757lcr that simply modifying MEMORY_START
> does not achieve this goal for 32bit sh. This is due to MEMORY_OFFSET in
> arch/sh/kernel/vmlinux.lds.S bot being based on MEMORY_START on such
> systems.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>

No one seems to have complained about this, so I've applied it.
