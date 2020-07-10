From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 Jul 2020 14:00:15 +0000
Subject: Re: [PATCH v4 0/2] Fix and enable pmem as RAM device on arm64
Message-Id: <CAPcyv4izHex9W0m3voSXM5J69gFWhHj_a-XsmJ4HF01Uh4jp6w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200710031619.18762-1-justin.he@arm.com>
In-Reply-To: <20200710031619.18762-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jia He <justin.he@arm.com>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux-sh <linux-sh@vger.kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, Masahiro Yamada <masahiroy@kernel.org>, X86 ML <x86@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Kaly Xin <Kaly.Xin@arm.com>, Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, Chuhong Yuan <hslester96@gmail.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Tony Luck <tony.luck@intel.com>, Baoquan He <bhe@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Logan Gunthorpe <logang@deltatee.com>

On Thu, Jul 9, 2020 at 8:17 PM Jia He <justin.he@arm.com> wrote:
>
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

FWIW, I put these patches through a 0-day run overnight and will be
posting them today.
