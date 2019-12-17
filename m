From: Mike Rapoport <rppt@kernel.org>
Date: Tue, 17 Dec 2019 15:36:52 +0000
Subject: Re: [PATCH 0/2] sh: get rid of __ARCH_USE_5LEVEL_HACK
Message-Id: <20191217153651.GB4094@rapoport-lnx>
List-Id: <linux-sh.vger.kernel.org>
References: <20191217142150.10392-1-rppt@kernel.org>
 <20191217151549.GH1666@brightrain.aerifal.cx>
In-Reply-To: <20191217151549.GH1666@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>

On Tue, Dec 17, 2019 at 10:15:49AM -0500, Rich Felker wrote:
> On Tue, Dec 17, 2019 at 04:21:48PM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Hi,
> > 
> > These patches update the SuperH page table folding/unfolding to take into
> > account the 5th level.
> 
> Is this only for 64-bit/sh5? If so, I'd really like to avoid having
> patch churn that nominally keeps it working, since it doesn't; GCC
> dropped support a long time ago and it was experimental to begin with,
> never appeared in production. Has anyone looked lately at what it
> would take to remove it?

This is a part of a generic cleanup of page table manipulations and removal
of __ARCH_USE_5LEVEL_HACK and the related code from the kernel. So this is
not related to a particular sh variant.
 
> Rich

-- 
Sincerely yours,
Mike.
