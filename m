From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 01 Dec 2008 06:42:15 +0000
Subject: Re: [PATCH] sh: propagate r_clk
Message-Id: <20081201064215.GA30438@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081201064033.28841.90287.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081201064033.28841.90287.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 01, 2008 at 03:40:33PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Make sure the 32 KHz r_clk rate gets propagated correctly. Without
> this fix the clocks for RTC, CMT, KEYSC and RWDT are stuck at 0 Hz.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Does this apply to 2.6.28 also, or does it depend on your rate
propagation changes that are aimed at the merge window?
