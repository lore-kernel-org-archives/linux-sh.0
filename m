From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 21 Apr 2015 05:25:51 +0000
Subject: Re: [RFC] i2c-tools: i2ctransfer: add new tool
Message-Id: <20150421072551.326bb4b7@endymion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <1425053816-19804-1-git-send-email-wsa@the-dreams.de>
	<20150420173638.GA1452@katana>
In-Reply-To: <20150420173638.GA1452@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wolfram,

On Mon, 20 Apr 2015 19:36:38 +0200, Wolfram Sang wrote:
> On Fri, Feb 27, 2015 at 05:16:56PM +0100, Wolfram Sang wrote:
> > This tool allows to construct and concat multiple I2C messages into one
> > single transfer. Its aim is to test I2C master controllers, and so there
> > is no SMBus fallback.
> > 
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > ---
> > 
> > I've been missing such a tool a number of times now, so I finally got around to
> > writing it myself. As with all I2C tools, it can be dangerous, but it can also
> > be very useful when developing. I am not sure if distros should supply it, I'll
> > leave that to Jean's experience. For embedded build systems, I think this
> > should be selectable. It is RFC for now because it needs broader testing and some
> > more beautification. However, I've been using it already to test the i2c_quirk
> > infrastructure and Renesas I2C controllers.
> 
> Jean, my tests went well and so I want to brush it up for inclusion into
> i2c-tools upstream. Any show-stoppers you see from a high-level point of
> view?

I think it is a good idea, just I couldn't find the time to review it,
sorry :(

-- 
Jean Delvare
SUSE L3 Support
