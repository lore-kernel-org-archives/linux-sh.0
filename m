From: Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 13 Apr 2020 15:43:20 +0000
Subject: Re: [PATCH] sh: fix build error in mm/init.c
Message-Id: <ef8addd0-81bb-249f-7d8f-dfa7fc032085@deltatee.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200413014743.16353-1-masahiroy@kernel.org>
In-Reply-To: <20200413014743.16353-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>



On 2020-04-12 7:47 p.m., Masahiro Yamada wrote:
> The closing parenthesis is missing.
> 
> Fixes: bfeb022f8fe4 ("mm/memory_hotplug: add pgprot_t to mhp_params")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Oh, oops, I thought I compile checked all the arches. Must have been a
last minute change. I'm also surprised the kbuild robot didn't catch this.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Andrew, can this be squashed into the existing patch?

Thanks,

Logan
