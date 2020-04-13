From: Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 13 Apr 2020 22:15:24 +0000
Subject: Re: [PATCH] sh: mm: Fix build error
Message-Id: <ced5523f-c95c-1afb-4e38-788dd39d40cb@deltatee.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200413161542.78700-1-linux@roeck-us.net>
 <20200414080807.78ac80d0@canb.auug.org.au>
In-Reply-To: <20200414080807.78ac80d0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>, Guenter Roeck <linux@roeck-us.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>



On 2020-04-13 4:08 p.m., Stephen Rothwell wrote:
> I'll put this in my fixes tree until someone else picks it up.  Now
> that the patch has reached Linus' tree (and its SHA1 is stable), the
> Fixes line should be
> 
> Fixes: bfeb022f8fe4 ("mm/memory_hotplug: add pgprot_t to mhp_params")

Masahiroy already sent a fix for this that Andrew has picked up:

http://lkml.kernel.org/r/20200413014743.16353-1-masahiroy@kernel.org

Logan
