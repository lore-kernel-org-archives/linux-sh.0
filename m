From: Rich Felker <dalias@libc.org>
Date: Wed, 12 Aug 2015 01:56:16 +0000
Subject: SH2 kernel fails to build with recent GCC
Message-Id: <20150812015616.GA19843@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The commit that resolved GCC issue #54089 broke building the kernel
for SH2, by causing GCC to generate calls to new libgcc functions
which the kernel's fake libgcc does not provide. See the GCC issue
tracker for details:

https://gcc.gnu.org/bugzilla/show_bug.cgi?idT089

The relevant commit is linked from comment 16; comments 33-43 (and
perhaps beyond) discuss the issue in detail and possible fixes.

Before I work on a fix, would dropping the kernel's copy of libgcc
functions for SH and using the real libgcc (like some archs do; see
comment 43) be acceptable, or do we need to get updated
libgcc[-compatible] code into the kernel?

Rich
