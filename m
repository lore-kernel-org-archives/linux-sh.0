From: Matthew Wilcox <willy@infradead.org>
Date: Thu, 09 Jul 2020 02:11:04 +0000
Subject: Re: [PATCH v3 4/6] mm: don't export memory_add_physaddr_to_nid in arch specific directory
Message-Id: <20200709021104.GZ25523@casper.infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20200709020629.91671-1-justin.he@arm.com>
 <20200709020629.91671-5-justin.he@arm.com>
In-Reply-To: <20200709020629.91671-5-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jia He <justin.he@arm.com>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-nvdimm@lists.01.org, linux-sh@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Kaly Xin <Kaly.Xin@arm.com>, Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, Chuhong Yuan <hslester96@gmail.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>, Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Logan Gunthorpe <logang@deltatee.com>

On Thu, Jul 09, 2020 at 10:06:27AM +0800, Jia He wrote:
> After a general version of __weak memory_add_physaddr_to_nid implemented
> and exported , it is no use exporting twice in arch directory even if
> e,g, ia64/x86 have their specific version.
> 
> This is to suppress the modpost warning:
> WARNING: modpost: vmlinux: 'memory_add_physaddr_to_nid' exported twice.
> Previous export was in vmlinux

It's bad form to introduce a warning and then send a follow-up patch to
fix the warning.  Just fold this patch into patch 1/6.
