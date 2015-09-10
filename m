From: David Howells <dhowells@redhat.com>
Date: Thu, 10 Sep 2015 15:45:30 +0000
Subject: Re: SH FDPIC ABI spec/binutils and kernel conflict on flag definitions
Message-Id: <23476.1441899930@warthog.procyon.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20150910033400.GM17773@brightrain.aerifal.cx>
In-Reply-To: <20150910033400.GM17773@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Rich Felker <dalias@libc.org> wrote:

> > I think that adopting the kernel's behaviour as correct would set a
> > dangerous precedent.  A published ABI should be followed, and if the
> > kernel does not implement it, then the kernel is wrong.

The kernel practice is that once an ABI is set, even if it's actually
implemented incorrectly, you cannot change it.

David
