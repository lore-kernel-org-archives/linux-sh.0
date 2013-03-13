From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 13 Mar 2013 17:47:32 +0000
Subject: Re: [PATCH/RFC 07/12] sh-pfc: Configure pins as GPIOs at request time when handled externally
Message-Id: <2458629.jisx88ilWO@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1362941928-18115-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362941928-18115-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Wednesday 13 March 2013 18:40:07 Linus Walleij wrote:
> On Sun, Mar 10, 2013 at 7:58 PM, Laurent Pinchart wrote:
> > When a GPIO is handled by a separate driver the pinmux
> > gpio_set_direction() handler won't be called. The pin mux type then need
> > to be configured to GPIO at request time.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> (...)
> 
> > @@ -180,6 +180,17 @@ static int sh_pfc_gpio_request_enable(struct
> > pinctrl_dev *pctldev,
> >                 goto done;
> >         }
> > 
> > +       if (pfc->gpio = NULL) {
> > +               /* If GPIOs are handled externally the pin mux type need
> > to be
> > +                * set to GPIO here.
> > +                */
> 
> So using an external GPIO is the *only* reason why pfc->gpio would be
> NULL?

That's correct. pfc->gpio points to the GPIO SoC and must always be supplied 
when the PFC driver handles GPIOs.

> Anyway you can write that if (!pfc->gpio) then...

OK.

-- 
Regards,

Laurent Pinchart

