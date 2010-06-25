From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 25 Jun 2010 07:45:24 +0000
Subject: Re: [PATCH] sh: remove bogus highest / lowest logic from clock rate rounding
Message-Id: <20100625074523.GA3133@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1006250918150.1223@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1006250918150.1223@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 25, 2010 at 09:19:39AM +0200, Guennadi Liakhovetski wrote:
> The use of highest and lowest in clk_rate_table_round() is completely bogus
> and superfluous. Remove it.
> 
In what way is it bogus or superfluous? They are there to provide
high/low rate bounding when we have no idea what sort of frequencies are
available for an underlying clock.
