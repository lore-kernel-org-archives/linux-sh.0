From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 24 Jun 2019 07:23:02 +0000
Subject: Re: remove asm-generic/ptrace.h v3
Message-Id: <alpine.DEB.2.21.1906240922420.32342@nanos.tec.linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190624054728.30966-1-hch@lst.de>
In-Reply-To: <20190624054728.30966-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Mon, 24 Jun 2019, Christoph Hellwig wrote:
> 
> asm-generic/ptrace.h is a little weird in that it doesn't actually
> implement any functionality, but it provided multiple layers of macros
> that just implement trivial inline functions.  We implement those
> directly in the few architectures and be off with a much simpler
> design.
> 
> I'm not sure which tree is the right place, but may this can go through
> the asm-generic tree since it removes an asm-generic header?

Makes sense.

Thanks,

	tglx
