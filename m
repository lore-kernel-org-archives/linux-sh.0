From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 06 Apr 2010 15:48:29 +0000
Subject: Re: [PATCH 00/03] i2c: i2c-sh_mobile update for SH-Mobile ARM
Message-Id: <20100406154829.GA9261@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100311100526.15227.50813.sendpatchset@t400s> <20100315063005.GA21181@fluff.org.uk>
In-Reply-To: <20100315063005.GA21181-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nishimoto.hiroki-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, morimoto.kuninori-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org

On Mon, Mar 15, 2010 at 06:30:05AM +0000, Ben Dooks wrote:
> On Thu, Mar 11, 2010 at 07:05:26PM +0900, Magnus Damm wrote:
> > i2c: i2c-sh_mobile update for SH-Mobile ARM
> > 
> > [PATCH 01/03] i2c: i2c-sh_mobile register access code break out
> > [PATCH 02/03] i2c: i2c-sh_mobile support for new ICIC bits
> > [PATCH 03/03] i2c: i2c-sh_mobile kconfig update for SH-Mobile ARM
> > 
> > These patches add support for a newer version of the IIC block
> > to the i2c-sh_mobile and enables the driver on SH-Mobile ARM.
> > 
> > Perhaps suitable for the SH tree?
> 
> I'll add these to i2c-next once I restart it in a few days
> time.
> 
I still don't see these in -next, so I suppose I'll just roll these in to
the genesis tree, especially since we have outstanding patches that
depend on these.
