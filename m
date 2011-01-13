From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Jan 2011 01:40:53 +0000
Subject: Re: cache disabling
Message-Id: <20110113014053.GA12013@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201101121904.21051.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101121904.21051.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 12, 2011 at 07:04:20PM +0100, Fabio Giovagnini wrote:
> If I set off the configuration of the cache am I sure no initialization of the 
> cache is done and during all the working time of the CPU no cache is used?
> 
Yes, rather surprisingly, disabling the cache disables the cache.
