From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 24 Jun 2019 07:22:39 +0000
Subject: Re: [PATCH 4/5] x86: don't use asm-generic/ptrace.h
Message-Id: <alpine.DEB.2.21.1906240922270.32342@nanos.tec.linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190624054728.30966-1-hch@lst.de>
 <20190624054728.30966-5-hch@lst.de>
In-Reply-To: <20190624054728.30966-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org

On Mon, 24 Jun 2019, Christoph Hellwig wrote:

> Doing the indirection through macros for the regs accessors just
> makes them harder to read, so implement the helpers directly.
> 
> Note that only the helpers actually used are implemented now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
