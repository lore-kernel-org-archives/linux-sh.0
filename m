From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 31 Jul 2020 15:28:58 +0000
Subject: Re: [PATCH v3 0/6] Fix and enable pmem as RAM device on arm64
Message-Id: <CAPcyv4iqkuzyU_u+VW1nsaK7tiy+HJtUxLtgAxtfX0aXXcKhfA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200709020629.91671-1-justin.he@arm.com>
In-Reply-To: <20200709020629.91671-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jia He <justin.he@arm.com>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux-sh <linux-sh@vger.kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, Masahiro Yamada <masahiroy@kernel.org>, X86 ML <x86@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Kaly Xin <Kaly.Xin@arm.com>, Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, Chuhong Yuan <hslester96@gmail.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Tony Luck <tony.luck@intel.com>, Baoquan He <bhe@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Logan Gunthorpe <logang@deltatee.com>

On Wed, Jul 8, 2020 at 7:06 PM Jia He <justin.he@arm.com> wrote:
>
> This fixies a few issues when I tried to enable pmem as RAM device on arm64.

What NVDIMM bus driver is being used in this case? The ACPI NFIT
driver? I'm just looking to see if currently deployed
phys_to_target_node() is sufficient, or if this is coming in a new
driver?
