From: Andrew Stubbs <ams@codesourcery.com>
Date: Mon, 22 Mar 2010 10:24:31 +0000
Subject: Re: How can I undersatnd if the userland app is linked using uclibc
Message-Id: <4BA7455F.8060007@codesourcery.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003191808.00063.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003191808.00063.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 19/03/10 17:08, Fabio Giovagnini wrote:
> Codesurgery toolchain supplies both the library; how can I know building the
> application the linker used uclibc or glibc?

Answer 1: Use ldd (from glibc) to see what dynamic linker it uses.

Answer 2: The 'interpreter' (dynamic linker) is encoded into the binary 
as a string. You can read it out with objdump, readelf or even just strings.

If a dynamic executable is linked against glibc it will use 
ld-linux.so.2. If it's linked against uClibc it will use ld-uClibc.so.0.

For statically linked applications, use nm to read the symbol names. If 
it has a symbol "__uClibc_main" then it's uClibc, otherwise it's Glibc.

Andrew
