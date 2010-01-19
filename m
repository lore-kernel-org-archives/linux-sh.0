From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 19 Jan 2010 11:24:25 +0000
Subject: Re: [PATCH v2] sh: support SIU sourcing from external clock on sh7722
Message-Id: <20100119112425.GG16013@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001191205221.4607@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001191205221.4607@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 19, 2010 at 12:14:31PM +0100, Guennadi Liakhovetski wrote:
> Implement .set_rate() for all SH "div4 clocks," .enable(), .disable(), and 
> .set_parent() for those, that support them. This allows, among other uses, 
> reparenting of SIU clocks to the external source, and enabling and 
> disabling of the IrDA clock on sh7722.
> 
[snip]

> v1 -> v2: after a private discussion (thanks for tips, Magnus) all methods 
> from v1 of this patch have been made globally available for all 
> sh_clk_div4 users.
> 
Yes, this looks better, and has the added benefit of not breaking SH7785
and SH7786. ;-)

Applied, thanks.
