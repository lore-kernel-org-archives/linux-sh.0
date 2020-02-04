From: Rich Felker <dalias@libc.org>
Date: Tue, 04 Feb 2020 14:23:58 +0000
Subject: Re: No newer system calls for SuperH64?
Message-Id: <20200204142358.GT1663@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <939c9260-213f-cfd7-f81a-e9b635a6aa10@juszkiewicz.com.pl>
In-Reply-To: <939c9260-213f-cfd7-f81a-e9b635a6aa10@juszkiewicz.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 04, 2020 at 03:13:23PM +0100, Marcin Juszkiewicz wrote:
> I am maintaining system calls table [1] which shows which system call
> has which number on all architectures supported by Linux kernel
> (including those removed in last years).
> 
> 1. https://fedora.juszkiewicz.com.pl/syscalls.html
> 
> Today I have noticed that SH64 supports system calls up to 393 which is
> pwritev2() one. None of later calls is supported in mainline 5.6-rc tree.
> 
> Is it an error in kernel headers or it is true? Or maybe it is an error
> in my script but it works fine for other architectures.
> 
> Note: I do not own nor plan to own SuperH64 hardware. I do not even
> remember where it was used. Just noticed weird state of it.

One reason you don't own it is that it essentially doesn't exist. :-)
GCC dropped SH64 support a few years ago because the arch essentially
never materialized and keeping it around was a lot of cruft. It should
be removed from the kernel too; I just haven't gotten around to
figuring out how to do that.

Rich
