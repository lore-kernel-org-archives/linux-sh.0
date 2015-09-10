From: David Howells <dhowells@redhat.com>
Date: Thu, 10 Sep 2015 15:53:35 +0000
Subject: Re: SH FDPIC ABI spec/binutils and kernel conflict on flag definitions
Message-Id: <23551.1441900415@warthog.procyon.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20150910033400.GM17773@brightrain.aerifal.cx>
In-Reply-To: <20150910033400.GM17773@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Rich Felker <dalias@libc.org> wrote:

> On the other hand, the only existing way to produce a binary that both
> (1) needs constant displacement, and (2) actually gets constant
> displacement from the kernel at load time, is to manually edit the ELF
> headers to flip the bit. So I really doubt any such binaries exist. Do
> you have a reason to believe they do?

Well, Fujitsu asked for it for FRV - I've no idea whether they have such
binaries still.

David
