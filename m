From: Simon Horman <horms@verge.net.au>
Date: Tue, 15 Jul 2014 04:17:23 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: lager: use iic cores instead of i2c
Message-Id: <20140715041723.GE5277@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404989456-2716-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1404989456-2716-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jul 13, 2014 at 03:43:57PM +0200, Wolfram Sang wrote:
> > I have queued this up for v3.17 rather than v3.16 as I do not believe
> > there are any i2c (or iic) nodes present or scheduled for inclusion in
> > this file in v3.16: I checked v3.16-rc4.
> 
> In case the i2c char driver is activated, the nodes in /dev will change
> from i2c-{0-3} to i2c-{4-7}, too. I'll let you decide about the
> importance of it :)

Thanks, I think I am comfortable with that.
