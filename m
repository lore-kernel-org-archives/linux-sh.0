From: Rich Felker <dalias@libc.org>
Date: Fri, 19 Jun 2015 20:32:21 +0000
Subject: Re: [musl] Re: SH sigcontext ABI is broken
Message-Id: <20150619203221.GX1173@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 19, 2015 at 09:57:22PM +0200, Andreas Schwab wrote:
> Rich Felker <dalias@libc.org> writes:
> 
> > Thanks, but most of the links seem to be broken.
> 
> Are they?  I'm only seeing a single broken link, which has a mirror.

My bad. Indeed only the davej one is broken, but that's where the code
must have been introduced (even the earliest commit in tglx
history.git has the #ifdef __SH4__ for FPU regs) and I can't find a
cgit interface to it. Fetching several GB to browse history locally is
going to take a while if I have to do that..

Rich
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
