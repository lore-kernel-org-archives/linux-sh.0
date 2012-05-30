From: David Howells <dhowells@redhat.com>
Date: Wed, 30 May 2012 13:02:38 +0000
Subject: Re: Has anyone got gcc-4.7.0 to build an SH64 kernel without dying?
Message-Id: <20250.1338382958@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <10426.1338312184@redhat.com>
In-Reply-To: <10426.1338312184@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Kaz Kojima <kkojima@rr.iij4u.or.jp> wrote:

> There were 3 patches for sh64-elf gcc build failure on trunk:
> 
> http://gcc.gnu.org/ml/gcc-patches/2012-03/msg00208.html
> http://gcc.gnu.org/ml/gcc-patches/2012-03/msg00209.html
> http://gcc.gnu.org/ml/gcc-patches/2012-03/msg00210.html

They seem to fix the problem, thanks!

Oh, and I think these also fix this:

	http://gcc.gnu.org/bugzilla/show_bug.cgi?idR971

Am I right in that?

David
