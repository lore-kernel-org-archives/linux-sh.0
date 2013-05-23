From: Simon Horman <horms@verge.net.au>
Date: Thu, 23 May 2013 01:39:34 +0000
Subject: Re: [PATCH v2] pwm: renesas-tpu: Add missing pwmchip_remove() call in tpu_remove()
Message-Id: <20130523013933.GI22608@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1369057541.11578.1.camel@phoenix>
 <1454213.B1kNpQ6JtX@avalon>
In-Reply-To: <1454213.B1kNpQ6JtX@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Axel Lin <axel.lin@ingics.com>, Thierry Reding <thierry.reding@avionic-design.de>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, May 20, 2013 at 03:46:59PM +0200, Laurent Pinchart wrote:
> Hi Axel,
> 
> Thank you for the patch.
> 
> On Monday 20 May 2013 21:45:41 Axel Lin wrote:
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks. I have queued this up for v3.11 in the pinmux branch
of my renesas tree on kernel.org.

> 
> > ---
> >  drivers/pwm/pwm-renesas-tpu.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> > index 8e6d8d7..319a6fe 100644
> > --- a/drivers/pwm/pwm-renesas-tpu.c
> > +++ b/drivers/pwm/pwm-renesas-tpu.c
> > @@ -432,6 +432,11 @@ static int tpu_remove(struct platform_device *pdev)
> >  {
> >  	struct tpu_device *tpu = platform_get_drvdata(pdev);
> >  	unsigned int i;
> > +	int ret;
> > +
> > +	ret = pwmchip_remove(&tpu->chip);
> > +	if (ret)
> > +		return ret;
> > 
> >  	for (i = 0; i < ARRAY_SIZE(tpu->pwms); ++i) {
> >  		struct tpu_pwm_device *pwm = &tpu->pwms[i];
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
