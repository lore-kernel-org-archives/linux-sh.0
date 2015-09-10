From: Rich Felker <dalias@libc.org>
Date: Thu, 10 Sep 2015 16:01:49 +0000
Subject: Re: SH FDPIC ABI spec/binutils and kernel conflict on flag definitions
Message-Id: <20150910160149.GP17773@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150910033400.GM17773@brightrain.aerifal.cx>
In-Reply-To: <20150910033400.GM17773@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 10, 2015 at 04:53:35PM +0100, David Howells wrote:
> Rich Felker <dalias@libc.org> wrote:
> 
> > On the other hand, the only existing way to produce a binary that both
> > (1) needs constant displacement, and (2) actually gets constant
> > displacement from the kernel at load time, is to manually edit the ELF
> > headers to flip the bit. So I really doubt any such binaries exist. Do
> > you have a reason to believe they do?
> 
> Well, Fujitsu asked for it for FRV - I've no idea whether they have such
> binaries still.

OK. Can we get feedback from anyone who's actually using this code
now? I don't see how the current situation is at all acceptable for
anyone using it, but maybe I'm missing something. It seems programs
built as FDPIC are going through all the ABI cost for FDPIC (function
descriptors, restricted relative addressing) for absolutely no gain
because the kernel just loads them like plain non-FDPIC ELF files...

Rich
