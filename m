From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 28 Mar 2018 12:04:40 +0000
Subject: Re: [PATCH 01/16] initrd: Add generic code path for common initrd unloading logic.
Message-Id: <20180328120440.GB1838@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180324174458.26423-2-shea@shealevy.com>
In-Reply-To: <20180324174458.26423-2-shea@shealevy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shea Levy <shea@shealevy.com>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, linux-alpha@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, nios2-dev@lists.rocketboards.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org

> +#ifdef CONFIG_INITRAMFS_GENERIC_UNLOAD
> +void free_initrd_mem(unsigned long start, unsigned long end)
> +{
> +       free_reserved_area((void *)start, (void *)end, -1, "initrd");
> +}
> +#endif

Given how trivial this is and how many architectures can use it I'd
reverse the polarity and add a CONFIG_HAVE_ARCH_FREE_INITRD_MEM
instead.
