From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 10 Dec 2014 18:39:11 +0000
Subject: Re: [PATCH v7 1/6] clk: shmobile: sh73a0 common clock framework implementation
Message-Id: <19168201.MzxezicZP2@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1418222727-19888-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418222727-19888-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

(CC'ing Morimoto-san)

On Wednesday 10 December 2014 17:53:22 Ulrich Hecht wrote:
> On Wed, Dec 10, 2014 at 4:38 PM, Laurent Pinchart wrote:
> > On Wednesday 10 December 2014 15:45:22 Ulrich Hecht wrote:
> >> Driver for the SH73A0's clocks that are too specific to be supported by a
> >> generic driver.
> 
> [...]
> 
> >> +static struct div4_clk div4_clks[] = {
> >> +     { "zg", "pll0", CPG_FRQCRA, 16 },
> > 
> > I've already commented on this in v6, the comment has probably been
> > overlooked. According to the datasheet the ZGFC value 1010 results in a
> > x1/5 factor, which  doesn't match the value in the div4_div_table below.
> > I wonder if it could be an error in the datasheet though.
> 
> The legacy driver doesn't make an exception for zg.  Looks like an
> error in the datasheet to me.

Morimoto-san, do you think it would be possible to get that information from 
the hardware team(s) ?

In the meantime I don't think this is a show stopper.

-- 
Regards,

Laurent Pinchart

