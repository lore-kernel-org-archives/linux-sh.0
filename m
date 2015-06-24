From: Rob Landley <rob@landley.net>
Date: Wed, 24 Jun 2015 04:25:08 +0000
Subject: Re: [musl] SH sigcontext ABI is broken
Message-Id: <558A3124.30701@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 06/20/2015 01:06 PM, Rich Felker wrote:
> So there's a lot of historical mess and breakage here, but sh3
> binaries have been running with a stable (albeit wrong, IMO)
> definition of ucontext_t/mcontext_t/sigcontext for around 14 years
> now (as long as they only run on sh3 hardware, not sh4). So I'm a bit
> hesitant to consider this something that could be changed with no path
> for compatibility.

I'm told SH3 was only on sale for about a year between its introduction
and sh4 coming out, at which point everybody switched. There were
significant sh2 deployments and significant sh4 deployments, but sh3 was
more or less a rounding error. The Wikipedia[citation needed] article
doesn't even break it out separately because there's really nothing to
say: https://en.wikipedia.org/?title=SuperH

(Again, there's a reason qemu-system-sh4 has a 4 in it. At $DAYJOB their
plan is to eventually jump from sh2 straight to sh4 because sh3 doesn't
matter.)

sh2a was a retcon, started shipping in 2007, a decade after the
dreamcast. Hitachi had already unloaded superh onto Renesas, which did a
big Not Invented Here on superh and kept trying to come up with their
own processor designs. The H in H8300 also stands for Hitachi, so you
can imagine how well Renesas supported it:

http://permalink.gmane.org/gmane.linux.ports.sh.devel/7237

Seriously, It only became interesting again when the patents expired...

Rob
