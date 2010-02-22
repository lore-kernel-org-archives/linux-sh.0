From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 22 Feb 2010 10:15:57 +0000
Subject: Re: [PATCH] sh: clock-cpg div4 set_rate() shift fix
Message-Id: <20100222101557.GC1417@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100219091200.472.86301.sendpatchset@t400s>
In-Reply-To: <20100219091200.472.86301.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 19, 2010 at 06:12:00PM +0900, Magnus Damm wrote:
> Make sure the div4 bitfield is shifted according
> to the enable_bit value in sh_clk_div4_set_rate().

On Fri, Feb 19, 2010 at 06:22:25PM +0900, Magnus Damm wrote:
> This patch introduces struct clk_div4_table. The structure
> will be used to keep div4 specific data, and is with this
> patch replacing the struct clk_div_mult_table pointer arg
> used by the sh_clk_div4_register() functions.

On Fri, Feb 19, 2010 at 06:26:56PM +0900, Magnus Damm wrote:
> This patch adds a ->kick() callback to clk_div4_table
> and ties it into sh_clk_div4_set_rate(). A sh7724
> specific kick function is also added that updates the
> KICK bit whenever div4 clocks in FRQCRA and FRQCRB
> have been set. Allows us to set the VPU clock.

On Fri, Feb 19, 2010 at 06:33:47PM +0900, Magnus Damm wrote:
> Update the sh7724 processor code to always enable vpu_clk.
> 
> On the Ecovec board, set the vpu_clk to 166 Mhz.
> 
> The 166MHz setting results in a divide-by-6 setup for
> vpu_clk and improves the VPU performance compared to the
> power-on-reset/bootloader configuration.

All applied, thanks.
