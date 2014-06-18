From: Simon Horman <horms@verge.net.au>
Date: Wed, 18 Jun 2014 07:31:19 +0000
Subject: Re: [PATCH 2/9] ARM: lager: add i2c1, i2c2 pins
Message-Id: <20140618073119.GB14968@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1402862194-17743-1-git-send-email-ben.dooks@codethink.co.uk>
 <1402862194-17743-3-git-send-email-ben.dooks@codethink.co.uk>
 <539EE41D.3050206@cogentembedded.com>
 <53A13F69.2020809@codethink.co.uk>
In-Reply-To: <53A13F69.2020809@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org, linux-media@vger.kernel.org, robert.jarzmik@free.fr, g.liakhovetski@gmx.de, magnus.damm@opensource.se, ian.molton@codethink.co.uk, william.towle@codethink.co.uk

On Wed, Jun 18, 2014 at 08:27:37AM +0100, Ben Dooks wrote:
> On 16/06/14 13:33, Sergei Shtylyov wrote:
> > Hello.
> > 
> > On 06/15/2014 11:56 PM, Ben Dooks wrote:
> > 
> >> Add pinctrl definitions for i2c1 and i2c2 busses on the Lager board
> >> to ensure these are setup correctly at initialisation time. The i2c0
> >> and i2c3 busses are connected to single function pins.
> > 
> >> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > 
> >    Likewise, this as been already merged by Simon.
> 
> Ah, they had not been merged when I took the branch for this around
> -rc8 time. I will look at changing the necessary bits for the vin
> in the DT and re-sub them as a new series for Simon to look at merging.

Thanks, Ben.
