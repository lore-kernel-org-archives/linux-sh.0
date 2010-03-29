From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Mar 2010 03:16:33 +0000
Subject: Re: [PATCH] sh: Enable the mmu in start_secondary()
Message-Id: <20100329031633.GC26500@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <a460f3c9762b32919a8886a12ecaf3347358234d.1269806815.git.matt@console-pimps.org>
In-Reply-To: <a460f3c9762b32919a8886a12ecaf3347358234d.1269806815.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 28, 2010 at 09:08:25PM +0100, Matt Fleming wrote:
> For the boot, enable_mmu() is called from setup_arch() but we don't call
> setup_arch() for any of the other cpus. So turn on the non-boot cpu's
> mmu inside of start_secondary().
> 
> I noticed this bug on an SMP board when trying to map I/O memory
> (smsc911x registers) into the kernel address space. Since the Address
> Translation bit in MMUCR wasn't set, accessing the virtual address where
> the smsc911x registers were supposedly mapped actually performed a
> physical address access.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Applied, thanks.
