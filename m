From: Rich Felker <dalias@libc.org>
Date: Thu, 10 Sep 2015 15:50:59 +0000
Subject: Re: SH FDPIC ABI spec/binutils and kernel conflict on flag definitions
Message-Id: <20150910155059.GO17773@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150910033400.GM17773@brightrain.aerifal.cx>
In-Reply-To: <20150910033400.GM17773@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 10, 2015 at 04:45:30PM +0100, David Howells wrote:
> Rich Felker <dalias@libc.org> wrote:
> 
> > > I think that adopting the kernel's behaviour as correct would set a
> > > dangerous precedent.  A published ABI should be followed, and if the
> > > kernel does not implement it, then the kernel is wrong.
> 
> The kernel practice is that once an ABI is set, even if it's actually
> implemented incorrectly, you cannot change it.

Is that applicable even in places where fixing it won't break
anything? Do you see a problem in my analysis concluding that it
won't?

If we have to fix it on the binutils (& documentation) side, every
existing binary will remain wrong and only new binaries will get text
sharing.

On the other hand, the only existing way to produce a binary that both
(1) needs constant displacement, and (2) actually gets constant
displacement from the kernel at load time, is to manually edit the ELF
headers to flip the bit. So I really doubt any such binaries exist. Do
you have a reason to believe they do?

Rich
