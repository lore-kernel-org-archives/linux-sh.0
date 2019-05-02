From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 02 May 2019 13:54:30 +0000
Subject: Re: [PATCH 1/5] arm64: don't use asm-generic/ptrace.h
Message-Id: <20190502135430.GB25142@arrakis.emea.arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190501173943.5688-1-hch@lst.de>
 <20190501173943.5688-2-hch@lst.de>
In-Reply-To: <20190501173943.5688-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Wed, May 01, 2019 at 01:39:39PM -0400, Christoph Hellwig wrote:
> Doing the indirection through macros for the regs accessors just
> makes them harder to read, so implement the helpers directly.
> 
> Note that only the helpers actually used are implemented now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
