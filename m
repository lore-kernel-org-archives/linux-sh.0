From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 29 Jan 2009 06:39:08 +0000
Subject: Re: [PATCH 1/2] sh: Relax inline assembly constraints
Message-Id: <20090129063908.GE32243@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1232486078-11227-1-git-send-email-matt@console-pimps.org> <1232486078-11227-2-git-send-email-matt@console-pimps.org> <1232486078-11227-1-git-send-email-matt@console-pimps.org>
In-Reply-To: <1232486078-11227-2-git-send-email-matt@console-pimps.org> <1232486078-11227-1-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 20, 2009 at 09:14:37PM +0000, Matt Fleming wrote:
> When dereferencing the memory address contained in a register and
> modifying the value at that memory address, the register should not be
> listed in the inline asm outputs. The value at the memory address is an
> output (which is taken care of with the "memory" clobber), not the register.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

On Tue, Jan 20, 2009 at 09:14:38PM +0000, Matt Fleming wrote:
> Now that atomic_t is a generic opaque type for all architectures, it is
> unwise to use intimate knowledge of its internals when manipulating it.
> 
> Instead of relying on the "counter" member being at offset 0 from the
> beginning of an atomic_t, explicitly reference the member. This guards
> us from any changes to the layout of the beginning of the atomic_t type.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Applied, thanks.
