From: Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 17 Dec 2018 16:50:30 +0000
Subject: Re: [PATCH v2 6/6] RISC-V: Implement sparsemem
Message-Id: <5fd0880c-5896-ffee-4d3c-4fce1649382e@deltatee.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181015175702.9036-1-logang@deltatee.com>
 <20181015175702.9036-7-logang@deltatee.com>
 <4b591ba933363e29392dba218ef63267@mailhost.ics.forth.gr>
In-Reply-To: <4b591ba933363e29392dba218ef63267@mailhost.ics.forth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Kossifidis <mick@ics.forth.gr>
Cc: Rob Herring <robh@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, Andrew Waterman <andrew@sifive.com>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org, Stephen Bates <sbates@raithlin.com>, Zong Li <zong@andestech.com>, linux-mm@kvack.org, Olof Johansson <olof@lixom.net>, linux-riscv@lists.infradead.org, Michael Clark <michaeljclark@mac.com>, Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org



On 2018-12-17 7:59 a.m., Nick Kossifidis wrote:
> Having memory blocks of a minimum size of 1GB doesn't make much sense. 
> It makes it harder to implement hotplug on top of this since we'll only 
> able to add/remove 1GB at a time. ARM used to do the same and they 
> switched to 27bits (https://patchwork.kernel.org/patch/9172845/), ARM64 
> still uses 1GB, x86 also uses 27bits and most archs also use something 
> below 30. I believe we should go for 27bits as well or even better have 
> this as a compile time option.

Thanks, that makes sense. I'll make the change for the next time we submit.

> BTW memblocks_present is on master now (got merged 3 days ago).

Great! We'll send an updated patch set after the merge window.

Logan
