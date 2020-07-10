From: David Hildenbrand <david@redhat.com>
Date: Fri, 10 Jul 2020 08:30:04 +0000
Subject: Re: [PATCH v4 0/2] Fix and enable pmem as RAM device on arm64
Message-Id: <23e79097-6517-a301-b0da-4d5505de3d3f@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200710031619.18762-1-justin.he@arm.com>
In-Reply-To: <20200710031619.18762-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jia He <justin.he@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: Kaly Xin <Kaly.Xin@arm.com>, Michal Hocko <mhocko@suse.com>, Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, Chuhong Yuan <hslester96@gmail.com>, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-ia64@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Logan Gunthorpe <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org

On 10.07.20 05:16, Jia He wrote:
> This fixies a few issues when I tried to enable pmem as RAM device on arm64.
> 
> To use memory_add_physaddr_to_nid as a fallback nid, it would be better
> implement a general version (__weak) in mm/memory_hotplug. After that, arm64/
> sh/s390 can simply use the general version, and PowerPC/ia64/x86 will use
> arch specific version.
> 
> Tested on ThunderX2 host/qemu "-M virt" guest with a nvdimm device. The
> memblocks from the dax pmem device can be either hot-added or hot-removed
> on arm64 guest. Also passed the compilation test on x86.
> 
> Changes:
> v4: - remove "device-dax: use fallback nid when numa_node is invalid", wait
>       for Dan Williams' phys_addr_to_target_node() patch

So, this series no longer does what it promises? "Fix and enable pmem as
RAM device on arm64"

-- 
Thanks,

David / dhildenb
