From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 28 Apr 2011 02:22:14 +0000
Subject: Re: [PATCH] i2c: i2c-sh_mobile bus speed platform data
Message-Id: <20110428022214.GB13539@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110421132254.3725.84300.sendpatchset@t400s> <20110427221357.GA12273@verge.net.au> <BANLkTi=YbtWYKLdcEkv6TDRfm-BbXGXa4w@mail.gmail.com> <20110428011757.GB15883@verge.net.au>
In-Reply-To: <20110428011757.GB15883@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, ben-linux@fluff.org, khali@linux-fr.org

On Thu, Apr 28, 2011 at 10:18:01AM +0900, Simon Horman wrote:
> On Thu, Apr 28, 2011 at 10:06:38AM +0900, Magnus Damm wrote:
> > On Thu, Apr 28, 2011 at 7:14 AM, Simon Horman <horms@verge.net.au> wrote:
> > > I believe that on the sh73a0 and so far only the sh73a0
> > > denom needs to be doubled.
> > 
> > Uhm, I don't think this patch is specific to any SoC type. It may of
> > course be used on sh73a0 to adjust the denom value, but setting the
> > I2C bus speed is something that can be used on any SoC. So I'd say
> > that this is a fairly generic feature.
> 
> I'm just saying that that I've observed the value being doubled for sh73a0.
> 
The general rule of thumb is that whatever unusual behaviour is observed
in the latest CPU we will see become the standard for future ones.
Abstracting the denom value seems reasonable as a cautionary measure, and
it does do the NORMAL_SPEED as a default fallback so there is no adverse
impact for normalized platforms.

This really should be going in to include/linux/i2c/ or so though, no
need to dump these tiny stubs in to include/linux/ directly.
