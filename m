From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 08 Jan 2008 06:41:45 +0000
Subject: Re: [PATCH] sh: intc - remove default interrupt priority tables
Message-Id: <20080108064145.GA22258@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080108061240.14389.51112.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080108061240.14389.51112.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 08, 2008 at 03:12:40PM +0900, Magnus Damm wrote:
> sh: intc - remove default interrupt priority tables
> 
> This patch removes interrupt priority tables from the intc code. Optimal 
> priority assignment varies with embedded application anyway, so keeping the
> interrupt priority tables together with cpu-specific code doesn't make sense.
> 
> The function intc_set_priority() should be used instead to set the desired
> interrupt priority level.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Hmm.. We so have some FPGAs hanging off of IRLs that need a fixed
priority, though I can't think of any CPU subtype off the top of my head
that has that sort of restriction within the core itself. Given that, I
guess this is fine, but that means that the rationale for an intc desc
for an FPGA at a fixed IRL level will be setting the priority from the
board code on the cascade line prior to registration. This makes sense,
but we should probably make a note of it somewhere.

Patch looks ok though, I'll pile it on to my queue.
