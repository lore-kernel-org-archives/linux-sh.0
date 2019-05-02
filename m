From: Oleg Nesterov <oleg@redhat.com>
Date: Thu, 02 May 2019 14:01:22 +0000
Subject: Re: remove asm-generic/ptrace.h
Message-Id: <20190502140122.GC7323@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190501173943.5688-1-hch@lst.de>
In-Reply-To: <20190501173943.5688-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/01, Christoph Hellwig wrote:
>
> Hi all,
>
> asm-generic/ptrace.h is a little weird in that it doesn't actually
> implement any functionality, but it provided multiple layers of macros
> that just implement trivial inline functions.  We implement those
> directly in the few architectures and be off with a much simpler
> design.

Oh, thanks, I was always confused by these macros ;)

Oleg.
