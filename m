From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 28 Oct 2011 06:13:53 +0000
Subject: Re: [PATCH] sh: intc: Add IRQ trigger bit field check
Message-Id: <20111028061353.GG32187@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20111017085954.21977.43477.sendpatchset@w520>
In-Reply-To: <20111017085954.21977.43477.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 17, 2011 at 05:59:54PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> R-Mobile SoCs such as sh73a0 include PINT blocks in INTC
> that come with 2-bit IRQ trigger support. Add code to make
> sure the bit width is checked so 4-bit only modes like for
> instance EDGE_BOTH will fail for PINT.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied, thanks.
