From: David Hildenbrand <david@redhat.com>
Date: Thu, 09 Jul 2020 09:18:57 +0000
Subject: Re: [PATCH v3 4/6] mm: don't export memory_add_physaddr_to_nid in arch specific directory
Message-Id: <49a53674-f246-fdd6-009b-447a88cdb68e@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200709020629.91671-1-justin.he@arm.com>
 <20200709020629.91671-5-justin.he@arm.com>
 <20200709021104.GZ25523@casper.infradead.org>
 <20200709091815.GF781326@linux.ibm.com>
In-Reply-To: <20200709091815.GF781326@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jia He <justin.he@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, Kaly Xin <Kaly.Xin@arm.com>, Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, Chuhong Yuan <hslester96@gmail.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>, Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Logan Gunthorpe <logang@deltatee.com>

On 09.07.20 11:18, Mike Rapoport wrote:
> On Thu, Jul 09, 2020 at 03:11:04AM +0100, Matthew Wilcox wrote:
>> On Thu, Jul 09, 2020 at 10:06:27AM +0800, Jia He wrote:
>>> After a general version of __weak memory_add_physaddr_to_nid implemented
>>> and exported , it is no use exporting twice in arch directory even if
>>> e,g, ia64/x86 have their specific version.
>>>
>>> This is to suppress the modpost warning:
>>> WARNING: modpost: vmlinux: 'memory_add_physaddr_to_nid' exported twice.
>>> Previous export was in vmlinux
>>
>> It's bad form to introduce a warning and then send a follow-up patch to
>> fix the warning.  Just fold this patch into patch 1/6.
> 
> Moreover, I think that patches 1-4 can be merged into one.
> 

+1

-- 
Thanks,

David / dhildenb
