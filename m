From: Simon Horman <horms@verge.net.au>
Date: Fri, 12 Apr 2013 06:40:43 +0000
Subject: Re: [PATCH] sh-pfc: R8A7779: add VIN pin groups
Message-Id: <20130412064039.GA24945@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201304120251.38652.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304120251.38652.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On 木,  4月 11, 2013 at 09:33:56午後 -0700, Kuninori Morimoto wrote:
> 
> Hi Sergei
> 
> Thank you for your patch
> 
> > +/* - VIN0 ------------------------------------------------------------------- */
> > +static const unsigned int vin0_data8_pins[] = {
> > +	/* D[0:7] */
> > +	70, 71, 72, 73, 74, 75, 76, 77,
> > +};
> 
> Can you use RCAR_GP_PIN() macro on this patch ?
> 
> 0bd898b16cdc0a4512d0b1af2fbe1174d217dd2d
> (gpio-rcar: Add RCAR_GP_PIN macro)

I would be happy to accept that change as an incremental patch
if there are no other changes outstanding to this patch.

Laurent, I wonder if you could review this patch.
