From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Wed, 04 Sep 2013 12:06:13 +0000
Subject: Re: [PATCH] EMMA: Add em i2c driver
Message-Id: <20130904140613.2b47e4a7@skate>
List-Id: <linux-sh.vger.kernel.org>
References: <CANqRtoRK+Ur=87-me7CpP+s9SO5g0ZVZSEOrqwDf4HFfjZZmZA@mail.gmail.com>
	<1378207832-3412-1-git-send-email-ian.molton@codethink.co.uk>
	<1378207832-3412-2-git-send-email-ian.molton@codethink.co.uk>
	<5225DC8E.7070001@codethink.co.uk>
In-Reply-To: <5225DC8E.7070001-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: Ian Molton <ian.molton-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Dear Ben Dooks,

On Tue, 03 Sep 2013 13:56:46 +0100, Ben Dooks wrote:

> > +static int em_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> > +	int num)
> > +{
> > +	struct em_i2c_device *i2c_dev > > +		(struct em_i2c_device *)(i2c_get_adapdata(adap));
> 
> if this is used enough it may have been easier to add an to_em_i2c()
> macro.

Or simply realize that i2c_get_adapdata() returns a 'void *' and that
therefore the cast is unnecessary, which makes a to_em_i2c() macro
useless, no?

I.e, you should be able to write:

	struct em_i2c_device *i2c_dev = i2c_get_adapdata(adap);

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
