From: Christoph Hellwig <hch@lst.de>
Date: Fri, 28 Jun 2019 07:12:57 +0000
Subject: Re: [PATCH] sh: clkfwk: don't pass void pointers to ioread*
Message-Id: <20190628071257.GA28615@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190628062524.5436-1-hch@lst.de> <CAMuHMdVpvu+xzfh3Qee-Yz2H3YDc6CVUocKTwLTUG8gUOQPeGA@mail.gmail.com>
In-Reply-To: <CAMuHMdVpvu+xzfh3Qee-Yz2H3YDc6CVUocKTwLTUG8gUOQPeGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Fri, Jun 28, 2019 at 09:01:40AM +0200, Geert Uytterhoeven wrote:
> This is due to include/asm-generic/io.h and include/asm-generic/iomap.h
> using different prototypes, right?
> 
> include/asm-generic/io.h:static inline u8 ioread8(const volatile void
> __iomem *addr)
> include/asm-generic/io.h:static inline u16 ioread16(const volatile
> void __iomem *addr)
> include/asm-generic/io.h:static inline u32 ioread32(const volatile
> void __iomem *addr)
> include/asm-generic/io.h:static inline u64 ioread64(const volatile
> void __iomem *addr)
> 
> include/asm-generic/iomap.h:extern unsigned int ioread8(void __iomem *);
> include/asm-generic/iomap.h:extern unsigned int ioread16(void __iomem *);
> include/asm-generic/iomap.h:extern unsigned int ioread32(void __iomem *);
> include/asm-generic/iomap.h:extern u64 ioread64(void __iomem *);
> 
> Wouldn't it be better to fix include/asm-generic/iomap.h and lib/iomap.c
> instead?

Oh, I didn't even notice we had this declared by different files..
