From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Thu, 13 Jan 2011 05:28:44 +0000
Subject: Re: cache disabling
Message-Id: <201101130628.44403.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101121904.21051.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101121904.21051.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul thanks a lot for you patience with my stupid questions.
But it is not so surprising, because I verified in previuos kernels, that 
disabling all the options of the cache still the file cache-<cpu_type> was 
compiled and linked into the built-in.o file.
This has been the reason of my question.
Anyway if you confirm I'm really sure.

Thanks again vary much

On Thursday 13 January 2011 02:40:53 Paul Mundt wrote:
> On Wed, Jan 12, 2011 at 07:04:20PM +0100, Fabio Giovagnini wrote:
> > If I set off the configuration of the cache am I sure no initialization
> > of the cache is done and during all the working time of the CPU no cache
> > is used?
> 
> Yes, rather surprisingly, disabling the cache disables the cache.

-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
