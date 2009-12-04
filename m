From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Dec 2009 04:45:35 +0000
Subject: Re: [PATCH] Fix too early disabling of the serial (SCI(F)) ports
Message-Id: <20091204044535.GH11047@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912011045150.4701@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0912011045150.4701@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 01, 2009 at 10:54:46AM +0100, Guennadi Liakhovetski wrote:
> Currently serial ports on SH CPUs get disabled too early, because the 
> sci_tx_empty() routine claims to not be able to detect whether the 
> transmission has been completed and just always returns TIOCSER_TEMT. This 
> results in corrupt output of last characters if the port is not open for 
> reading at the same time. It is however possible to detect whether 
> transmission has been completed. Use the TEND bit of the status register 
> for this.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
