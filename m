From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 09 Dec 2014 16:22:22 +0000
Subject: Re: [PATCH 1/4] watchdog: da9063: Add restart handler support
Message-Id: <20141209162222.GA19663@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
 <1418124169-7123-2-git-send-email-geert+renesas@glider.be>
 <6ED8E3B22081A4459DAC7699F3695FB7D0B4C115@SW-EX-MBX02.diasemi.com>
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7D0B4C115-68WUHU125fLzLL1Oxlh9IgLouzNaz+3S@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, Dec 09, 2014 at 12:37:15PM +0000, Opensource [Steve Twiss] wrote:
> On 09 December 2014 11:23 Geert Uytterhoeven wrote:
> 
[ ... ]

> > +	ret = register_restart_handler(&wdt->restart_handler);
> > +	if (ret)
> > +		dev_err(wdt->da9063->dev,
> > +			"Failed to register restart handler (err = %d)\n", ret);
> 
>  (I guess this is intentional).. if the restart handler doesn't get registered then
> this problem is just ignored and not counted as a real error.
> 
This makes sense, since one doesn't want the watchdog driver to fail
loading just because the restart handler failed to register.
One option might be to make the message dev_warn instead of dev_err,
but that is really a nitpick.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter
