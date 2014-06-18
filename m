From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 18 Jun 2014 07:27:37 +0000
Subject: Re: [PATCH 2/9] ARM: lager: add i2c1, i2c2 pins
Message-Id: <53A13F69.2020809@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1402862194-17743-1-git-send-email-ben.dooks@codethink.co.uk> <1402862194-17743-3-git-send-email-ben.dooks@codethink.co.uk> <539EE41D.3050206@cogentembedded.com>
In-Reply-To: <539EE41D.3050206@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org, linux-media@vger.kernel.org
Cc: robert.jarzmik@free.fr, g.liakhovetski@gmx.de, magnus.damm@opensource.se, horms@verge.net.au, ian.molton@codethink.co.uk, william.towle@codethink.co.uk

On 16/06/14 13:33, Sergei Shtylyov wrote:
> Hello.
> 
> On 06/15/2014 11:56 PM, Ben Dooks wrote:
> 
>> Add pinctrl definitions for i2c1 and i2c2 busses on the Lager board
>> to ensure these are setup correctly at initialisation time. The i2c0
>> and i2c3 busses are connected to single function pins.
> 
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
>    Likewise, this as been already merged by Simon.

Ah, they had not been merged when I took the branch for this around
-rc8 time. I will look at changing the necessary bits for the vin
in the DT and re-sub them as a new series for Simon to look at merging.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
