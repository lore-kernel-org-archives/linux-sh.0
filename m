From: Rich Felker <dalias@libc.org>
Date: Fri, 19 Jun 2015 19:12:16 +0000
Subject: Re: [musl] Re: SH sigcontext ABI is broken
Message-Id: <20150619191216.GV1173@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 19, 2015 at 09:41:58AM +0200, Andreas Schwab wrote:
> Rich Felker <dalias@libc.org> writes:
> 
> > I did some research and this issue goes way back, to before the
> > beginning of the kernel git repository.
> 
> There are various git trees that render the pre-git history, see
> <http://stackoverflow.com/questions/3264283/linux-kernel-historical-git-repository-with-full-history>
> for pointers.

Thanks, but most of the links seem to be broken. Do you think there
would be value (in terms of helping determine how to solve this
problem) in digging up the history further?

Rich
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
