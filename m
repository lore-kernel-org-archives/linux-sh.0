From: Chris Ball <cjb@laptop.org>
Date: Mon, 03 Dec 2012 19:23:10 +0000
Subject: Re: [PATCH] mmc: sh_mobile_sdhi: remove unneeded clock connection ID
Message-Id: <87hao3hrdt.fsf@octavius.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1211281016550.1710@axis700.grange>
	<20121130085903.GF4501@verge.net.au>
In-Reply-To: <20121130085903.GF4501@verge.net.au> (Simon Horman's message of
	"Fri, 30 Nov 2012 17:59:04 +0900")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi,

On Fri, Nov 30 2012, Simon Horman wrote:
> On Wed, Nov 28, 2012 at 10:24:21AM +0100, Guennadi Liakhovetski wrote:
>> SDHI only uses one clock, all ARM and SuperH platform register SDHI clock
>> lookup entries with no connection ID, hence it can be dropped in the
>> driver too.
>> 
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
