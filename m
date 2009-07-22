From: Jiri Slaby <jirislaby@gmail.com>
Date: Wed, 22 Jul 2009 07:24:29 +0000
Subject: Re: Do cpu-endian MMIO accessors exist?
Message-Id: <4A66BEAD.3080404@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090721234243.1928d9e2@daedalus.pq.iki.fi> <200907212315.50225.arnd@arndb.de> <4A663987.4040500@gmail.com> <200907220005.27583.arnd@arndb.de>
In-Reply-To: <200907220005.27583.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pekka Paalanen <pq@iki.fi>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, lethal@linux-sh.org, linux-sh@vger.kernel.org

On 07/22/2009 12:05 AM, Arnd Bergmann wrote:
> On Tuesday 21 July 2009, Jiri Slaby wrote:
>> I guess it's a bug that ioread/write* on sh are not with
>> barriers?
> 
> That depends on how that architecture defines its bus interface.
> On many simple architectures, you do not need any synchronization
> operations.

No, I should have written this explicitly. I meant read* have a barrier,
whereas ioread* do not. Similarly for writes. Is this expected?

For example:
#define __raw_readl(a) (__chk_io_ptr(a), *(volatile u32 __force *)(a))
#define readl(a)       ({ u32 r_ = __raw_readl(a); mb(); r_; })
#define ioread32(a)    __raw_readl(a)
