From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 13 Oct 2009 13:58:00 +0000
Subject: Re: Possibly icahe/dcache synchronization problem on sh7785lcr
Message-Id: <20091013135800.GA3124@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4ACF32C2.9010501@siemens.com>
In-Reply-To: <4ACF32C2.9010501@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 13, 2009 at 06:05:13PM +0400, Valentin R Sitsikov wrote:
> Can I create something like /arch/sh/mm/cache-sh4a.c and start hacking 
> there,for example?
> 
Yes, of course. You can make it an incremental add on on top of
cache-sh4.c in the build system, then just overload the individual
flush routines you are optimizing.

See for example how cache-sh7705.c is implemented overtop of cache-sh3.c.
