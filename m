From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 09 Dec 2015 12:12:36 +0000
Subject: Re: [PATCH v2 2/9] i2c: add generic routine to parse DT for timing information
Message-Id: <1449663156.30729.63.camel@linux.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
 <1449567473-2084-3-git-send-email-wsa@the-dreams.de>
 <1449572085.30729.28.camel@linux.intel.com> <20151208130323.GB3359@katana>
 <20151208215103.GA1601@katana>
In-Reply-To: <20151208215103.GA1601@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

On Tue, 2015-12-08 at 22:51 +0100, Wolfram Sang wrote:
> On Tue, Dec 08, 2015 at 02:03:23PM +0100, Wolfram Sang wrote:
> > 
> > > Too many && use_defaults. What about
> > > 
> > > memset(t, 0, sizeof(*t));
> > > 
> > > device_property_read_u32(dev, "i2c-scl-internal-delay-ns", &t-
> > > > scl_int_delay_ns);
> > > 
> > > if (!use_defaults)
> > >  return;
> > 
> > I like this! Thanks for the input.
> 
> Oops, too enthusiastic. This skips parsing all the other
> properties...
> The defaults should only be applied if reading the properties fails.

Looks like property stuff is not destructive in case of error, so, what
about

paramX = use_defaults ? defaultX : 0;
device_property_read…(…, &paramX);

Or maybe just be a bit verbose like the original variant
int ret;

ret = device_property_read…(…);
if (ret && use_defaults) {
…
}

Among all variants I like the latter one here. What do you think?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

