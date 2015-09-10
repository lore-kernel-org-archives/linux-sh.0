From: Rich Felker <dalias@libc.org>
Date: Thu, 10 Sep 2015 21:09:24 +0000
Subject: Re: SH FDPIC ABI spec/binutils and kernel conflict on flag definitions
Message-Id: <20150910210924.GR17773@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150910033400.GM17773@brightrain.aerifal.cx>
In-Reply-To: <20150910033400.GM17773@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 10, 2015 at 12:01:49PM -0400, Rich Felker wrote:
> On Thu, Sep 10, 2015 at 04:53:35PM +0100, David Howells wrote:
> > Rich Felker <dalias@libc.org> wrote:
> > 
> > > On the other hand, the only existing way to produce a binary that both
> > > (1) needs constant displacement, and (2) actually gets constant
> > > displacement from the kernel at load time, is to manually edit the ELF
> > > headers to flip the bit. So I really doubt any such binaries exist. Do
> > > you have a reason to believe they do?
> > 
> > Well, Fujitsu asked for it for FRV - I've no idea whether they have such
> > binaries still.
> 
> OK. Can we get feedback from anyone who's actually using this code
> now? I don't see how the current situation is at all acceptable for
> anyone using it, but maybe I'm missing something. It seems programs
> built as FDPIC are going through all the ABI cost for FDPIC (function
> descriptors, restricted relative addressing) for absolutely no gain
> because the kernel just loads them like plain non-FDPIC ELF files...

I've now gotten gcc and my SH-FDPIC port of musl far enough along to
test on a real kernel/hardware, and I can confirm that the kernel's
interpretation of the bit is backwards, at least on SH. Since the code
is the same for all the other archs with FDPIC I think it's safe to
assume they're all broken. Patching the kernel to ignore the bit
yields shared text, as expected.

Rich
