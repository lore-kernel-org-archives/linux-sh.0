From: Simon Horman <horms@verge.net.au>
Date: Sun, 06 Jul 2014 14:37:28 +0000
Subject: Re: [PATCH v2] ARM: shmobile: Lager: Correct I2C bus for VDD MPU regulator
Message-Id: <20140706143728.GL3750@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <53B5F327.5040301@renesas.com>
In-Reply-To: <53B5F327.5040301@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 04, 2014 at 03:41:21PM +0900, Khiem Nguyen wrote:
> Hi Inami-san,
> 
> On 7/4/2014 2:40 PM, Gaku Inami wrote:
> >> I2C bus for VDD MPU regulator is IIC3, not I2C3.
> [...]
> >> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
> [...]
> > Thank you for updating patch. 
> > I tested your patch. Test reult is good.
> Thanks for your testing.
> 
> [...]
> > Tested-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> [...]
> > This is a bug fix of my cpufreq patch. Thank you for your fix.
> OK. 
> Let's wait for final comment from Magnus-san.

Thanks, I have decided to queue this up.
