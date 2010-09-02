From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Sep 2010 02:57:25 +0000
Subject: Re: [PATCH] SH: Add missing consts to sys_execve() declaration
Message-Id: <20100902025725.GD10947@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100827013013.13712.88419.stgit@warthog.procyon.org.uk>
In-Reply-To: <20100827013013.13712.88419.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 31, 2010 at 07:05:48PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 16:52 Tue 31 Aug     , David Howells wrote:
> > Add missing consts to the sys_execve() declaration which result in the
> > following error:
> > 
> > arch/sh/kernel/process_32.c:303: error: conflicting types for 'sys_execve'
> > /warthog/nfs/linux-2.6-fscache/arch/sh/include/asm/syscalls_32.h:24: error: previous declaration of 'sys_execve' was here
> I send it too just before :p
> 
And in both cases it has already been fixed in my tree for some time,
presumably Linus was unhappy with my -rc2 changes, so I'll have another
go at breakig things down for -rc4.
