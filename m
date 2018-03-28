From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Mar 2018 12:23:47 +0000
Subject: Re: [PATCH 01/16] initrd: Add generic code path for common initrd unloading logic.
Message-Id: <CAMuHMdXwEL-gLxiVJwuxwRtkyhR=vEm3GP4dzJMpc1nS8AKxKQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180324174458.26423-1-shea@shealevy.com> <20180324174458.26423-2-shea@shealevy.com>
 <20180328120440.GB1838@infradead.org>
In-Reply-To: <20180328120440.GB1838@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Shea Levy <shea@shealevy.com>, alpha <linux-alpha@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, linux-m68k <linux-m68k@lists.linux-m68k.org>, nios2-dev@lists.rocketboards.org, Openrisc <openrisc@lists.librecores.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Mar 28, 2018 at 2:04 PM, Christoph Hellwig <hch@infradead.org> wrote:
>> +#ifdef CONFIG_INITRAMFS_GENERIC_UNLOAD
>> +void free_initrd_mem(unsigned long start, unsigned long end)
>> +{
>> +       free_reserved_area((void *)start, (void *)end, -1, "initrd");
>> +}
>> +#endif
>
> Given how trivial this is and how many architectures can use it I'd
> reverse the polarity and add a CONFIG_HAVE_ARCH_FREE_INITRD_MEM
> instead.

And while adding "special" functionality to the generic version, more and more
users of CONFIG_HAVE_ARCH_FREE_INITRD_MEM will be removed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
